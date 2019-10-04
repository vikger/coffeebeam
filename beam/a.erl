-module(a).

-export([call/1, test/1, newproc/1, list/0, listlength/1, sending/0, tuple/1]).

call(_) ->
    b:call().

test(a) ->
    ok.

newproc(X) ->
    spawn(io, format, ["~p", [X]]).

list() ->
    [a, 1, "s"].

listlength([_ | T]) ->
    1 + listlength(T);
listlength([]) ->
    0.

sending() ->
    Pid = spawn(fun() -> receive X -> X end end),
    Pid ! message.

tuple(T0) ->
    T1 = {a,b,c, T0},
    T2 = setelement(1, T1, x),
    element(1, T2).
