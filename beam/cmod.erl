-module(cmod).
-export([case_clause/1, if_clause/1, is_f/1, fadd/1, fadd/2, is_f_helper/0]).

case_clause(X) ->
    case X of
	a ->
	    ok
    end.

if_clause(X) ->
    if
	X =:= 1 ->
	    ok
    end.

is_f(F) when is_function(F) ->
    function;
is_f(_) ->
    not_function.

fadd(X) ->
    X + 1.0.

fadd(X, Y) ->
    X + Y.

is_f_helper() ->
    F = fun() -> ok end,
    is_f(F).
