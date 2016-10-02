Definitions.

NEWLINE = [\n\r]
INT = \-?[0-9]+
FLOAT = \-[0-9]+(\.[0-9]+)?
SEPARATOR = (\s\s|\s\t|\t)[\s\t]*
WORD = [A-Za-z0-9]+

Rules.

{NEWLINE}+     : skip_token.
\s             : {token, {interval, TokenLine}}.
{SEPARATOR}    : {token, {separator, TokenLine, TokenLen}}.
\/             : {token, {'/', TokenLine}}.
\:             : {token, {':', TokenLine}}.
{INT}          : {token, {int, TokenLine, list_to_integer(TokenChars)}}.
{FLOAT}        : {token, {float, TokenLine, list_to_float(TokenChars)}}.
{WORD}         : {token, {word, TokenLine, list_to_binary(TokenChars)}}.

Erlang code.
