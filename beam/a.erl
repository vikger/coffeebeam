-module(a).

-export([call/1, test/1, newproc/1, list/0, listlength/1]).

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
