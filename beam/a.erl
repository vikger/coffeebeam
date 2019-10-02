-module(a).

-export([call/1, test/1]).

call(_) ->
    b:call().

test(a) ->
    ok.
