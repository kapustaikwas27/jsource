1:@:(dbr bind Debug)@:(9!:19)2^_44[(prolog [ echo^:ECHOFILENAME) './g5x6.ijs'
NB. 5!:6 ----------------------------------------------------------------

lr=: 5!:5
pr=: 5!:6

sumsq=: +/ @: *:
xtx  =: |: ((+/) .*) ]

'+/@:*:'         -: lr <'sumsq'
'(+/)@:*:'       -: pr <'sumsq'

'|: +/ .* ]'     -: lr <'xtx'
'|: ((+/) .*) ]' -: pr <'xtx'

4!:55 ;:'lr pr sumsq xtx'



epilog''

