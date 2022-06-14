prolog './g3x12a.ijs'
NB. 3!:12 ----------------------------------------------------------------

NB. benchmark for 3!:12

S1=: a.
S2=: (300$AlphaNum_j_) (300{.I.0=|?2000#5)}2000#' '
S3=: (300$AlphaNum_j_) (300{.I.0=|?2000#200)}2000#' '

ToLower=: 3 : 0`((((97+i.26){a.)(65+i.26)}a.) {~ a. i. ])@.(2 = 3!:0)
x=. I. 26 > n=. ((65+i.26){a.) i. t=. ,y
($y) $ ((x{n) { (97+i.26){a.) x}t
)

ToUpper=: 3 : 0`((((65+i.26){a.)(97+i.26)}a.) {~ a. i. ])@.(2 = 3!:0)
x=. I. 26 > n=. ((97+i.26){a.) i. t=. ,y
($y) $ ((x{n) { (65+i.26){a.) x}t
)

tolower1=: ToLower^:(2 131072 262144 e.~ 3!:0)
tolower2=: 0&(3!:12)^:(2 131072 262144 e.~ 3!:0)
toupper1=: ToUpper^:(2 131072 262144 e.~ 3!:0)
toupper2=: 1&(3!:12)^:(2 131072 262144 e.~ 3!:0)

test1=: 4 : 0

A=. 3#<900000 17$x
B=. 3#<255{."1[ 900000 111$x
C=. 3#<_255{."1[ 900000 111$x
A1=. 3#<u: 900000 17$x
B1=. 3#<255{."1[ u: 900000 111$x
C1=. 3#<_255{."1[ u: 900000 111$x
A2=. 3#<10&u: 900000 17$x
B2=. 3#<255{."1[ 10&u: 900000 111$x
C2=. 3#<_255{."1[ 10&u: 900000 111$x

if. 0=y do.
case1=. tolower1 f.
case2=. tolower2 f.
else.
case1=. toupper1 f.
case2=. toupper2 f.
end.

fn=. y{::' lower';' upper'
echo 'short literal',fn
echo 20&(6!:2) 'PA=. case1&.> A'
echo 20&(6!:2) 'QA=. case2&.> A'
assert. (PA-:QA)
echo 'long literal',fn
echo 5&(6!:2) 'PB=. case1&.> B'
echo 10&(6!:2) 'QB=. case2&.> B'
echo 5&(6!:2) 'PC=. case1&.> C'
echo 10&(6!:2) 'QC=. case2&.> C'
assert. (PB-:QB)
assert. (PC-:QC)

echo 'short literal2',fn
echo (6!:2) 'PA1=. case1&.> A1'
echo 4&(6!:2) 'QA1=. case2&.> A1'
assert. (PA1-:QA1)
echo 'long literal2',fn
echo (6!:2) 'PB1=. case1&.> B1'
echo 2&(6!:2) 'QB1=. case2&.> B1'
echo (6!:2) 'PB1=. case1&.> C1'
echo 2&(6!:2) 'QB1=. case2&.> C1'
assert. (PB1-:QB1)
assert. (PC1-:QC1)

echo 'short literal4',fn
echo (6!:2) 'PA2=. case1&.> A2'
echo 4&(6!:2) 'QA2=. case2&.> A2'
assert. (PA2-:QA2)
echo 'long literal4',fn
echo (6!:2) 'PB2=. case1&.> B2'
echo 2&(6!:2) 'QB2=. case2&.> B2'
echo (6!:2) 'PB2=. case1&.> C2'
echo 2&(6!:2) 'QB2=. case2&.> C2'
assert. (PC2-:QC2)
''
)

S1 test1 0
S2 test1 0
S3 test1 0
S1 test1 1
S2 test1 1
S3 test1 1

4!:55 ;:'ToLower tolower1 tolower2 ToUpper toupper1 toupper2 S1 S2 S3 test1'

epilog''
