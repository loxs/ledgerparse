-module(ledgerparse).

%% API exports
-export([test/0]).

%%====================================================================
%% API functions
%%====================================================================

test() ->
    parse_line("2016/09/20 Some Shop Name "),
    parse_line("    Assets:Current:Wallet"),
    parse_line("    Expenses:Groceries      10 EUR"),
    parse_line("P 2016/10/23 AAAA 23.575 EUR ").

%%====================================================================
%% Internal functions
%%====================================================================
remove_trl_wtsp([{interval, _} | Tail]) ->
    remove_trl_wtsp(Tail);
remove_trl_wtsp([{separator,_,_} | Tail]) ->
    remove_trl_wtsp(Tail);
remove_trl_wtsp(Tokens) ->
    lists:reverse(Tokens).

remove_trailing_whitespace(Tokens) ->
    remove_trl_wtsp(lists:reverse(Tokens)).

pre_parse([{word, _, <<"P">>} | Tail]) ->
    [{pricetag, 1} | Tail];
pre_parse(Other) -> Other.


parse_line(String) ->
    {ok, Tokens0, _} = ledger_lexer:string(String),
    Tokens1 = remove_trailing_whitespace(Tokens0),
    Tokens2 = pre_parse(Tokens1),
    io:format("~p~n", [Tokens2]),
    {ok, AST} = ledger_parser:parse(Tokens2),
    io:format("~p~n", [AST]),
    AST.
