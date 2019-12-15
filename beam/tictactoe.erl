
-module(tictactoe).

-export([start/0, new_game/1, put/3]).

start() ->
    spawn(fun() -> init() end).

new_game(GamePid) ->
    GamePid ! new_game.

put(GamePid, X, Y) ->
    GamePid ! {put, X, Y}.

init() ->
    Board = init_board(),
    update(new_game, Board),
    loop(Board, player, 0).

loop(Board, _, 9) ->
    update(draw, Board),
    end_game();
loop(Board, player, N) ->
    receive
        {put, X, Y} ->
            case get(Board, X, Y) of
                e ->
                    Board1 = put(Board, X, Y, x),
                    case is_winner(Board1, x) of
                        true ->
                            update(win, Board1),
                            end_game();
                        false ->
                            update(put_player, Board1),
                            loop(Board1, computer, N + 1)
                    end;
                _ ->
                    update(invalid, Board),
                    loop(Board, player, N)
            end;
        new_game ->
            init()
    end;
loop(Board, computer, N) ->
    Checks = [check(Board, X, Y) || X <- [1, 2, 3], Y <- [1, 2, 3]],
    beamclient:debug(Checks),
    {X, Y} = find_max(Checks),
    beamclient:debug({X, Y}),
    Board1 = put(Board, X, Y, o),
    case is_winner(Board1, o) of
        true ->
            update(lose, Board1),
	    end_game();
        false ->
            update(put_computer, Board1),
            loop(Board1, player, N + 1)
    end.

end_game() ->
    receive
        new_game ->
            init();
        _ ->
            end_game()
    end.

find_max([Check | Checks]) ->
    find_max1(Checks, Check).
find_max1([{X1, Y1, N1} | Checks], {_, _, N}) when N1 > N ->
    find_max1(Checks, {X1, Y1, N1});
find_max1([_ | Checks], Max) ->
    find_max1(Checks, Max);
find_max1([], {X, Y, _N}) ->
    {X, Y}.

check(Board, X, Y) ->
    case get(Board, X, Y) of
	e ->
	    Board1 = put(Board, X, Y, o),
	    Value = calculate(Board1, X, Y),
	    {X, Y, Value};
	_ ->
	    {X, Y, 0}
    end.

calculate(Board, X, Y) ->
    case is_winner(Board, o) of
	true ->
	    10000;
	false ->
	    calc(get_row(Board, Y)) + calc(get_col(Board, X)) + calc(get_diag1(Board, X, Y)) + calc(get_diag2(Board, X, Y))
    end.

calc(invalid) ->
    0;
calc([Diag1, Diag2]) ->
    calc(Diag1) + calc(Diag2);
calc([o, o, e]) ->
    100;
calc([o, e, o]) ->
    100;
calc([e, o, o]) ->
    100;
calc([o, e, e]) ->
    10;
calc([e, o, e]) ->
    10;
calc([e, e, o]) ->
    10;
calc([o, x, x]) ->
    1000;
calc([x, o, x]) ->
    1000;
calc([x, x, o]) ->
    1000;
calc(_) ->
    1.

get_row(Board, Y) ->
    [get(Board, 1, Y), get(Board, 2, Y), get(Board, 3, Y)].

get_col(Board, X) ->
    [get(Board, X, 1), get(Board, X, 2), get(Board, X, 3)].

get_diag1(Board, 1, 1) ->
    do_get_diag1(Board);
get_diag1(Board, 2, 2) ->
    do_get_diag1(Board);
get_diag1(Board, 3, 3) ->
    do_get_diag1(Board);
get_diag1(_, _, _) ->
    invalid.

do_get_diag1(Board) ->
    [get(Board, 1, 1), get(Board, 2, 2), get(Board, 3, 3)].

get_diag2(Board, 1, 3) ->
    do_get_diag2(Board);
get_diag2(Board, 2, 2) ->
    do_get_diag2(Board);
get_diag2(Board, 3, 1) ->
    do_get_diag2(Board);
get_diag2(_, _, _) ->
    invalid.

do_get_diag2(Board) ->
    [get(Board, 3, 1), get(Board, 2, 2), get(Board, 1, 3)].

update(Event, Board) ->
    beamclient:update({Event, Board}).
%    print(Board),
%    io:format("Event: ~p~n", [Event]).

print([[V1, V2, V3],
       [V4, V5, V6],
       [V7, V8, V9]]) ->
    io:format("~p~p~p~n~p~p~p~n~p~p~p~n", [V1, V2, V3, V4, V5, V6, V7, V8, V9]).

init_board() ->
    duplicate(3, duplicate(3, e)).

put([R | Rs], Col, 1, Symbol) ->
    [put1(R, Col, Symbol) | Rs];
put([R | Rs], Col, Row, Symbol) ->
    [R | put(Rs, Col, Row - 1, Symbol)].

put1([_ | Cs], 1, Symbol) ->
    [Symbol | Cs];
put1([C | Cs], Col, Symbol) ->
    [C | put1(Cs, Col - 1, Symbol)].

get(Board, Col, Row) when Col >= 1, Col =< 3, Row >= 1, Row =< 3 ->
    nth(Col, nth(Row, Board));
get(_, _, _) ->
    invalid.

is_winner(Board, Symbol) ->
    all_row(Board, Symbol) orelse all_col(Board, Symbol) orelse all_diag(Board, Symbol).

all_row(Board, Symbol) ->
    all(Board, [{1, 1}, {2, 1}, {3, 1}], Symbol) orelse
	all(Board, [{1, 2}, {2, 2}, {3, 2}], Symbol) orelse
	all(Board, [{1, 3}, {2, 3}, {3, 3}], Symbol).

all_col(Board, Symbol) ->
    all(Board, [{1, 1}, {1, 2}, {1, 3}], Symbol) orelse
	all(Board, [{2, 1}, {2, 2}, {2, 3}], Symbol) orelse
	all(Board, [{3, 1}, {3, 2}, {3, 3}], Symbol).

all_diag(Board, Symbol) ->
    all(Board, [{1, 1}, {2, 2}, {3, 3}], Symbol) orelse
	all(Board, [{3, 1}, {2, 2}, {1, 3}], Symbol).

all(Board, [{X, Y} | Rest], Symbol) ->
    get(Board, X, Y) =:= Symbol andalso
	all(Board, Rest, Symbol);
all(_, [], _) ->
    true.

% List functions

duplicate(0, _) ->
    [];
duplicate(N, Item) ->
    [Item | duplicate(N - 1, Item)].

nth(1, [Item | _]) ->
    Item;
nth(N, [_ | Items]) ->
    nth(N - 1, Items).
