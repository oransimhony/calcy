%% Lexer
Definitions.

NUMBER = [0-9]
INT = [+|-]*{NUMBER}+
FLOAT = [+|-]*{NUMBER}+\.{NUMBER}+
IDENT = [A-Za-z_][A-Za-z0-9_]*
NEWLINE = [\n|\r\n]
IGNORE = [\s\t]

Rules.

table : {token, {table, TokenLine, list_to_atom(TokenChars)}}. 
exit : {token, {exit, TokenLine, list_to_atom(TokenChars)}}. 
{IDENT} : {token, {ident, TokenLine, list_to_atom(TokenChars)}}. 
{INT} : {token, {int, TokenLine, list_to_integer(TokenChars)}}. 
{FLOAT} : {token, {float, TokenLine, list_to_float(TokenChars)}}. 
\+ : {token, {plus, TokenLine, TokenChars}}. 
\- : {token, {minus, TokenLine, TokenChars}}. 
\* : {token, {mult, TokenLine, TokenChars}}. 
\/ : {token, {divi, TokenLine, TokenChars}}. 
\^ : {token, {pow, TokenLine, TokenChars}}. 
\= : {token, {asgn, TokenLine, TokenChars}}. 
\( : {token, {lparen, TokenLine, TokenChars}}. 
\) : {token, {rparen, TokenLine, TokenChars}}. 
{NEWLINE} : {token, {sep, TokenLine, TokenChars}}. 
\; : {token, {sep, TokenLine, TokenChars}}.
{IGNORE}+ : skip_token. 

Erlang code.