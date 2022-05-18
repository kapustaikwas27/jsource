prolog './gsco2u.ijs'
NB. s: unicode ------------------------------------------------------------------

NB. create test data set 

x=: s: (10&u: 65536+a.i. 'wxyz'),&.>/":&.>?20$123
y=: s: (10&u: 65536+a.i. 'abcd'),&.>/":&.>?20$110
a=: {. s: 10&u:' 4'

t=: (10&u:&.>) ;:'anaphoric chthonic metonymic oxymoronic sardonic'
u=: ~. s: , t ,&.>/":&.>":&.>?10$50
v=: /:/: u

i=: ?3 5 7$#u
j=: ?3 5  $#u

f=: {.s: 10&u:' '


NB. = -------------------------------------------------------------------

(=&({&u) -: =&({&v)) i
(=&({&u) -: =&({&v)) j
(=&({&u) -: =&({&v)) ,j
(=&({&u) -: =&({&v)) '' ($,) j

i (=    &({&u) -: =    &({&v)) j
i (=/   &({&u) -: =/   &({&v)) j
i (="2 1&({&u) -: ="2 1&({&v)) j

(=/  &({&u) -: =/  &({&v)) 2{.   j
(=/"1&({&u) -: =/"1&({&v)) 2{."1 j
(=/"2&({&u) -: =/"2&({&v)) 2{."2 j

(($i)$0) -: (i{u) = i{v
(($i)$0) -: (i{u) = i{a.{~?(  $u)$#a.
(($i)$0) -: (i{u) = i{    ?(  $u)$2
(($i)$0) -: (i{u) = i{    ?(  $u)$1e6
(($i)$0) -: (i{u) = i{  o.?(  $u)$1e6
(($i)$0) -: (i{u) = i{j./ ?(2,$u)$1e6
(($i)$0) -: (i{u) = i{    ?(  $u)$12000x
(($i)$0) -: (i{u) = i{ %/ ?(2,$u)$12000x

'domain error' -: =/\ etx y
'domain error' -: =/\.etx y


NB. < -------------------------------------------------------------------

q=: (<x) ,<y
x -: >0{q
y -: >1{q

i (<    &({&u) -: <    &({&v)) j
i (</   &({&u) -: </   &({&v)) j
i (<"2 1&({&u) -: <"2 1&({&v)) j

(</  &({&u) -: </  &({&v)) 2{.   j
(</"1&({&u) -: </"1&({&v)) 2{."1 j
(</"2&({&u) -: </"2&({&v)) 2{."2 j

(>@:< -: ]) i{u
(>@:< -: ]) j{u

'domain error' -: 3 < etx y
'domain error' -: y < etx 3

'domain error' -: </\ etx y
'domain error' -: </\.etx y


NB. <. ------------------------------------------------------------------

(<./    &({&u) -: {&u@(<./    &.({&v))) j
(<./  "1&({&u) -: {&u@(<./  "1&.({&v))) j
(<./  "2&({&u) -: {&u@(<./  "2&.({&v))) j

(<./\   &({&u) -: {&u@(<./\   &.({&v))) j
(<./\ "1&({&u) -: {&u@(<./\ "1&.({&v))) j
(<./\ "2&({&u) -: {&u@(<./\ "2&.({&v))) j

(<./\.  &({&u) -: {&u@(<./\.  &.({&v))) j
(<./\."1&({&u) -: {&u@(<./\."1&.({&v))) j
(<./\."2&({&u) -: {&u@(<./\."2&.({&v))) j

i (<.    &({&u) -: {&u@(<.    &.({&v))) j
i (<."2 1&({&u) -: {&u@(<."2 1&.({&v))) j

i (<./   &({&u) -: {&u@(<./   &.({&v))) j
i (<./"1 &({&u) -: {&u@(<./"1 &.({&v))) j
i (<./"2 &({&u) -: {&u@(<./"2 &.({&v))) j

'domain error' -:   <. etx y
'domain error' -: 3 <. etx y
'domain error' -: y <. etx 3


NB. <: ------------------------------------------------------------------

i (<:    &({&u) -: <:    &({&v)) j
i (<:/   &({&u) -: <:/   &({&v)) j
i (<:"2 1&({&u) -: <:"2 1&({&v)) j

(<:/  &({&u) -: <:/  &({&v)) 2{.   j
(<:/"1&({&u) -: <:/"1&({&v)) 2{."1 j
(<:/"2&({&u) -: <:/"2&({&v)) 2{."2 j

'domain error' -:   <: etx y

'domain error' -: 3 <: etx y
'domain error' -: y <: etx 3

'domain error' -: <:/\ etx y
'domain error' -: <:/\.etx y


NB. > -------------------------------------------------------------------

q=: x;y
x -: >0{q
y -: >1{q

(>a;x) -: (($x){.a) ,: x
(>y;a) -: y ,: ($y){.a

i (>    &({&u) -: >    &({&v)) j
i (>/   &({&u) -: >/   &({&v)) j
i (>"2 1&({&u) -: >"2 1&({&v)) j

(>/  &({&u) -: >/  &({&v)) 2{.   j
(>/"1&({&u) -: >/"1&({&v)) 2{."1 j
(>/"2&({&u) -: >/"2&({&v)) 2{."2 j

'domain error' -:   > etx 0   ;y
'domain error' -:   > etx 2   ;y
'domain error' -:   > etx 2.4 ;y
'domain error' -:   > etx 2j4 ;y
'domain error' -:   > etx 2r4 ;y
'domain error' -:   > etx (<2);y
'domain error' -:   > etx '22';y
'domain error' -:   > etx y   ;0
'domain error' -:   > etx y   ;2
'domain error' -:   > etx y   ;2.4
'domain error' -:   > etx y   ;2j4
'domain error' -:   > etx y   ;2r4
'domain error' -:   > etx y   ;'22'
'domain error' -:   > etx y   ;<2
'domain error' -: 3 > etx y
'domain error' -: y > etx 3

'domain error' -: 3 > etx y
'domain error' -: y > etx 3

'domain error' -: >/\ etx y
'domain error' -: >/\.etx y


NB. >. ------------------------------------------------------------------

(>./    &({&u) -: {&u@(>./    &.({&v))) j
(>./  "1&({&u) -: {&u@(>./  "1&.({&v))) j
(>./  "2&({&u) -: {&u@(>./  "2&.({&v))) j

(>./\   &({&u) -: {&u@(>./\   &.({&v))) j
(>./\ "1&({&u) -: {&u@(>./\ "1&.({&v))) j
(>./\ "2&({&u) -: {&u@(>./\ "2&.({&v))) j

(>./\.  &({&u) -: {&u@(>./\.  &.({&v))) j
(>./\."1&({&u) -: {&u@(>./\."1&.({&v))) j
(>./\."2&({&u) -: {&u@(>./\."2&.({&v))) j

i (>.    &({&u) -: {&u@(>.    &.({&v))) j
i (>."2 1&({&u) -: {&u@(>."2 1&.({&v))) j

i (>./   &({&u) -: {&u@(>./   &.({&v))) j
i (>./"1 &({&u) -: {&u@(>./"1 &.({&v))) j
i (>./"2 &({&u) -: {&u@(>./"2 &.({&v))) j

'domain error' -:   >. etx y
'domain error' -: 3 >. etx y
'domain error' -: y >. etx 3


NB. >: ------------------------------------------------------------------

i (>:    &({&u) -: >:    &({&v)) j
i (>:/   &({&u) -: >:/   &({&v)) j
i (>:"2 1&({&u) -: >:"2 1&({&v)) j

(>:/  &({&u) -: >:/  &({&v)) 2{.   j
(>:/"1&({&u) -: >:/"1&({&v)) 2{."1 j
(>:/"2&({&u) -: >:/"2&({&v)) 2{."2 j

'domain error' -:   >: etx y

'domain error' -: 3 >: etx y
'domain error' -: y >: etx 3

'domain error' -: >:/\ etx y
'domain error' -: >:/\.etx y


NB. + -------------------------------------------------------------------

'domain error' -:   + etx y

'domain error' -: 3 + etx y
'domain error' -: y + etx 3


NB. +. ------------------------------------------------------------------

'domain error' -:     +. etx y

'domain error' -: 3   +. etx y
'domain error' -: y   +. etx 3
'domain error' -: x   +. etx y


NB. +: ------------------------------------------------------------------

'domain error' -:     +: etx y

'domain error' -: 1   +: etx x
'domain error' -: x   +: etx 1


NB. - -------------------------------------------------------------------

'domain error' -:     -  etx y

'domain error' -: 3   -  etx y
'domain error' -: y   -  etx 3
'domain error' -: x   -  etx y


NB. -. ------------------------------------------------------------------

'domain error' -:     -. etx y

(s=: ?300    $#u) (-.&({&u) -: ({&u)@-.) t=: ?30    $#u
(s=: ?200 2  $#u) (-.&({&u) -: ({&u)@-.) t=: ?20 2  $#u
(s=: ?100 2 3$#u) (-.&({&u) -: ({&u)@-.) t=: ?10 2 3$#u


NB. -: ------------------------------------------------------------------

'domain error' -:     -: etx y


NB. * -------------------------------------------------------------------

'domain error' -:     *  etx y

'domain error' -: 3   *  etx y
'domain error' -: y   *  etx 3


NB. *. ------------------------------------------------------------------

'domain error' -:     *. etx y

'domain error' -: 3   *. etx y
'domain error' -: y   *. etx 3


NB. *: ------------------------------------------------------------------

'domain error' -:     *: etx y

'domain error' -: 1      *: etx f
'domain error' -: (s:' ')*: etx 1


NB. % -------------------------------------------------------------------

'domain error' -:     %  etx y

'domain error' -: 3   %  etx y
'domain error' -: y   %  etx 3
'domain error' -: x   %  etx y


NB. %. ------------------------------------------------------------------

'domain error' -: %. etx u{~?10 3$#u

'domain error' -: (?10$1e6)    %. etx u{~?10 3$#u
'domain error' -: (u{~?7 7$#u) %. etx ?7 7$1e5
'domain error' -: (u{~?7 7$#u) %. etx u{~?7 7$#u


NB. %: ------------------------------------------------------------------

'domain error' -:     %: etx y

'domain error' -: 3   %: etx y
'domain error' -: y   %: etx 3
'domain error' -: x   %: etx y


NB. ^ -------------------------------------------------------------------

'domain error' -:     ^  etx y

'domain error' -: 3   ^  etx y
'domain error' -: y   ^  etx 3
'domain error' -: x   ^  etx y


NB. ^. ------------------------------------------------------------------

'domain error' -:     ^. etx y

'domain error' -: 3   ^. etx y
'domain error' -: y   ^. etx 3
'domain error' -: x   ^. etx y


NB. ^: ------------------------------------------------------------------

'domain error' -:  ex '+:^:y 2 3'


NB. $ -------------------------------------------------------------------

($&({&u) -: $&({&v)) i
($&({&u) -: $&({&v)) j
($&({&u) -: $&({&v)) ,j
($&({&u) -: $&({&v)) '' ($,) j

2 3 4 (($ {&u) -: {&u@$) i
2 3 4 (($ {&u) -: {&u@$) j
2 3 4 (($ {&u) -: {&u@$) ,j

''    (($ {&u) -: {&u@$) i
''    (($ {&u) -: {&u@$) j
''    (($ {&u) -: {&u@$) ,j

'domain error' -: a $ etx i.4 5


NB. ~. ------------------------------------------------------------------

(~.&({&u) -: {&u&~.) i
(~.&({&u) -: {&u&~.) j
(~.&({&u) -: {&u&~.) ,j
(~.&({&u) -: {&u&~.) '' ($,) j


NB. ~: ------------------------------------------------------------------

(~:&({&u) -: ~:&({&v)) i
(~:&({&u) -: ~:&({&v)) j
(~:&({&u) -: ~:&({&v)) ,j
(~:&({&u) -: ~:&({&v)) '' ($,) j

i (~: &({&u) -: ~: &({&v)) j
i (~:/&({&u) -: ~:/&({&v)) j

i (~:"2 1&({&u) -: ~:"2 1&({&v)) j

(($i)$1) -: (i{u) ~: i{v
(($i)$1) -: (i{u) ~: i{a.{~?(  $u)$#a.
(($i)$1) -: (i{u) ~: i{    ?(  $u)$2
(($i)$1) -: (i{u) ~: i{    ?(  $u)$1e6
(($i)$1) -: (i{u) ~: i{  o.?(  $u)$1e6
(($i)$1) -: (i{u) ~: i{j./ ?(2,$u)$1e6
(($i)$1) -: (i{u) ~: i{    ?(  $u)$12000x
(($i)$1) -: (i{u) ~: i{ %/ ?(2,$u)$12000x

'domain error' -: ~:/\ etx y
'domain error' -: ~:/\.etx y


NB. | -------------------------------------------------------------------

'domain error' -:   | etx y

'domain error' -: 3 | etx y
'domain error' -: y | etx 3
'domain error' -: x | etx y


NB. |. ------------------------------------------------------------------

(|.  &({&u) -: ({&u)&(|.  )) i
(|.  &({&u) -: ({&u)&(|.  )) j
(|."1&({&u) -: ({&u)&(|."1)) i
(|."1&({&u) -: ({&u)&(|."1)) j
(|."2&({&u) -: ({&u)&(|."2)) i
(|."2&({&u) -: ({&u)&(|."2)) j

3    ((|.   {&u) -: ({&u)@:(|.  )) ?31 2 5  $#u
3    ((|.   {&u) -: ({&u)@:(|.  )) ?31 2 5 7$#u
3    ((|."1 {&u) -: ({&u)@:(|."1)) ?31 2 5  $#u
3    ((|."1 {&u) -: ({&u)@:(|."1)) ?31 2 5 7$#u
3 _1 ((|."2 {&u) -: ({&u)@:(|."2)) ?31 2 5  $#u
3 _1 ((|."2 {&u) -: ({&u)@:(|."2)) ?31 2 5 7$#u

'domain error' -: a |. etx i.4 5


NB. : -------------------------------------------------------------------

'domain error' -: ex 'a : ''o.y.'''
'domain error' -: ex '3 : y'


NB. , -------------------------------------------------------------------

(,&({&u) -: {&u@,) i
(,&({&u) -: {&u@,) j
(,&({&u) -: {&u@,) '' ($,) j

i (,&({&u) -: {&(f,u)@,&:>:) j
(,i) (,&({&u) -: {&u@,) ,j

'domain error' -: 0   ,  etx y
'domain error' -: 2   ,  etx y
'domain error' -: 2.4 ,  etx y
'domain error' -: 2j4 ,  etx y
'domain error' -: 2x  ,  etx y
'domain error' -: 2r4 ,  etx y
'domain error' -: '3' ,  etx y
'domain error' -: (<3),  etx y

'domain error' -: y   ,  etx 0
'domain error' -: y   ,  etx 2
'domain error' -: y   ,  etx 2.4
'domain error' -: y   ,  etx 2j4
'domain error' -: y   ,  etx 2x
'domain error' -: y   ,  etx 2r4
'domain error' -: y   ,  etx '3'
'domain error' -: y   ,  etx <3


NB. ,. ------------------------------------------------------------------

i (,&({&u) -: {&(f,u)@,&:>:) j

'domain error' -: 0   ,. etx y
'domain error' -: 2   ,. etx y
'domain error' -: 2.4 ,. etx y
'domain error' -: 2j4 ,. etx y
'domain error' -: 2x  ,. etx y
'domain error' -: 2r4 ,. etx y
'domain error' -: '3' ,. etx y
'domain error' -: (<3),. etx y

'domain error' -: y   ,. etx 0
'domain error' -: y   ,. etx 2
'domain error' -: y   ,. etx 2.4
'domain error' -: y   ,. etx 2j4
'domain error' -: y   ,. etx 2x
'domain error' -: y   ,. etx 2r4
'domain error' -: y   ,. etx '3'
'domain error' -: y   ,. etx <3


NB. ,: ------------------------------------------------------------------

'domain error' -: 0   ,: etx y
'domain error' -: 2   ,: etx y
'domain error' -: 2.4 ,: etx y
'domain error' -: 2j4 ,: etx y
'domain error' -: 2x  ,: etx y
'domain error' -: 2r4 ,: etx y
'domain error' -: '3' ,: etx y
'domain error' -: (<3),: etx y

'domain error' -: y   ,: etx 0
'domain error' -: y   ,: etx 2
'domain error' -: y   ,: etx 2.4
'domain error' -: y   ,: etx 2j4
'domain error' -: y   ,: etx 2x
'domain error' -: y   ,: etx 2r4
'domain error' -: y   ,: etx '3'
'domain error' -: y   ,: etx <3


NB. ; -------------------------------------------------------------------

'domain error' -: ; etx 0   ;y
'domain error' -: ; etx 2   ;y
'domain error' -: ; etx 2.4 ;y
'domain error' -: ; etx 2j4 ;y
'domain error' -: ; etx 2r4 ;y
'domain error' -: ; etx (<2);y
'domain error' -: ; etx '22';y

'domain error' -: ; etx y   ;0
'domain error' -: ; etx y   ;2
'domain error' -: ; etx y   ;2.4
'domain error' -: ; etx y   ;2j4
'domain error' -: ; etx y   ;2r4
'domain error' -: ; etx y   ;'22'
'domain error' -: ; etx y   ;<2


NB. ;. ------------------------------------------------------------------

(<;.1@({&u) -: {&u&.>@(<;.1)) ?5000$#u

(< ;. 1@({&u) -: {&u&.> @( <;. 1)    ) ,i
(# ;. 1@({&u) -:         ( #;. 1)    ) ,i
({.;. 1@({&u) -: {&u    @({.;. 1)    ) ,i
( ,;. 1@({&u) -: {&(f,u)@( ,;. 1)@:>:) ,i
( ];. 1@({&u) -: {&(f,u)@( ];. 1)@:>:) ,i

(< ;._1@({&u) -: {&u&.> @( <;._1)    ) ,i
(# ;._1@({&u) -:         ( #;._1)    ) ,i
( ,;._1@({&u) -: {&(f,u)@( ,;._1)@:>:) ,i
( ];._1@({&u) -: {&(f,u)@( ];._1)@:>:) ,i

(< ;. 2@({&u) -: {&u&.> @( <;. 2)    ) ,i
(# ;. 2@({&u) -:         ( #;. 2)    ) ,i
({.;. 2@({&u) -: {&u    @({.;. 2)    ) ,i
( ,;. 2@({&u) -: {&(f,u)@( ,;. 2)@:>:) ,i
( ];. 2@({&u) -: {&(f,u)@( ];. 2)@:>:) ,i

(< ;._2@({&u) -: {&u&.> @( <;._2)    ) ,i
(# ;._2@({&u) -:         ( #;._2)    ) ,i
( ,;._2@({&u) -: {&(f,u)@( ,;._2)@:>:) ,i
( ];._2@({&u) -: {&(f,u)@( ];._2)@:>:) ,i


NB. # -------------------------------------------------------------------

(#&({&u) -: #&({&v)) i
(#&({&u) -: #&({&v)) j

(?(0{$i)$5) ((#      {&u) -: {&u@: #      ) i
(?(1{$i)$5) ((#"1 _1 {&u) -: {&u@:(#"1 _1)) i

((3#0{t),(4#f),5#1{t) -: 3j4 5#t=: 0 1{u

'domain error' -: a # etx 3
'domain error' -: a # etx y
'domain error' -: a # etx y


NB. #. ------------------------------------------------------------------

'domain error' -:   #. etx y

'domain error' -: 3 #. etx y
'domain error' -: y #. etx 3
'domain error' -: x #. etx y


NB. #: ------------------------------------------------------------------

'domain error' -:   #: etx y

'domain error' -: 3 #: etx y
'domain error' -: y #: etx 3
'domain error' -: x #: etx y


NB. ! -------------------------------------------------------------------

'domain error' -:   ! etx y

'domain error' -: 3 ! etx y
'domain error' -: y ! etx 3
'domain error' -: x ! etx y


NB. !. ------------------------------------------------------------------

'domain error' -: ex '=!.({.a)'


NB. !: ------------------------------------------------------------------

65536 = 3!:0 i{u

(i{u) -: 3!:2 (3!:1) i{u
(i{u) -: 3!:2 (3!:3) i{u

(-: 3!:2 @(   3!:1 )) x
(-: 3!:2 @(   3!:1 )) y
(-: 3!:2 @(   3!:1 )) a
(-: 3!:2 @(   3!:1 )) f

(-: 3!:2 @(   3!:1 )) 1 2 3;x
(-: 3!:2 @(   3!:1 )) x;1 2 3
(-: 3!:2 @(   3!:1 )) (5 s: x);<<<<x
(-: 3!:2 @(   3!:1 )) a;x

(-: 3!:2 @(0&(3!:1))) x
(-: 3!:2 @(0&(3!:1))) y
(-: 3!:2 @(0&(3!:1))) a
(-: 3!:2 @(0&(3!:1))) f

(-: 3!:2 @(1&(3!:1))) x
(-: 3!:2 @(1&(3!:1))) y
(-: 3!:2 @(1&(3!:1))) a
(-: 3!:2 @(1&(3!:1))) f

(-: 3!:2 @(   3!:3 )) x
(-: 3!:2 @(   3!:3 )) y
(-: 3!:2 @(   3!:3 )) a
(-: 3!:2 @(   3!:3 )) f

x -: (5!:1 <'x') 5!:0
y -: (5!:1 <'y') 5!:0
a -: (5!:1 <'a') 5!:0
f -: (5!:1 <'f') 5!:0

t -: ". 5!:5 <'t' [ t=: '' ($,) u
t -: ". 5!:5 <'t' [ t=: i{u
t -: ". 5!:5 <'t' [ t=: f

'domain error' -: ex 'a!:3'
'domain error' -: ex 'a!:y'
'domain error' -: ex '3!:a'


NB. /: ------------------------------------------------------------------

(/: -: /:&(5&s:)) u
(/: -: /:&(5&s:)) (?1000$#u){u
(/: -: /:&(5&s:)) (?1000$#x){x

(/:&({&u) -: /:&({&v)) t=: ?300    $#u
(/:&({&u) -: /:&({&v)) t=: ?200   3$#u
(/:&({&u) -: /:&({&v)) t=: ?100 2 3$#u

(/:~&({&u) -: (/:@({&v) { {&u)) t=: ?300    $#u
(/:~&({&u) -: (/:@({&v) { {&u)) t=: ?200   3$#u
(/:~&({&u) -: (/:@({&v) { {&u)) t=: ?100 2 3$#u

t=: s: '';'ab';('ab',0{a.);('ab',0 0{a.);'ab ';'ab  ';'ab   '
(/:"1 -: /:"1&({&t)) k=: (? 31&$) #t

q=: 0 1 0;(s: ' 0 1 0');'010';<<"0 '010'
p=: (i.!#q) A. i.#q
(/:"1 p) -:   /: "1 p{q
q        -:"1 /:~"1 p{q


NB. \: ------------------------------------------------------------------

(\:&({&u) -: \:&({&v)) t=: ?300    $#u
(\:&({&u) -: \:&({&v)) t=: ?200   3$#u
(\:&({&u) -: \:&({&v)) t=: ?100 2 3$#u

(\:~&({&u) -: (\:@({&v) { {&u)) t=: ?300    $#u
(\:~&({&u) -: (\:@({&v) { {&u)) t=: ?200   3$#u
(\:~&({&u) -: (\:@({&v) { {&u)) t=: ?100 2 3$#u

t=: s: '';'ab';('ab',0{a.);('ab',0 0{a.);'ab ';'ab  ';'ab   '
(\:"1 -: \:"1&({&t)) k=: (? 31&$) #t

q=: 0 1 0;(s: ' 0 1 0');'010';<<"0 '010'
p=: (i.!#q) A. i.#q
(\:"1 p) -:   \: "1 p{q
(|.q)    -:"1 \:~"1 p{q


NB. { -------------------------------------------------------------------

'domain error' -: { etx 0   ;y
'domain error' -: { etx 2   ;y
'domain error' -: { etx 2.4 ;y
'domain error' -: { etx 2j4 ;y
'domain error' -: { etx 2r4 ;y
'domain error' -: { etx (<2);y
'domain error' -: { etx '22';y
'domain error' -: { etx y   ;0
'domain error' -: { etx y   ;2
'domain error' -: { etx y   ;2.4
'domain error' -: { etx y   ;2j4
'domain error' -: { etx y   ;2r4
'domain error' -: { etx y   ;'22'
'domain error' -: { etx y   ;<2


NB. {. ------------------------------------------------------------------

((3 ($,)u), 2$f) -:  5{.3 ($,) u
((3 ($,)u),~2$f) -: _5{.3 ($,) u

'domain error' -: a {. etx i.12


NB. }. ------------------------------------------------------------------

'domain error' -: a }. etx i.12


NB. ". ------------------------------------------------------------------

'domain error' -:   ". etx x

'domain error' -: 3 ". etx x
'domain error' -: a ". etx '3142'


NB. ": ------------------------------------------------------------------

2 -: 3!:0 ":x
(1>.#$x) -: #$ ":x

'domain error' -: 3 ": etx x
'domain error' -: a ": etx i.3 4


NB. ? -------------------------------------------------------------------

'domain error' -:     ?  etx y

'domain error' -: 3   ?  etx y
'domain error' -: y   ?  etx 3
'domain error' -: x   ?  etx y


NB. ?. ------------------------------------------------------------------

'domain error' -:     ?. etx y

'domain error' -: 3   ?. etx y
'domain error' -: y   ?. etx 3
'domain error' -: x   ?. etx y

NB. A. ------------------------------------------------------------------

'domain error' -:   A. etx y

'domain error' -: y A. etx 3
'domain error' -: x A. etx y


NB. C. ------------------------------------------------------------------

'domain error' -:   C. etx y

'domain error' -: y C. etx 3
'domain error' -: x C. etx y


NB. e. ------------------------------------------------------------------

i (e.&({&u) -: e.&({&v)) i
t (e.&({&u) -: e.&({&v)) (?#t) A. t=: ?100 2 3$#u
t (e.&({&u) -: e.&({&v))~(?2 3 4$#t){t
j (e.&({&u) -: e.&({&v)) j

(2 3$0) -: (i{u) e.~t=: ?(2 3,}.$i)$#i
(2 3$0) -: (i{u) e.~t=:  (2 3,}.$i)$'xyz'


NB. i. ------------------------------------------------------------------

i (i.&({&u) -: i.&({&v)) i
t (i.&({&u) -: i.&({&v)) (?#t) A. t=: ?100 2 3$#u
t (i.&({&u) -: i.&({&v)) (?2 3 4$#t){t
j (i.&({&u) -: i.&({&v)) j

(2 3$#i) -: (i{u) i. t=: ?(2 3,}.$i)$#i
(2 3$#i) -: (i{u) i. t=:  (2 3,}.$i)$'xyz'

(,i) (i.&({&u) -: i.&({&v))"_ 0 (?20 10$*/$i){,i

'domain error' -: i. etx i{u


NB. i: ------------------------------------------------------------------

i (i:&({&u) -: i:&({&v)) i
t (i:&({&u) -: i:&({&v)) (?#t) A. t=: ?100 2 3$#u
t (i:&({&u) -: i:&({&v)) (?2 3 4$#t){t
j (i:&({&u) -: i:&({&v)) j

(2 3$#i) -: (i{u) i: t=: ?(2 3,}.$i)$#i
(2 3$#i) -: (i{u) i: t=:  (2 3,}.$i)$'xyz'

(,i) (i:&({&u) -: i:&({&v))"_ 0 (?20 10$*/$i){,i

'domain error' -: i: etx i{u


NB. j. ------------------------------------------------------------------

'domain error' -:   j. etx y

'domain error' -: 3 j. etx y
'domain error' -: y j. etx 3
'domain error' -: x j. etx y


NB. o. ------------------------------------------------------------------

'domain error' -:   o. etx y

'domain error' -: 3 o. etx y
'domain error' -: y o. etx 3
'domain error' -: x o. etx y


NB. p. ------------------------------------------------------------------

'domain error' -:   p. etx y

'domain error' -: 3 p. etx y
'domain error' -: y p. etx 3
'domain error' -: x p. etx y


NB. p: ------------------------------------------------------------------

'domain error' -:   p: etx y


NB. q: ------------------------------------------------------------------

'domain error' -:   q: etx y

'domain error' -: 3 q: etx y
'domain error' -: y q: etx 3
'domain error' -: x q: etx y


NB. r. ------------------------------------------------------------------

'domain error' -:   r. etx y

'domain error' -: 3 r. etx y
'domain error' -: y r. etx 3
'domain error' -: x r. etx y


NB. x: ------------------------------------------------------------------

'domain error' -:   x: etx y

'domain error' -: y x: etx 3
'domain error' -: 3 x: etx y
'domain error' -: x x: etx y

0 s: 11

4!:55 ;:'a f i j k p q s t u v x y'



epilog''

