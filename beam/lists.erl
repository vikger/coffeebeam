-module(lists).

-export([
         all/2,
         any/2,
         append/1,
         append/2,
         concat/1,
         delete/2,
         droplast/1,
         dropwhile/2,
         duplicate/2,
         filter/2,
         filtermap/2,
         flatlength/1,
         flatten/1,
         flatten/2,
         flatmap/2,
         foldl/3,
         foldr/3,
         map/2,
         reverse/1,
         reverse/2,
         seq/2,
         zip/2
        ]).

all(Pred, [H|T]) ->
    Pred(H) andalso all(Pred, T);
all(_Pred, []) ->
    true.

any(Pred, [H|T]) ->
    Pred(H) orelse any(Pred, T);
any(_Pred, []) ->
    false.

append(LL) ->
    append11(LL, []).

append11([[H|T] | LL], Acc) ->
    append11([T|LL], [H|Acc]);
append11([[] | LL], Acc) ->
    append11(LL, Acc);
append11([], Acc) ->
    reverse(Acc).

append(L1, L2) ->
    L1 ++ L2.

concat([H|T]) when is_atom(H) ->
    append(atom_to_list(H), concat(T));
concat([H|T]) when is_integer(H) ->
    append(integer_to_list(H), concat(T));
concat([H|T]) when is_float(H) ->
    append(float_to_list(H), concat(T));
concat([H|T]) when is_list(H) ->
    append(H, concat(T));
concat([]) ->
    [].

delete(H, [H|T]) ->
    T;
delete(H1, [H|T]) ->
    [H | delete(H1, T)];
delete(_, []) ->
    [].

droplast([_]) ->
    [];
droplast([H|T]) ->
    [H | droplast(T)].

dropwhile(Pred, [H|T] = L) ->
    case Pred(H) of
        true ->
            dropwhile(Pred, T);
        _ ->
            L
    end;
dropwhile(_Pred, []) ->
    [].

duplicate(0, _) ->
    [];
duplicate(N, Elem) ->
    [Elem | duplicate(N - 1, Elem)].

filter(Pred, [H|T]) ->
    case Pred(H) of
        true ->
            [H | filter(Pred, T)];
        _ ->
            filter(Pred, T)
    end;
filter(_Pred, []) ->
    [].

filtermap(Fun, List1) ->
    foldr(fun(Elem, Acc) ->
                  case Fun(Elem) of
                      false -> Acc;
                      true -> [Elem|Acc];
                      {true,Value} -> [Value|Acc]
                  end
          end, [], List1).

flatlength(DeepList) ->
    length(flatten(DeepList)).

flatmap(Fun, List1) ->
    append(map(Fun, List1)).

flatten(List) when is_list(List) ->
    do_flatten(List, []).

flatten(List, Tail) when is_list(List), is_list(Tail) ->
    do_flatten(List, Tail).

do_flatten([H|T], Tail) when is_list(H) ->
    do_flatten(H, do_flatten(T, Tail));
do_flatten([H|T], Tail) ->
    [H|do_flatten(T, Tail)];
do_flatten([], Tail) ->
    Tail.


foldl(Fun, Acc, [H|T]) ->
    foldl(Fun, Fun(H, Acc), T);
foldl(_, Acc, []) ->
    Acc.

foldr(Fun, Acc, [H|T]) ->
    Fun(H, foldr(Fun, Acc, T));
foldr(_, Acc, []) ->
    Acc.

map(F, [H|T]) ->
    [F(H) | map(F, T)];
map(_, []) ->
    [].

% nth BIF

reverse(L) ->
    reverse(L, []).

reverse([H|T], R) ->
    reverse(T, [H|R]);
reverse([], R) ->
    R.

seq(N, N) ->
    [N];
seq(N, M) ->
    [N | seq(N + 1, M)].

zip([H1|T1], [H2|T2]) ->
    [{H1, H2} | zip(T1, T2)];
zip([], []) ->
    [].
