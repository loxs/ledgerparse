-module(ledgerparse).

%% API exports
-export([test/0]).

%%====================================================================
%% API functions
%%====================================================================

test() ->
    parse_line("2016/09/20 Some Shop Name "),
    parse_line("    Assets:Current:Wallet"),
    parse_line("    Expenses:Groceries      10 EUR").

parse_line(String) ->
    {ok, Tokens, _} = ledger_lexer:string(String),
    io:format("~p~n", [Tokens]),
    AST = ledger_parser:parse(Tokens),
    io:format("~p~n", [AST]),
    AST.


%%====================================================================
%% Internal functions
%%====================================================================
