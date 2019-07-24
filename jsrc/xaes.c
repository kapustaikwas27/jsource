/* Copyright 1990-2006, Jsoftware Inc.  All rights reserved.               */
/* Licensed use only. Any other use is in violation of copyright.          */
/*                                                                         */
/* Xenos: AES calculation                                                  */

#include "j.h"
#include "x.h"

#include "aes.h"

#include <string.h>
#ifdef _MSC_VER
#define strncasecmp _strnicmp
#define strcasecmp _stricmp
#endif

int aes_c(I decrypt,I mode,UC *key,I keyn,UC* iv,UC* out,I n);
#if !defined(ANDROID) && (defined(__i386__) || defined(_M_X64) || defined(__x86_64__))
int aes_ni(I decrypt,I mode,UC *key,I keyn,UC* iv,UC* out,I n);
#endif

/*
  mode
  0    ECB
  1    CBC
  2    CTR
 */
F2(jtaes2)
{
  I n,decrypt,keyn,mode=1;
  int n1,padding=1;
  A z,*av,dec;
  UC *out,*key,*iv;
  F2RANK(1,1,jtaes2,0);  // do rank loop if necessary
  ASSERT(AT(a)&BOX,EVDOMAIN);
  ASSERT(1>=AR(a),EVRANK);
  ASSERT(AN(a)>=3&&AN(a)<=4,EVLENGTH);
  av=AAV(a);
  ASSERT(1>=AR(av[0]),EVRANK);
  RZ(dec=vi(av[0]));
  ASSERT(AN(dec)==1,EVDOMAIN);
  decrypt=(AV(dec))[0];
  ASSERT(decrypt==0||decrypt==1,EVDOMAIN);
  ASSERT(AT(av[1])&LIT,EVDOMAIN);
  ASSERT(1>=AR(av[1]),EVRANK);
  key=UAV(av[1]);
  keyn=AN(av[1]);
  ASSERT(keyn==16||keyn==24||keyn==32,EVDOMAIN);
  ASSERT(AT(av[2])&LIT,EVDOMAIN);
  ASSERT(1>=AR(av[2]),EVRANK);
  iv=UAV(av[2]);
  ASSERT(AN(av[2])==16,EVDOMAIN);
  if(AN(a)>3) {
    ASSERT(AT(av[3])&LIT,EVDOMAIN);
    ASSERT(1>=AR(av[3]),EVRANK);
    ASSERT(3==AN(av[3])||9==AN(av[3]),EVDOMAIN);
    if(3==AN(av[3])) {
      mode=(!strncasecmp(CAV(av[3]),"ECB",AN(av[3])))?0:(!strncasecmp(CAV(av[3]),"CBC",AN(av[3])))?1:(!strncasecmp(CAV(av[3]),"CTR",AN(av[3])))?2:-1;
    } else {
      padding=0;
      mode=(!strncasecmp(CAV(av[3]),"ECB NOPAD",AN(av[3])))?0:(!strncasecmp(CAV(av[3]),"CBC NOPAD",AN(av[3])))?1:(!strncasecmp(CAV(av[3]),"CTR NOPAD",AN(av[3])))?2:-1;
    }
    ASSERT(mode!=-1,EVDOMAIN);
  }
  n=AN(w);
  ASSERT(!n||AT(w)&LIT,EVDOMAIN);
  ASSERT(!n||1>=AR(w),EVRANK);
  if(decrypt) {
    ASSERT(n||!padding,EVLENGTH);
    ASSERT(!n||0==n%16,EVLENGTH);
  } else {
    if(!(n1=n%16)&&padding)n+=16;
    if(n1)n+=16-n1;
  }
  ASSERT(0==(n%16),EVDOMAIN);
  GATV0(z,LIT,n,1);
  out=UAV(z);
  if(!n)R z;
  MC(out,CAV(w),AN(w));
  if(!decrypt) {
    if(padding) {
      if(n1)memset(out+n-(16-n1),16-n1,16-n1);
      else memset(out+n-16,16,16);
    } else if(n1)memset(out+n-(16-n1),0,16-n1);
  }
#if !defined(ANDROID) && (defined(__i386__) || defined(_M_X64) || defined(__x86_64__))
  if(hwaes) {
    ASSERT(!aes_ni(decrypt,mode,key,keyn,iv,out,n),EVDOMAIN);
  } else {
    ASSERT(!aes_c(decrypt,mode,key,keyn,iv,out,n),EVDOMAIN);
  }
#else
  ASSERT(!aes_c(decrypt,mode,key,keyn,iv,out,n),EVDOMAIN);
#endif
  if(decrypt&&padding) {
    n1=out[n-1];
    ASSERT(n1&&n1<=16,EVDOMAIN);
    for(int i=n1; i>0; i--)ASSERT(n1==out[n-i],EVDOMAIN);
    *(AS(z))=AN(z)=n-n1;
    memset(out+n-n1,0,n1);
  }
  R z;
}

/*
  mode
  0    ECB
  1    CBC
  2    CTR
 */
// iv must be 16-byte wide
// out buffer of n bytes and n must be 16-byte block
// out buffer will be overwritten
int aes_c(I decrypt,I mode,UC *key,I keyn,UC* iv,UC* out,I n)
{
  switch(keyn) {
  case 16: {
    struct AES_ctx_128 ctx;
    switch(mode) {
    case 0:
      AES_init_ctx_128(&ctx, key);
      if(decrypt) {
        for(I i=0; i<n/16; i++) AES_ECB_decrypt_128(&ctx, out+i*16);
      } else {
        for(I i=0; i<n/16; i++) AES_ECB_encrypt_128(&ctx, out+i*16);
      }
      break;

    case 1:
      AES_init_ctx_iv_128(&ctx, key, iv);
      if(decrypt) AES_CBC_decrypt_buffer_128(&ctx, out, n);
      else AES_CBC_encrypt_buffer_128(&ctx, out, n);
      break;

    case 2:
      AES_init_ctx_iv_128(&ctx, key, iv);
      AES_CTR_xcrypt_buffer_128(&ctx, out, n);
      break;

    default:
      R 1;

    }
  }
  break;

  case 24: {
    struct AES_ctx_192 ctx;
    switch(mode) {
    case 0:
      AES_init_ctx_192(&ctx, key);
      if(decrypt) {
        for(I i=0; i<n/16; i++) AES_ECB_decrypt_192(&ctx, out+i*16);
      } else {
        for(I i=0; i<n/16; i++) AES_ECB_encrypt_192(&ctx, out+i*16);
      }
      break;

    case 1:
      AES_init_ctx_iv_192(&ctx, key, iv);
      if(decrypt) AES_CBC_decrypt_buffer_192(&ctx, out, n);
      else AES_CBC_encrypt_buffer_192(&ctx, out, n);
      break;

    case 2:
      AES_init_ctx_iv_192(&ctx, key, iv);
      AES_CTR_xcrypt_buffer_192(&ctx, out, n);
      break;

    default:
      R 1;

    }
  }
  break;

  case 32: {
    struct AES_ctx_256 ctx;
    switch(mode) {
    case 0:
      AES_init_ctx_256(&ctx, key);
      if(decrypt) {
        for(I i=0; i<n/16; i++) AES_ECB_decrypt_256(&ctx, out+i*16);
      } else {
        for(I i=0; i<n/16; i++) AES_ECB_encrypt_256(&ctx, out+i*16);
      }
      break;

    case 1:
      AES_init_ctx_iv_256(&ctx, key, iv);
      if(decrypt) AES_CBC_decrypt_buffer_256(&ctx, out, n);
      else AES_CBC_encrypt_buffer_256(&ctx, out, n);
      break;

    case 2:
      AES_init_ctx_iv_256(&ctx, key, iv);
      AES_CTR_xcrypt_buffer_256(&ctx, out, n);
      break;

    default:
      R 1;

    }
  }
  break;

  default:
    R 1;
  }
  R 0;  // success
}
