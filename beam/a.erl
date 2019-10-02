-module(a).

-export([call/1]).

call(_) ->
    b:call().
