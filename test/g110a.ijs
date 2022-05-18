prolog './g110a.ijs'
NB. B * B ---------------------------------------------------------------

x=: ?100$2
y=: ?100$2
(x*y) -: (#.x,.y){0 0 0 1
(x*y) -: (z+x)*z+y   [ z=:{.0 4.5
(x*y) -: (z*x)*z*y   [ z=:{.1 4.5
(z*y) -: (($y)$z)*y  [ z=:?2
(x*z) -: x*($x)$z    [ z=:?2

(x*y) -: (40$"0 x)*y [ x=: ?10$2    [ y=: ?10 40$2
(x*y) -: x*40$"0 y   [ x=: ?10 40$2 [ y=: ?10$2

0 0 0 1 -: 0 0 1 1 * 0 1 0 1


NB. B * I ---------------------------------------------------------------

x=: ?100$2
y=: _1e5+?100$2e5
(x*y) -: (z+x)*z+y   [ z=:{.0 4.5
(x*y) -: (z*x)*z*y   [ z=:{.1 4.5
(z*y) -: (($y)$z)*y  [ z=:?2
(x*z) -: x*($x)$z    [ z=:_1e5+?2e5

(x*y) -: (40$"0 x)*y [ x=: ?10$2    [ y=: _1e5+?10 40$2e5
(x*y) -: x*40$"0 y   [ x=: ?10 40$2 [ y=: _1e5+?10$2e5

0 0 3 _3 -: 0 0 1 1 * _4 4 3 _3
2147483647 _2147483648 -: 1 * 2147483647 _2147483648
0 0 -: 0 0 * 2147483647 _2147483648


NB. B * D ---------------------------------------------------------------

x=: ?100$2
y=: o._1e5+?100$2e5
(x*y) -: (z+x)*z+y   [ z=:{.0 4j5
(x*y) -: (z*x)*z*y   [ z=:{.1 4j5
(z*y) -: (($y)$z)*y  [ z=:?2
(x*z) -: x*($x)$z    [ z=:o._1e5+?2e5

(x*y) -: (40$"0 x)*y [ x=: ?10$2    [ y=: o._1e5+?10 40$2e5
(x*y) -: x*40$"0 y   [ x=: ?10 40$2 [ y=: o._1e5+?10$2e5

0 0 2.5 _2.5 -: 0 0 1 1 * _4.5 3.14 2.5 _2.5


NB. I * B ---------------------------------------------------------------

x=: _1e5+?100$2e5
y=: ?100$2
(x*y) -: (z+x)*z+y   [ z=:{.0 4j5
(x*y) -: (z*x)*z*y   [ z=:{.1 4j5
(z*y) -: (($y)$z)*y  [ z=:_1e5+?2e5
(x*z) -: x*($x)$z    [ z=:?2

(x*y) -: (40$"0 x)*y [ x=: _1e5+?10$2e5    [ y=: ?10 40$2
(x*y) -: x*40$"0 y   [ x=: _1e5+?10 40$2e5 [ y=: ?10$2

0 0 2.5 _2.5 -: _4.5 3.14 2.5 _2.5 * 0 0 1 1
2147483647 _2147483648 -: 2147483647 _2147483648 * 1
0 0 -: 2147483647 _2147483648 * 0 0


NB. I * I ---------------------------------------------------------------

x=: _1e5+?100$2e5
y=: _1e5+?100$2e5
(x*y) -: (z+x)*z+y   [ z=:{.0 4j5
(x*y) -: (z*x)*z*y   [ z=:{.1 4j5
(z*y) -: (($y)$z)*y  [ z=:?2e6
(x*z) -: x*($x)$z    [ z=:_1e5+?2e5

(x*y) -: (40$"0 x)*y [ x=: _1e5+?10$2e5    [ y=: _1e5+?10 40$2e5
(x*y) -: x*40$"0 y   [ x=: _1e5+?10 40$2e5 [ y=: _1e5+?10$2e5

6 _6 _6 6 -: 2 2 _2 _2 * 3 _3 3 _3
1e8 _1e8 -: 1e4*1e4 _1e4
1e10 _1e10 -: 1e5*1e5 _1e5


NB. I * D ---------------------------------------------------------------

x=: _1e5+?100$2e5
y=: o._1e5+?100$2e5
(x*y) -: (z+x)*z+y   [ z=:{.0 4j5
(x*y) -: (z*x)*z*y   [ z=:{.1 4j5
(z*y) -: (($y)$z)*y  [ z=:?2e6
(x*z) -: x*($x)$z    [ z=:o._1e5+?2e5

(x*y) -: (40$"0 x)*y [ x=: _1e5+?10$2e5    [ y=: o._1e5+?10 40$2e5
(x*y) -: x*40$"0 y   [ x=: _1e5+?10 40$2e5 [ y=: o._1e5+?10$2e5


NB. D * B ---------------------------------------------------------------

x=: o._1e5+?100$2e5
y=: ?100$2
(x*y) -: (z+x)*z+y   [ z=:{.0 4j5
(x*y) -: (z*x)*z*y   [ z=:{.1 4j5
(z*y) -: (($y)$z)*y  [ z=:o._1e5+?2e5
(x*z) -: x*($x)$z    [ z=:?2

(x*y) -: (40$"0 x)*y [ x=: o._1e5+?10$2e5    [ y=: ?10 40$2
(x*y) -: x*40$"0 y   [ x=: o._1e5+?10 40$2e5 [ y=: ?10$2


NB. D * I ---------------------------------------------------------------

x=: o._1e5+?100$2e5
y=: _1e5+?100$2e5
(x*y) -: (z+x)*z+y   [ z=:{.0 4j5
(x*y) -: (z*x)*z*y   [ z=:{.1 4j5
(z*y) -: (($y)$z)*y  [ z=:o._1e5+?2e5
(x*z) -: x*($x)$z    [ z=:_1e5+?2e5

(x*y) -: (40$"0 x)*y [ x=: o._1e5+?10$2e5    [ y=: _1e5+?10 40$2e5
(x*y) -: x*40$"0 y   [ x=: o._1e5+?10 40$2e5 [ y=: _1e5+?10$2e5


NB. D * D ---------------------------------------------------------------

x=: o._1e5+?100$2e5
y=: o._1e5+?100$2e5
(x*y) -: (z+x)*z+y   [ z=:{.0 4j5
(x*y) -: (z*x)*z*y   [ z=:{.1 4j5
(z*y) -: (($y)$z)*y  [ z=:o._1e5+?2e5
(x*z) -: x*($x)$z    [ z=:o._1e5+?2e5

(x*y) -: (40$"0 x)*y [ x=: o._1e5+?10$2e5    [ y=: o._1e5+?10 40$2e5
(x*y) -: x*40$"0 y   [ x=: o._1e5+?10 40$2e5 [ y=: o._1e5+?10$2e5

4!:55 ;:'x y z'



epilog''

