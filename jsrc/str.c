/* Copyright (c) 1990-2022, Jsoftware Inc.  All rights reserved.           */
/* Licensed use only. Any other use is in violation of copyright.          */
/*                                                                         */
/* string utiliy                                                           */

#include "j.h"

#include <stddef.h>
#include <ctype.h>

extern void StringToLower(char *str,size_t len);
extern void StringToUpper(char *str,size_t len);
extern void StringToLowerUCS2(unsigned short *str,size_t len);
extern void StringToUpperUCS2(unsigned short *str,size_t len);
extern void StringToLowerUCS4(unsigned int *str,size_t len);
extern void StringToUpperUCS4(unsigned int *str,size_t len);
extern size_t Stringrchr(char *str,char ch, size_t stride,size_t len);
extern size_t Stringrchr2(unsigned short *str, unsigned short ch, size_t stride,size_t len);
extern size_t Stringrchr4(unsigned int *str, unsigned int ch, size_t stride,size_t len);

static size_t srchr(char* str, char ch, size_t len){
 size_t i=len;

#if C_AVX2 || EMU_AVX2
 // align to 32 bytes
 while ((i>0) && ((((intptr_t)str+i) & 31) != 0)){if (ch!=str[i-1]) return i; else --i;}
/* don't test i>=0 which is always true because size_t is unsigned */
 const __m256i xmm0 = _mm256_set1_epi8( ch );
 const __m256i xmm2 = _mm256_set1_epi8( 0xff );
 while (i > 32) {
  // search for ch
  int mask = 0;
   __m256i xmm1 = _mm256_load_si256((__m256i *)(str+i-32));
   xmm1 = _mm256_andnot_si256(_mm256_cmpeq_epi8(xmm1, xmm0),xmm2);
   if ((mask = _mm256_movemask_epi8(xmm1)) != 0) {   // some character is not ch
    // got 0 somewhere within 32 bytes in xmm1, or within 32 bits in mask
    // find index of last set bit
#if (MMSC_VER)   // make sure <intrin.h> is included
    unsigned long pos;
    _BitScanBackward(&pos, mask);
    i -= (size_t)pos;
#elif defined(__clang__) || ((__GNUC__ >= 4) || ((__GNUC__ == 3) && (__GNUC_MINOR__ >= 4))) // modern GCC has built-in __builtin_ctz
    i -= __builtin_clz(mask);
#else  // none of choices exist, use local BSR implementation
#error __builtin_clz
#endif
    return i;
  }
  i -= 32;
 }
#endif

#if defined(__SSE2__) || EMU_AVX
 // align to 16 bytes
 while ((i>0) && ((((intptr_t)str+i) & 15) != 0)){if (ch!=str[i-1]) return i; else --i;}
 while (i > 16) {
  const __m128i xmm0 = _mm_set1_epi8( ch );
  const __m128i xmm2 = _mm_set1_epi8( 0xff );
  // search for ch
  int mask = 0;
   __m128i xmm1 = _mm_load_si128((__m128i *)(str+i-16));
   xmm1 = _mm_andnot_si128(_mm_cmpeq_epi8(xmm1, xmm0),xmm2);
   if ((mask = _mm_movemask_epi8(xmm1)) != 0) {   // some character is not ch
    // got 0 somewhere within 16 bytes in xmm1, or within 16 bits in mask
    // find index of last set bit
#if (MMSC_VER)   // make sure <intrin.h> is included
    unsigned long pos;
    _BitScanBackward(&pos, mask);
    i -= (size_t)pos-16;
#elif defined(__clang__) || ((__GNUC__ >= 4) || ((__GNUC__ == 3) && (__GNUC_MINOR__ >= 4))) // modern GCC has built-in __builtin_ctz
    i -= __builtin_clz(mask)-16;  // mask is 32-bits but only lower 16-bits are significant
#else  // none of choices exist, use local BSR implementation
#error __builtin_clz
#endif
    return i;
  }
  i -= 16;
 }
#endif

 while (i>0){if (ch!=str[i-1]) return i; else --i;}
 return 0;
}

static size_t srchr2(unsigned short* str, unsigned short ch, size_t len){
 size_t i=len;

#if C_AVX2 || EMU_AVX2
 // align to 32 bytes
 while ((i>0) && ((((intptr_t)str+i) & 31) != 0)){if (ch!=str[i-1]) return i; else --i;}
/* don't test i>=0 which is always true because size_t is unsigned */
 const __m256i xmm0 = _mm256_set1_epi16( ch );
 const __m256i xmm2 = _mm256_set1_epi16( 0xffff );
 while (i > 16) {
  // search for ch
  int mask = 0;
   __m256i xmm1 = _mm256_load_si256((__m256i *)(str+i-16));
   xmm1 = _mm256_andnot_si256(_mm256_cmpeq_epi16(xmm1, xmm0),xmm2);
   // no such thing as _mm256_movemask_epi16
   // Shift each 16-bit element to the right by 8 bits, zero-filling the upper
   // bits.  This will remove the leading high byte from coming up in the mask
   // we generate below, allowing us to use popcount to get the number of slots
   // to compare in the subsequent step.
   if ((mask = _mm256_movemask_epi8(_mm256_srli_epi16(xmm1, 8))) != 0) {   // some character is not ch
    // got 0 somewhere within 32 bytes in xmm1, or within 32 bits in mask
    // find index of last set bit
#if (MMSC_VER)   // make sure <intrin.h> is included
    unsigned long pos;
    _BitScanBackward(&pos, mask);
    i -= ((size_t)pos)>>1;
#elif defined(__clang__) || ((__GNUC__ >= 4) || ((__GNUC__ == 3) && (__GNUC_MINOR__ >= 4))) // modern GCC has built-in __builtin_ctz
    i -= (__builtin_clz(mask))>>1;
#else  // none of choices exist, use local BSR implementation
#error __builtin_clz
#endif
    return i;
  }
  i -= 16;
 }
#endif

#if defined(__SSE2__) || EMU_AVX
 // align to 16 bytes
 while ((i>0) && ((((intptr_t)str+i) & 15) != 0)){if (ch!=str[i-1]) return i; else --i;}
 while (i > 8) {
  const __m128i xmm0 = _mm_set1_epi16( ch );
  const __m128i xmm2 = _mm_set1_epi16( 0xffff );
  // search for ch
  int mask = 0;
   __m128i xmm1 = _mm_load_si128((__m128i *)(str+i-8));
   xmm1 = _mm_andnot_si128(_mm_cmpeq_epi16(xmm1, xmm0),xmm2);
   if ((mask = _mm_movemask_epi8(_mm_slli_epi16(xmm1, 8))) != 0) {   // some character is not ch
    // got 0 somewhere within 16 bytes in xmm1, or within 16 bits in mask
    // find index of last set bit
#if (MMSC_VER)   // make sure <intrin.h> is included
    unsigned long pos;
    _BitScanBackward(&pos, mask);
    i -= ((size_t)pos-16)>>1;
#elif defined(__clang__) || ((__GNUC__ >= 4) || ((__GNUC__ == 3) && (__GNUC_MINOR__ >= 4))) // modern GCC has built-in __builtin_ctz
    i -= (__builtin_clz(mask)-16)>>1;  // mask is 32-bits but only lower 16-bits are significant
#else  // none of choices exist, use local BSR implementation
#error __builtin_clz
#endif
    return i;
  }
  i -= 8;
 }
#endif

 while (i>0){if (ch!=str[i-1]) return i; else --i;}
 return 0;
}

static size_t srchr4(unsigned int* str, unsigned int ch, size_t len){
 size_t i=len;

#if C_AVX2 || EMU_AVX2
 // align to 32 bytes
 while ((i>0) && ((((intptr_t)str+i) & 31) != 0)){if (ch!=str[i-1]) return i; else --i;}
/* don't test i>=0 which is always true because size_t is unsigned */
 const __m256i xmm0 = _mm256_set1_epi32( ch );
 const __m256i xmm2 = _mm256_set1_epi32( 0xffffffff );
 while (i > 8) {
  // search for ch
  int mask = 0;
   __m256i xmm1 = _mm256_load_si256((__m256i *)(str+i-8));
   xmm1 = _mm256_andnot_si256(_mm256_cmpeq_epi32(xmm1, xmm0),xmm2);
   // no such thing as _mm256_movemask_epi32
   // Shift each 16-bit element to the right by 8 bits, zero-filling the upper
   // bits.  This will remove the leading high byte from coming up in the mask
   // we generate below, allowing us to use popcount to get the number of slots
   // to compare in the subsequent step.
   if ((mask = _mm256_movemask_epi8(_mm256_srli_epi32(xmm1, 24))) != 0) {   // some character is not ch
    // got 0 somewhere within 32 bytes in xmm1, or within 32 bits in mask
    // find index of last set bit
#if (MMSC_VER)   // make sure <intrin.h> is included
    unsigned long pos;
    _BitScanBackward(&pos, mask);
    i -= ((size_t)pos)>>2;
#elif defined(__clang__) || ((__GNUC__ >= 4) || ((__GNUC__ == 3) && (__GNUC_MINOR__ >= 4))) // modern GCC has built-in __builtin_ctz
    i -= (__builtin_clz(mask))>>2;
#else  // none of choices exist, use local BSR implementation
#error __builtin_clz
#endif
    return i;
  }
  i -= 8;
 }
#endif

#if defined(__SSE2__) || EMU_AVX
 // align to 16 bytes
 while ((i>0) && ((((intptr_t)str+i) & 15) != 0)){if (ch!=str[i-1]) return i; else --i;}
 while (i > 4) {
  const __m128i xmm0 = _mm_set1_epi32( ch );
  const __m128i xmm2 = _mm_set1_epi32( 0xffffffff );
  // search for ch
  int mask = 0;
   __m128i xmm1 = _mm_load_si128((__m128i *)(str+i-4));
   xmm1 = _mm_andnot_si128(_mm_cmpeq_epi32(xmm1, xmm0),xmm2);
   if ((mask = _mm_movemask_epi8(_mm_slli_epi32(xmm1, 24))) != 0) {   // some character is not ch
    // got 0 somewhere within 16 bytes in xmm1, or within 16 bits in mask
    // find index of last set bit
#if (MMSC_VER)   // make sure <intrin.h> is included
    unsigned long pos;
    _BitScanBackward(&pos, mask);
    i -= ((size_t)pos-16)>>2;
#elif defined(__clang__) || ((__GNUC__ >= 4) || ((__GNUC__ == 3) && (__GNUC_MINOR__ >= 4))) // modern GCC has built-in __builtin_ctz
    i -= (__builtin_clz(mask)-16)>>2;  // mask is 32-bits but only lower 16-bits are significant
#else  // none of choices exist, use local BSR implementation
#error __builtin_clz
#endif
    return i;
  }
  i -= 4;
 }
#endif

 while (i>0){if (ch!=str[i-1]) return i; else --i;}
 return 0;
}

#if defined(__SSE2__) || EMU_AVX

/* A SIMD function for SSE2 which changes all uppercase ASCII digits to lowercase. */
void StringToLower(char *str,size_t len){
 // align to 16 bytes
 while ((len>0) && ((((intptr_t)str) & 15) != 0)) {
  *str = tolower(*str);
  len--;
  ++str;
 }
 while (len >= 16) {
 __m128i r0 = _mm_load_si128((__m128i*)str);
 // maskaz contains 0x00 where character between 'A' and 'Z', 0xff otherwise.
 __m128i maskaz = _mm_or_si128(_mm_cmplt_epi8(r0, _mm_set1_epi8( 'A' )), _mm_cmpgt_epi8(r0, _mm_set1_epi8( 'Z' )));
 // flip the 6th bit to 0 only for uppercase characters.
  _mm_store_si128((__m128i*)str, _mm_xor_si128(r0, _mm_andnot_si128(maskaz, _mm_set1_epi8(0x20))));
  len -= 16;
  str += 16;
 }
 while (len-- > 0) {
  *str = tolower(*str);
  ++str;
 }
}

/* Same, but to uppercase. */
void StringToUpper(char *str,size_t len){
 // align to 16 bytes
 while ((len>0) && ((((intptr_t)str) & 15) != 0)) {
  *str = toupper(*str);
  len--;
  ++str;
 }
 while (len >= 16) {
 __m128i r0 = _mm_load_si128((__m128i*)str);
 // maskaz contains 0x00 where character between 'a' and 'z', 0xff otherwise.
 __m128i maskaz = _mm_or_si128(_mm_cmplt_epi8(r0, _mm_set1_epi8( 'a' )), _mm_cmpgt_epi8(r0, _mm_set1_epi8( 'z' )));
 // flip the 6th bit to 0 only for lowercase characters.
 _mm_store_si128((__m128i*)str, _mm_xor_si128(r0, _mm_andnot_si128(maskaz, _mm_set1_epi8(0x20))));
  len -= 16;
  str += 16;
 }
 while (len-- > 0) {
  *str = toupper(*str);
  ++str;
 }
}
#elif defined(__ARM_NEON) || defined(__ARM_NEON__)
#include <arm_neon.h>

/* Literally the exact same code as above, but for NEON. */
void StringToLower(char *str,size_t len){
 const uint8x16_t asciiA = vdupq_n_u8('A' - 1);
 const uint8x16_t asciiZ = vdupq_n_u8('Z' + 1);
 const uint8x16_t diff = vdupq_n_u8('a' - 'A');
 while (len >= 16) {
  uint8x16_t inp = vld1q_u8((uint8_t *)str);
  uint8x16_t greaterThanA = vcgtq_u8(inp, asciiA);
  uint8x16_t lessEqualZ = vcltq_u8(inp, asciiZ);
  uint8x16_t mask = vandq_u8(greaterThanA, lessEqualZ);
  uint8x16_t toAdd = vandq_u8(mask, diff);
  uint8x16_t added = vaddq_u8(inp, toAdd);
  vst1q_u8((uint8_t *)str, added);
  len -= 16;
  str += 16;
 }
 while (len-- > 0) {
  *str = tolower(*str);
  ++str;
 }
}

/* Literally the exact same code as above, but for NEON. */
void StringToUpper(char *str,size_t len){
 const uint8x16_t asciia = vdupq_n_u8('a' - 1);
 const uint8x16_t asciiz = vdupq_n_u8('z' + 1);
 const uint8x16_t diff = vdupq_n_u8('a' - 'A');
 while (len >= 16) {
  uint8x16_t inp = vld1q_u8((uint8_t *)str);
  uint8x16_t greaterThana = vcgtq_u8(inp, asciia);
  uint8x16_t lessEqualz = vcltq_u8(inp, asciiz);
  uint8x16_t mask = vandq_u8(greaterThana, lessEqualz);
  uint8x16_t toSub = vandq_u8(mask, diff);
  uint8x16_t added = vsubq_u8(inp, toSub);
  vst1q_u8((uint8_t *)str, added);
  len -= 16;
  str += 16;
 }
 while (len-- > 0) {
  *str = toupper(*str);
  ++str;
 }
}
#else
/* Just go scalar. */
void StringToLower(char *str,size_t len){
 while (len-- > 0) {
  *str = tolower(*str);
  ++str;
 }
}

void StringToUpper(char *str,size_t len){
 while (len-- > 0) {
  *str = toupper(*str);
  ++str;
 }
}
#endif

#if defined(__SSE2__) || EMU_AVX

/* A SIMD function for SSE2 which changes all uppercase ASCII digits to lowercase. */
void StringToLowerUCS2(unsigned short *str,size_t len){
 const char OFFSET = 'a' - 'A';
 // align to 16 bytes
 while ((len>0) && ((((intptr_t)str) & 15) != 0)) {
  *str = (*str>= 'A' && *str<= 'Z') ? *str += OFFSET : *str;
  len--;
  ++str;
 }
 while (len >= 8) {
 __m128i r0 = _mm_load_si128((__m128i*)str);
 // maskaz contains 0x00 where character between 'A' and 'Z', 0xff otherwise.
 __m128i maskaz = _mm_or_si128(_mm_cmplt_epi16(r0, _mm_set1_epi16( 'A' )), _mm_cmpgt_epi16(r0, _mm_set1_epi16( 'Z' )));
 // flip the 6th bit to 0 only for uppercase characters.
  _mm_store_si128((__m128i*)str, _mm_xor_si128(r0, _mm_andnot_si128(maskaz, _mm_set1_epi16(0x20))));
  len -= 8;
  str += 8;
 }
 while (len-- > 0) {
  *str = (*str>= 'A' && *str<= 'Z') ? *str += OFFSET : *str;
  ++str;
 }
}

/* Same, but to uppercase. */
void StringToUpperUCS2(unsigned short *str,size_t len){
 const char OFFSET = 'a' - 'A';
 // align to 16 bytes
 while ((len>0) && ((((intptr_t)str) & 15) != 0)) {
  *str = (*str>= 'a' && *str<= 'z') ? *str -= OFFSET : *str;
  len--;
  ++str;
 }
 while (len >= 8) {
 __m128i r0 = _mm_load_si128((__m128i*)str);
 // maskaz contains 0x00 where character between 'a' and 'z', 0xff otherwise.
 __m128i maskaz = _mm_or_si128(_mm_cmplt_epi16(r0, _mm_set1_epi16( 'a' )), _mm_cmpgt_epi16(r0, _mm_set1_epi16( 'z' )));
 // flip the 6th bit to 0 only for lowercase characters.
 _mm_store_si128((__m128i*)str, _mm_xor_si128(r0, _mm_andnot_si128(maskaz, _mm_set1_epi16(0x20))));
  len -= 8;
  str += 8;
 }
 while (len-- > 0) {
  *str = (*str>= 'a' && *str<= 'z') ? *str -= OFFSET : *str;
  ++str;
 }
}
#else
void StringToLowerUCS2(unsigned short *str,size_t len){
 const char OFFSET = 'a' - 'A';
 while (len-- > 0) {
  *str= (*str>= 'A' && *str<= 'Z') ? *str += OFFSET : *str;
  ++str;
 }
}

void StringToUpperUCS2(unsigned short *str,size_t len){
 const char OFFSET = 'a' - 'A';
 while (len-- > 0) {
  *str= (*str>= 'a' && *str<= 'z') ? *str -= OFFSET : *str;
  ++str;
 }
}
#endif

#if defined(__SSE2__) || EMU_AVX

/* A SIMD function for SSE2 which changes all uppercase ASCII digits to lowercase. */
void StringToLowerUCS4(unsigned int *str,size_t len){
 const char OFFSET = 'a' - 'A';
 // align to 16 bytes
 while ((len>0) && ((((intptr_t)str) & 15) != 0)) {
  *str = (*str>= 'A' && *str<= 'Z') ? *str += OFFSET : *str;
  len--;
  ++str;
 }
 while (len >= 4) {
 __m128i r0 = _mm_load_si128((__m128i*)str);
 // maskaz contains 0x00 where character between 'A' and 'Z', 0xff otherwise.
 __m128i maskaz = _mm_or_si128(_mm_cmplt_epi32(r0, _mm_set1_epi32( 'A' )), _mm_cmpgt_epi32(r0, _mm_set1_epi32( 'Z' )));
 // flip the 6th bit to 0 only for uppercase characters.
  _mm_store_si128((__m128i*)str, _mm_xor_si128(r0, _mm_andnot_si128(maskaz, _mm_set1_epi32(0x20))));
  len -= 4;
  str += 4;
 }
 while (len-- > 0) {
  *str = (*str>= 'A' && *str<= 'Z') ? *str += OFFSET : *str;
  ++str;
 }
}

/* Same, but to uppercase. */
void StringToUpperUCS4(unsigned int *str,size_t len){
 const char OFFSET = 'a' - 'A';
 // align to 16 bytes
 while ((len>0) && ((((intptr_t)str) & 15) != 0)) {
  *str = (*str>= 'a' && *str<= 'z') ? *str -= OFFSET : *str;
  len--;
  ++str;
 }
 while (len >= 4) {
 __m128i r0 = _mm_load_si128((__m128i*)str);
 // maskaz contains 0x00 where character between 'a' and 'z', 0xff otherwise.
 __m128i maskaz = _mm_or_si128(_mm_cmplt_epi32(r0, _mm_set1_epi32( 'a' )), _mm_cmpgt_epi32(r0, _mm_set1_epi32( 'z' )));
 // flip the 6th bit to 0 only for lowercase characters.
 _mm_store_si128((__m128i*)str, _mm_xor_si128(r0, _mm_andnot_si128(maskaz, _mm_set1_epi32(0x20))));
  len -= 4;
  str += 4;
 }
 while (len-- > 0) {
  *str = (*str>= 'a' && *str<= 'z') ? *str -= OFFSET : *str;
  ++str;
 }
}
#else
void StringToLowerUCS4(unsigned int *str,size_t len){
 const char OFFSET = 'a' - 'A';
 while (len-- > 0) {
  *str= (*str>= 'A' && *str<= 'Z') ? *str += OFFSET : *str;
  ++str;
 }
}

void StringToUpperUCS4(unsigned int *str,size_t len){
 const char OFFSET = 'a' - 'A';
 while (len-- > 0) {
  *str= (*str>= 'a' && *str<= 'z') ? *str -= OFFSET : *str;
  ++str;
 }
}
#endif

size_t Stringrchr(char *str, char ch, size_t stride, size_t len){
 size_t i=len,ln=0;
 while (i-- > 0) {
  size_t l=srchr(str,ch,stride);
  ln=(ln<l)?l:ln;
  if(ln==stride) return ln;
  str+=stride;
 }
 return ln;
}

size_t Stringrchr2(unsigned short *str, unsigned short ch, size_t stride, size_t len){
 size_t i=len,ln=0;
 while (i-- > 0) {
  size_t l=srchr2(str,ch,stride);
  ln=(ln<l)?l:ln;
  if(ln==stride) return ln;
  str+=stride;
 }
 return ln;
}

size_t Stringrchr4(unsigned int *str, unsigned int ch, size_t stride, size_t len){
 size_t i=len,ln=0;
 while (i-- > 0) {
  size_t l=srchr4(str,ch,stride);
  ln=(ln<l)?l:ln;
  if(ln==stride) return ln;
  str+=stride;
 }
 return ln;
}