-module(numop).

-export([int/2, int2/2, relation/3, and_or_not/3]).

int(A, B) ->
    {A + B, A - B, A * B, A / B, A div B, A rem B}.

int2(A, B) ->
    {A bsl B, A bsr B, A band B, A bor B, A bxor B, bnot A}.

and_or_not(A, B, C) ->
    (A and B) or (not C).

relation(A, B, C) ->
    ((A =< B) and (A < C)) or ((A >= B) andalso (B > C)) orelse ((A == C) and (B =:= C)).
