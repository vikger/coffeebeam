-module(numop).

-export([int/2]).

int(A, B) ->
    {A + B, A - B, A * B, A / B, A div B, A rem B}.
