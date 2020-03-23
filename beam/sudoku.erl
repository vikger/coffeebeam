-module(sudoku).

-export([start/0, new_game/1, put/4, values/3]).

start() ->
    spawn(fun () -> init() end).

new_game(GamePid) ->
    GamePid ! {self(), new_game},
    receive
        Grid ->
            Grid
    end.

put(GamePid, Row, Col, Value) ->
    GamePid ! {self(), {put, Row, Col, Value}},
    receive
        Response ->
            Response
    end.

values(GamePid, Row, Col) ->
    GamePid ! {self(), {values, Row, Col}},
    receive
        Response ->
            Response
    end.

init() ->
    self() ! generate_spare,
    loop(sudoku_logic:exercise(30), no_spare).

loop({Grid, Solution} = Exercise, Spare) ->
    receive
        {Pid, {put, Row, Col, Value}} ->
            case sudoku_logic:is_valid(Grid, Row, Col, Value) of
                true ->
                    NewGrid = sudoku_logic:put(Grid, Row, Col, Value),
                    Pid ! NewGrid,
                    loop({NewGrid, Solution}, Spare);
                false ->
                    Pid ! invalid,
                    loop(Exercise, Spare)
            end;
        {Pid, {values, Row, Col}} ->
            case sudoku_logic:get(Grid, Row, Col) of
                0 ->
                    Pid ! sudoku_logic:possible_values(Grid, Row, Col);
                _ ->
                    Pid ! []
            end,
            loop(Exercise, Spare);
        generate_spare ->
            loop(Exercise, sudoku_logic:exercise(30));
        {Pid, new_game} ->
            Pid ! Spare,
            self() ! generate_spare,
            loop(Spare, no_spare)
    end.
