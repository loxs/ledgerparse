Nonterminals label number 'date' whitespace account
             commodity_and_value price_declaration
             entry transaction_head transaction_line.

Terminals '/' ':' 'int' 'float' 'interval' 'separator' 'word' pricetag.

Rootsymbol entry.

entry -> transaction_head : {transaction_head, '$1'}.
entry -> transaction_line : {transaction_line, '$1'}.
entry -> price_declaration : {price_declaration, '$1'}.

transaction_head -> date interval label : {'$1', '$3'}.

transaction_line -> whitespace account separator commodity_and_value : {'$2', '$4'}.
transaction_line -> whitespace account : {'$2'}.

price_declaration -> pricetag interval date interval word interval commodity_and_value
                         : {value_of('$5'), '$3', '$7'}.

account -> label : ['$1'].
account -> label ':' account : ['$1' | '$3' ].

label -> word : join([value_of('$1')]).
label -> word interval label : join([value_of('$1'), <<" ">> | '$3']).

commodity_and_value -> number interval word : {'$1', value_of('$3')}.

date -> int '/' int '/' int : {value_of('$1'), value_of('$3'), value_of('$5')}.

number -> 'int' : value_of('$1').
number -> 'float' : value_of('$1').

whitespace -> interval  : '$1'.
whitespace -> separator : '$1'.


Erlang code.

value_of(Token) ->
    element(3, Token).

join(IOList) ->
    erlang:iolist_to_binary(IOList).
