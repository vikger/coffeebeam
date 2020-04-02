-module(sudoku_logic).

-export([get/3, put/4, is_valid/4, possible_values/3, exercise/1, check_grid/1]).

get(Grid, Row, Col) ->
    lists:nth(Col, lists:nth(Row, Grid)).

put(Grid, Row, Col, Value) ->
    set(Grid, Row, set(get_row(Grid, Row), Col, Value)).

set([_ | List], 1, Value) ->
    [Value | List];
set([Item | List], N, Value) ->
    [Item | set(List, N - 1, Value)].

is_valid(Grid, Row, Col, Value) ->
    lists:member(Value, possible_values(Grid, Row, Col)).

shuffle(List) ->
    shuffle(List, length(List)).

shuffle([], _) ->
    [];
shuffle(List, Len) ->
    {Item, Rest} = value(List, rand:uniform(Len)),
    [Item | shuffle(Rest, Len - 1)].

value(List, N) ->
    value(List, N, []).

value([Item | Rest], 1, First) ->
    {Item, lists:reverse(First) ++ Rest};
value([Item | Rest], N, First) ->
    value(Rest, N - 1, [Item | First]).

empty_grid() ->
    lists:duplicate(9, lists:duplicate(9, 0)).

check_grid([]) ->
    true;
check_grid([Row | Rows]) ->
    check_row(Row) andalso check_grid(Rows).

check_row([]) ->
    true;
check_row([0 | _]) ->
    false;
check_row([_ | Cols]) ->
    check_row(Cols).

possible_values(Grid, Row, Col) ->
    Values1 = filter(lists:seq(1,9), get_row(Grid, Row)),
    Values2 = filter(Values1, get_col(Grid, Col)),
    filter(Values2, get_square(Grid, Row, Col)).

get_row(Grid, N) ->
    lists:nth(N, Grid).

get_col(Grid, Col) ->
    get_col(Grid, Col, []).

get_col([], _, Values) ->
    Values;
get_col([Row | Rows], Col, Values) ->
    get_col(Rows, Col, [lists:nth(Col, Row) | Values]).

get_square(Grid, Row, Col) ->
    [get(Grid, R, C) || R <- square_range(Row), C <- square_range(Col)].

filter(List, []) ->
    List;
filter(List, [Value | Values]) ->
    filter(lists:delete(Value, List), Values).

square_range(N) ->
    Min = 3 * ((N - 1) div 3) + 1,
    [Min, Min + 1, Min + 2].

solution(Grid) ->
    check(Grid, empty(Grid)).

all_solutions(Grid) ->
    check(Grid, empty(Grid), []).

check(Grid, [{Row, Col} | Empty]) ->
    solve({Row, Col, possible_values(Grid, Row, Col), Grid}, Empty);
check(Grid, []) ->
    {ok, Grid}.

solve({Row, Col, [Value | Values], Grid}, Empty) ->
    case check(put(Grid, Row, Col, Value), Empty) of
        {ok, NewGrid} ->
            {ok, NewGrid};
        error ->
            solve({Row, Col, Values, Grid}, Empty)
    end;
solve({_, _, [], _}, _) ->
    error.

check(Grid, [{Row, Col} | Empty], Solutions) ->
    solve({Row, Col, possible_values(Grid, Row, Col), Grid}, Empty, Solutions);
check(Grid, [], Solutions) ->
    [Grid | Solutions].

solve({Row, Col, [Value | Values], Grid}, Empty, Solutions) ->
    NewSolutions = check(put(Grid, Row, Col, Value), Empty, Solutions),
    solve({Row, Col, Values, Grid}, Empty, NewSolutions);
solve({_, _, [], _}, _, Solutions) ->
    Solutions.

empty(Grid) ->
    empty(Grid, 1, []).

empty([], _, Empty) ->
    lists:reverse(Empty);
empty([Row | Rows], N, Empty) ->
    empty(Rows, N + 1, empty_row(Row, N, 1, []) ++ Empty).

empty_row([0 | Cols], RowNum, ColNum, Empty) ->
    empty_row(Cols, RowNum, ColNum + 1, [{RowNum, ColNum} | Empty]);
empty_row([_ | Cols], RowNum, ColNum, Empty) ->
    empty_row(Cols, RowNum, ColNum + 1, Empty);
empty_row([], _, _, Empty) ->
    Empty.

exercise(N) ->
    Grid = generate_grid(N),
    case solution(Grid) of
        {ok, Solution} ->
            {generalize_grid(Solution), Solution};
        error ->
            exercise(N - 1)
    end.

generate_grid(N) ->
    generate_grid(empty_grid(), N).

generate_grid(Grid, 0) ->
    Grid;
generate_grid(Grid, N) ->
    Row = rand:uniform(9),
    Col = rand:uniform(9),
    case get(Grid, Row, Col) of
        0 ->
            case possible_values(Grid, Row, Col) of
                [] ->
                    generate_grid(Grid, N);
                Values ->
                    [Value | _] = shuffle(Values),
                    NewGrid = put(Grid, Row, Col, Value),
                    generate_grid(NewGrid, N - 1)
            end;
        _ ->
            generate_grid(Grid, N)
    end.

generalize_grid(Grid) ->
    Row = rand:uniform(9),
    Col = rand:uniform(9),
    case get(Grid, Row, Col) of
        0 ->
            generalize_grid(Grid);
        _ ->
            NewGrid = put(Grid, Row, Col, 0),
            case all_solutions(NewGrid) of
                [_] ->
                    generalize_grid(NewGrid);
                _ ->
                    Grid
            end
    end.
