1:@:(dbr bind Debug)@:(9!:19)2^_44[(prolog [ echo^:ECHOFILENAME) './g110s.ijs'
NB. */\. B --------------------------------------------------------------

(_20{.1) -: */\._20{.1
(20$1) -: */\.20$1

times=: 4 : 'x*y'

f=: 3 : '(*/\. -: times/\.) y ?@ $2'
,f"1 x=:7 8 9,."0 1 [ _1 0 1+  255
,f"1 |."1 x
,f"1 x=:7 8 9,."0 1 [ _1 0 1+4*255
,f"1 |."1 x


NB. */\. I --------------------------------------------------------------

(!>:i.10) -: */\.&.|. >:i.10

times=: 4 : 'x*y'

(*/\. -: times/\.) x=:1 2 3 1e5 2e5
(*/\. -: times/\.) |.x

(*/\.   -: times/\.  ) x=:_30*?    7$60
(*/\.   -: times/\.  ) x=:_30*?4   7$60
(*/\."1 -: times/\."1) x
(*/\.   -: times/\.  ) x=:_30*?7 5 7$60
(*/\."1 -: times/\."1) x
(*/\."2 -: times/\."2) x

(*/\.   -: times/\.  ) x=:_1e9*?    23$2e9
(*/\.   -: times/\.  ) x=:_1e9*?4   23$2e9
(*/\."1 -: times/\."1) x
(*/\.   -: times/\.  ) x=:_1e9*?7 5 23$2e9
(*/\."1 -: times/\."1) x
(*/\."2 -: times/\."2) x


NB. */\. D --------------------------------------------------------------

(!>:i.10) -: */\.&.|. [&.o. >:i.10

times=: 4 : 'x*y'

(*/\.   -: times/\.  ) x=:0.01*_1e4*?    23$2e4
(*/\.   -: times/\.  ) x=:0.01*_1e4*?4   23$2e4
(*/\."1 -: times/\."1) x
(*/\.   -: times/\.  ) x=:0.01*_1e4*?7 5 23$2e4
(*/\."1 -: times/\."1) x
(*/\."2 -: times/\."2) x


NB. */\. Z --------------------------------------------------------------

(!>:i.10) -: */\.&.|. [&.j. >:i.10

times=: 4 : 'x*y'

(*/\.   -: times/\.  ) x=:j./0.1*_1e2*?2     23$2e2
(*/\.   -: times/\.  ) x=:j./0.1*_1e2*?2 4   23$2e2
(*/\."1 -: times/\."1) x
(*/\.   -: times/\.  ) x=:j./0.1*_1e2*?2 7 5 23$2e2
(*/\."1 -: times/\."1) x
(*/\."2 -: times/\."2) x

'domain error' -: */\. etx 'deipnosophist'
'domain error' -: */\. etx ;:'sui generis'
'domain error' -: */\. etx u:'deipnosophist'
'domain error' -: */\. etx u:&.> ;:'sui generis'
'domain error' -: */\. etx 10&u:'deipnosophist'
'domain error' -: */\. etx 10&u:&.> ;:'sui generis'
'domain error' -: */\. etx s:@<"0 'deipnosophist'
'domain error' -: */\. etx s:@<"0&.> ;:'sui generis'
'domain error' -: */\. etx <"0@s: ;:'sui generis'

4!:55 ;:'f times x'



epilog''

