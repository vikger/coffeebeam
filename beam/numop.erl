-module(numop).

-export([int/2, int2/2]).

int(A, B) ->
    {A + B, A - B, A * B, A / B, A div B, A rem B}.

int2(A, B) ->
    {A bsl B, A bsr B, A band B, A bor B, A bxor B, bnot A}.
