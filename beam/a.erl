-module(a).

-export([call/1, test/1, newproc/1, list/0, listlength/1, sending/0, tuple/1, map/1, funs/0]).

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
    E = element(2, T2),
    T3 = tuple1(T2, E),
    {T0, T1, T2, T3}.

tuple1(T, E) ->
    setelement(3, T, E).

map(X) ->
    #{X => X, a => 1, b => 2, c => 3}.

funs() ->
    F = fun(X) -> X + 1 end,
    lists:map(F, [1, 2, 3]).
