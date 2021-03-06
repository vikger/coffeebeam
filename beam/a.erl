-module(a).

-export([call/1, test/1, newproc/1, list/0, sending/0, tuple/1, map/1, funs/1, all/1, any/1, sendrecv/0, bignum1/0, bignum2/0, bignum3/0, append/2]).

call(_) ->
    test(b:call()).

test(a) ->
    ok.

newproc(X) ->
    spawn(io, format, ["~p", [X]]).

list() ->
    [a, 1].

sending() ->
    Pid = spawn(fun() -> receive X -> X end end),
    Pid ! message.

sendrecv() ->
    Pid = spawn(fun() -> receive {Pid, message1} -> Pid ! message2 end end),
    Pid ! {self(), message1},
    receive
        X ->
            X
    end.

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

funs(L) ->
    F = fun(X) -> X + 1 end,
    lists:map(F, L).

all(L) ->
    lists:all(fun
                  (a) -> true;
                  (_) -> false end, L).

any(L) ->
    lists:any(fun (a) ->
                      true;
                  (_) ->
                      false end, L).

append(A, B) ->
    A ++ B.

bignum1() ->
    [12345678910111213141516,
     -12345678910111213141516,
     12345678910111213141516171819202222232425].

bignum2() ->
    -12345678910111213141516.

bignum3() ->
    102030405060708090100110120130.
