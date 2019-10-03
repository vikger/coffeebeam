-module(lists).

-export([
         all/2,
         append/1,
         append/2
        ]).

all(_Pred, []) ->
    true;
all(Pred, [H|T]) ->
    case Pred(H) of
        true ->
            all(Pred, T);
        false ->
            false
    end.

append([[H|T] | LL]) ->
    [H | append([T | LL])];
append([[] | LL]) ->
    append(LL);
append([]) ->
    [].

append([H|T], L) ->
    [H | append(T, L)];
append([], L) ->
    L.
