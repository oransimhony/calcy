Nonterminals
root expression term number factor assignment lines line.

Terminals
int float plus minus mult divi pow asgn lparen rparen ident sep stack exit.

Rootsymbol root.

root -> lines : '$1'.

lines -> line : '$1'.
lines -> line sep lines : ['$1', '$3'].

line -> expression : '$1'.
line -> assignment : '$1'.
line -> stack : { stack }. 
line -> exit : { exit }. 
line -> '$empty' : [] . 

expression -> term : '$1'.
expression -> expression plus term : { plus, '$1', '$3' }.
expression -> expression minus term : { minus, '$1', '$3' }.

assignment -> ident asgn expression : { assign, unwrap('$1'), '$3' }.

term -> term mult number : { mult, '$1', '$3' }.
term -> term divi number : { divi, '$1', '$3' }.
term -> number : '$1'.

number -> factor pow factor : { pow, '$1', '$3' }. 
number -> factor : '$1'. 

factor -> ident : { ident, unwrap('$1') }.
factor -> int : { int, unwrap('$1') }.
factor -> float : { float, unwrap('$1') }.
factor -> lparen expression rparen: '$2'. 

Erlang code.

unwrap({_token,_line,Value}) -> Value.
