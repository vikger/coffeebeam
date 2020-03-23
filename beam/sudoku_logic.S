{module, sudoku_logic}.  %% version = 0

{exports, [{check_grid,1},
           {exercise,1},
           {generate_grid,1},
           {get,3},
           {is_valid,4},
           {module_info,0},
           {module_info,1},
           {possible_values,3},
           {put,4},
           {solution,1}]}.

{attributes, []}.

{labels, 103}.


{function, get, 3, 2}.
  {label,1}.
    {line,[{location,"sudoku_logic.erl",5}]}.
    {func_info,{atom,sudoku_logic},{atom,get},3}.
  {label,2}.
    {allocate,1,3}.
    {move,{x,2},{y,0}}.
    {move,{x,1},{x,2}}.
    {move,{x,0},{x,1}}.
    {move,{x,2},{x,0}}.
    {line,[{location,"sudoku_logic.erl",6}]}.
    {call_ext,2,{extfunc,lists,nth,2}}.
    {move,{x,0},{x,1}}.
    {move,{y,0},{x,0}}.
    {line,[{location,"sudoku_logic.erl",6}]}.
    {call_ext_last,2,{extfunc,lists,nth,2},1}.


{function, put, 4, 4}.
  {label,3}.
    {line,[{location,"sudoku_logic.erl",8}]}.
    {func_info,{atom,sudoku_logic},{atom,put},4}.
  {label,4}.
    {allocate,4,4}.
    {move,{x,3},{y,0}}.
    {move,{x,2},{y,1}}.
    {move,{x,1},{y,2}}.
    {move,{x,0},{y,3}}.
    {line,[{location,"sudoku_logic.erl",9}]}.
    {call,2,{f,33}}.
    {move,{y,0},{x,2}}.
    {move,{y,1},{x,1}}.
    {trim,2,2}.
    {line,[{location,"sudoku_logic.erl",9}]}.
    {call,3,{f,6}}.
    {'%',{type_info,{x,0},cons}}.
    {move,{y,0},{x,1}}.
    {move,{x,0},{x,2}}.
    {move,{y,1},{x,0}}.
    {call_last,3,{f,6},2}.


{function, set, 3, 6}.
  {label,5}.
    {line,[{location,"sudoku_logic.erl",11}]}.
    {func_info,{atom,sudoku_logic},{atom,set},3}.
  {label,6}.
    {test,is_nonempty_list,{f,5},[{x,0}]}.
    {get_list,{x,0},{x,3},{x,0}}.
    {test,is_eq_exact,{f,7},[{x,1},{integer,1}]}.
    {test_heap,2,3}.
    {put_list,{x,2},{x,0},{x,0}}.
    return.
  {label,7}.
    {line,[{location,"sudoku_logic.erl",14}]}.
    {gc_bif,'-',{f,0},4,[{x,1},{integer,1}],{x,1}}.
    {allocate,1,4}.
    {move,{x,3},{y,0}}.
    {line,[{location,"sudoku_logic.erl",14}]}.
    {call,3,{f,6}}.
    {'%',{type_info,{x,0},cons}}.
    {test_heap,2,1}.
    {put_list,{y,0},{x,0},{x,0}}.
    {deallocate,1}.
    return.


{function, is_valid, 4, 9}.
  {label,8}.
    {line,[{location,"sudoku_logic.erl",16}]}.
    {func_info,{atom,sudoku_logic},{atom,is_valid},4}.
  {label,9}.
    {allocate,1,4}.
    {move,{x,3},{y,0}}.
    {line,[{location,"sudoku_logic.erl",17}]}.
    {call,3,{f,31}}.
    {move,{x,0},{x,1}}.
    {move,{y,0},{x,0}}.
    {line,[{location,"sudoku_logic.erl",17}]}.
    {call_ext_last,2,{extfunc,lists,member,2},1}.


{function, shuffle, 1, 11}.
  {label,10}.
    {line,[{location,"sudoku_logic.erl",19}]}.
    {func_info,{atom,sudoku_logic},{atom,shuffle},1}.
  {label,11}.
    {line,[{location,"sudoku_logic.erl",20}]}.
    {gc_bif,length,{f,0},1,[{x,0}],{x,1}}.
    {call_only,2,{f,13}}.


{function, shuffle, 2, 13}.
  {label,12}.
    {line,[{location,"sudoku_logic.erl",22}]}.
    {func_info,{atom,sudoku_logic},{atom,shuffle},2}.
  {label,13}.
    {'%',{type_info,{x,1},number}}.
    {test,is_nil,{f,14},[{x,0}]}.
    return.
  {label,14}.
    {allocate,2,2}.
    {move,{x,1},{y,0}}.
    {move,{x,0},{y,1}}.
    {move,{x,1},{x,0}}.
    {line,[{location,"sudoku_logic.erl",25}]}.
    {call_ext,1,{extfunc,rand,uniform,1}}.
    {move,{x,0},{x,1}}.
    {move,{y,1},{x,0}}.
    {kill,{y,1}}.
    {line,[{location,"sudoku_logic.erl",25}]}.
    {call,2,{f,16}}.
    {'%',{type_info,{x,0},{tuple,2,#{}}}}.
    {line,[{location,"sudoku_logic.erl",26}]}.
    {gc_bif,'-',{f,0},1,[{y,0},{integer,1}],{x,1}}.
    {get_tuple_element,{x,0},0,{y,1}}.
    {get_tuple_element,{x,0},1,{x,0}}.
    {trim,1,1}.
    {line,[{location,"sudoku_logic.erl",26}]}.
    {call,2,{f,13}}.
    {'%',{type_info,{x,0},list}}.
    {test_heap,2,1}.
    {put_list,{y,0},{x,0},{x,0}}.
    {deallocate,1}.
    return.


{function, value, 2, 16}.
  {label,15}.
    {line,[{location,"sudoku_logic.erl",28}]}.
    {func_info,{atom,sudoku_logic},{atom,value},2}.
  {label,16}.
    {move,nil,{x,2}}.
    {call_only,3,{f,18}}.


{function, value, 3, 18}.
  {label,17}.
    {line,[{location,"sudoku_logic.erl",31}]}.
    {func_info,{atom,sudoku_logic},{atom,value},3}.
  {label,18}.
    {'%',{type_info,{x,2},list}}.
    {test,is_nonempty_list,{f,17},[{x,0}]}.
    {get_list,{x,0},{x,3},{x,0}}.
    {test,is_eq_exact,{f,19},[{x,1},{integer,1}]}.
    {allocate,2,4}.
    {move,{x,3},{y,0}}.
    {move,{x,0},{y,1}}.
    {move,{x,2},{x,0}}.
    {line,[{location,"sudoku_logic.erl",32}]}.
    {call_ext,1,{extfunc,lists,reverse,1}}.
    {move,{y,1},{x,1}}.
    {kill,{y,1}}.
    {line,[{location,"sudoku_logic.erl",32}]}.
    {call_ext,2,{extfunc,erlang,'++',2}}.
    {test_heap,3,1}.
    {put_tuple2,{x,0},{list,[{y,0},{x,0}]}}.
    {deallocate,2}.
    return.
  {label,19}.
    {line,[{location,"sudoku_logic.erl",34}]}.
    {gc_bif,'-',{f,0},4,[{x,1},{integer,1}],{x,1}}.
    {test_heap,2,4}.
    {put_list,{x,3},{x,2},{x,2}}.
    {call_only,3,{f,18}}.


{function, empty_grid, 0, 21}.
  {label,20}.
    {line,[{location,"sudoku_logic.erl",36}]}.
    {func_info,{atom,sudoku_logic},{atom,empty_grid},0}.
  {label,21}.
    {allocate,0,0}.
    {move,{integer,0},{x,1}}.
    {move,{integer,9},{x,0}}.
    {line,[{location,"sudoku_logic.erl",37}]}.
    {call_ext,2,{extfunc,lists,duplicate,2}}.
    {move,{x,0},{x,1}}.
    {move,{integer,9},{x,0}}.
    {line,[{location,"sudoku_logic.erl",37}]}.
    {call_ext_last,2,{extfunc,lists,duplicate,2},0}.


{function, check_grid, 1, 23}.
  {label,22}.
    {line,[{location,"sudoku_logic.erl",39}]}.
    {func_info,{atom,sudoku_logic},{atom,check_grid},1}.
  {label,23}.
    {test,is_nonempty_list,{f,25},[{x,0}]}.
    {allocate,1,1}.
    {get_list,{x,0},{x,0},{y,0}}.
    {line,[{location,"sudoku_logic.erl",42}]}.
    {call,1,{f,27}}.
    {'%',{type_info,{x,0},bool}}.
    {test,is_eq_exact,{f,24},[{x,0},{atom,true}]}.
    {move,{y,0},{x,0}}.
    {call_last,1,{f,23},1}.
  {label,24}.
    {move,{atom,false},{x,0}}.
    {deallocate,1}.
    return.
  {label,25}.
    {test,is_nil,{f,22},[{x,0}]}.
    {move,{atom,true},{x,0}}.
    return.


{function, check_row, 1, 27}.
  {label,26}.
    {line,[{location,"sudoku_logic.erl",44}]}.
    {func_info,{atom,sudoku_logic},{atom,check_row},1}.
  {label,27}.
    {test,is_nonempty_list,{f,29},[{x,0}]}.
    {get_list,{x,0},{x,1},{x,0}}.
    {test,is_eq_exact,{f,28},[{x,1},{integer,0}]}.
    {move,{atom,false},{x,0}}.
    return.
  {label,28}.
    {call_only,1,{f,27}}.
  {label,29}.
    {test,is_nil,{f,26},[{x,0}]}.
    {move,{atom,true},{x,0}}.
    return.


{function, possible_values, 3, 31}.
  {label,30}.
    {line,[{location,"sudoku_logic.erl",51}]}.
    {func_info,{atom,sudoku_logic},{atom,possible_values},3}.
  {label,31}.
    {allocate,4,3}.
    {init,{y,0}}.
    {move,{x,2},{y,1}}.
    {move,{x,1},{y,2}}.
    {move,{x,0},{y,3}}.
    {move,{integer,9},{x,1}}.
    {move,{integer,1},{x,0}}.
    {line,[{location,"sudoku_logic.erl",52}]}.
    {call_ext,2,{extfunc,lists,seq,2}}.
    {move,{y,2},{x,2}}.
    {move,{x,0},{y,0}}.
    {move,{y,3},{x,0}}.
    {move,{x,2},{x,1}}.
    {line,[{location,"sudoku_logic.erl",52}]}.
    {call,2,{f,33}}.
    {move,{x,0},{x,1}}.
    {move,{y,0},{x,0}}.
    {kill,{y,0}}.
    {line,[{location,"sudoku_logic.erl",52}]}.
    {call,2,{f,42}}.
    {move,{y,1},{x,2}}.
    {move,{x,0},{y,0}}.
    {move,{y,3},{x,0}}.
    {move,{x,2},{x,1}}.
    {line,[{location,"sudoku_logic.erl",53}]}.
    {call,2,{f,35}}.
    {'%',{type_info,{x,0},list}}.
    {move,{x,0},{x,1}}.
    {move,{y,0},{x,0}}.
    {trim,1,3}.
    {line,[{location,"sudoku_logic.erl",53}]}.
    {call,2,{f,42}}.
    {move,{y,0},{x,3}}.
    {move,{y,1},{x,2}}.
    {move,{y,2},{x,1}}.
    {move,{x,0},{y,2}}.
    {move,{x,1},{x,0}}.
    {move,{x,2},{x,1}}.
    {move,{x,3},{x,2}}.
    {trim,2,1}.
    {line,[{location,"sudoku_logic.erl",54}]}.
    {call,3,{f,40}}.
    {move,{x,0},{x,1}}.
    {move,{y,0},{x,0}}.
    {call_last,2,{f,42},1}.


{function, get_row, 2, 33}.
  {label,32}.
    {line,[{location,"sudoku_logic.erl",56}]}.
    {func_info,{atom,sudoku_logic},{atom,get_row},2}.
  {label,33}.
    {move,{x,1},{x,2}}.
    {move,{x,0},{x,1}}.
    {move,{x,2},{x,0}}.
    {line,[{location,"sudoku_logic.erl",57}]}.
    {call_ext_only,2,{extfunc,lists,nth,2}}.


{function, get_col, 2, 35}.
  {label,34}.
    {line,[{location,"sudoku_logic.erl",59}]}.
    {func_info,{atom,sudoku_logic},{atom,get_col},2}.
  {label,35}.
    {move,nil,{x,2}}.
    {call_only,3,{f,37}}.


{function, get_col, 3, 37}.
  {label,36}.
    {line,[{location,"sudoku_logic.erl",62}]}.
    {func_info,{atom,sudoku_logic},{atom,get_col},3}.
  {label,37}.
    {'%',{type_info,{x,2},list}}.
    {test,is_nonempty_list,{f,38},[{x,0}]}.
    {allocate,3,3}.
    {move,{x,2},{y,1}}.
    {move,{x,1},{y,2}}.
    {get_list,{x,0},{x,1},{y,0}}.
    {move,{y,2},{x,0}}.
    {line,[{location,"sudoku_logic.erl",65}]}.
    {call_ext,2,{extfunc,lists,nth,2}}.
    {test_heap,2,1}.
    {put_list,{x,0},{y,1},{x,2}}.
    {move,{y,2},{x,1}}.
    {move,{y,0},{x,0}}.
    {call_last,3,{f,37},3}.
  {label,38}.
    {test,is_nil,{f,36},[{x,0}]}.
    {move,{x,2},{x,0}}.
    return.


{function, get_square, 3, 40}.
  {label,39}.
    {line,[{location,"sudoku_logic.erl",67}]}.
    {func_info,{atom,sudoku_logic},{atom,get_square},3}.
  {label,40}.
    {allocate,2,3}.
    {move,{x,2},{y,0}}.
    {move,{x,0},{y,1}}.
    {move,{x,1},{x,0}}.
    {line,[{location,"sudoku_logic.erl",68}]}.
    {call,1,{f,45}}.
    {'%',{type_info,{x,0},cons}}.
    {move,{y,0},{x,2}}.
    {move,{y,1},{x,1}}.
    {call_last,3,{f,96},2}.


{function, filter, 2, 42}.
  {label,41}.
    {line,[{location,"sudoku_logic.erl",70}]}.
    {func_info,{atom,sudoku_logic},{atom,filter},2}.
  {label,42}.
    {test,is_nonempty_list,{f,43},[{x,1}]}.
    {allocate,1,2}.
    {get_list,{x,1},{x,1},{y,0}}.
    {move,{x,1},{x,2}}.
    {move,{x,0},{x,1}}.
    {move,{x,2},{x,0}}.
    {line,[{location,"sudoku_logic.erl",73}]}.
    {call_ext,2,{extfunc,lists,delete,2}}.
    {move,{y,0},{x,1}}.
    {call_last,2,{f,42},1}.
  {label,43}.
    {test,is_nil,{f,41},[{x,1}]}.
    return.


{function, square_range, 1, 45}.
  {label,44}.
    {line,[{location,"sudoku_logic.erl",75}]}.
    {func_info,{atom,sudoku_logic},{atom,square_range},1}.
  {label,45}.
    {select_val,{x,0},
                {f,44},
                {list,[{integer,9},
                       {f,48},
                       {integer,8},
                       {f,48},
                       {integer,7},
                       {f,48},
                       {integer,6},
                       {f,47},
                       {integer,5},
                       {f,47},
                       {integer,4},
                       {f,47},
                       {integer,3},
                       {f,46},
                       {integer,2},
                       {f,46},
                       {integer,1},
                       {f,46}]}}.
  {label,46}.
    {move,{literal,[1,2,3]},{x,0}}.
    return.
  {label,47}.
    {move,{literal,[4,5,6]},{x,0}}.
    return.
  {label,48}.
    {move,{literal,[7,8,9]},{x,0}}.
    return.


{function, solution, 1, 50}.
  {label,49}.
    {line,[{location,"sudoku_logic.erl",94}]}.
    {func_info,{atom,sudoku_logic},{atom,solution},1}.
  {label,50}.
    {allocate,1,1}.
    {move,{x,0},{y,0}}.
    {line,[{location,"sudoku_logic.erl",95}]}.
    {call,1,{f,68}}.
    {'%',{type_info,{x,0},list}}.
    {move,{x,0},{x,1}}.
    {move,{y,0},{x,0}}.
    {call_last,2,{f,54},1}.


{function, all_solutions, 1, 52}.
  {label,51}.
    {line,[{location,"sudoku_logic.erl",97}]}.
    {func_info,{atom,sudoku_logic},{atom,all_solutions},1}.
  {label,52}.
    {'%',{type_info,{x,0},cons}}.
    {allocate,1,1}.
    {move,{x,0},{y,0}}.
    {line,[{location,"sudoku_logic.erl",98}]}.
    {call,1,{f,68}}.
    {'%',{type_info,{x,0},list}}.
    {move,{x,0},{x,1}}.
    {move,nil,{x,2}}.
    {move,{y,0},{x,0}}.
    {call_last,3,{f,62},1}.


{function, check, 2, 54}.
  {label,53}.
    {line,[{location,"sudoku_logic.erl",100}]}.
    {func_info,{atom,sudoku_logic},{atom,check},2}.
  {label,54}.
    {test,is_nonempty_list,{f,55},[{x,1}]}.
    {get_list,{x,1},{x,2},{x,3}}.
    {test,is_tuple,{f,53},[{x,2}]}.
    {test,test_arity,{f,53},[{x,2},2]}.
    {allocate,4,4}.
    {move,{x,3},{y,2}}.
    {move,{x,0},{y,3}}.
    {get_tuple_element,{x,2},0,{y,1}}.
    {get_tuple_element,{x,2},1,{y,0}}.
    {move,{y,0},{x,2}}.
    {move,{y,1},{x,1}}.
    {line,[{location,"sudoku_logic.erl",101}]}.
    {call,3,{f,31}}.
    {test_heap,5,1}.
    {put_tuple2,{x,0},{list,[{y,1},{y,0},{x,0},{y,3}]}}.
    {move,{y,2},{x,1}}.
    {call_last,2,{f,57},4}.
  {label,55}.
    {test,is_nil,{f,53},[{x,1}]}.
    {test_heap,3,1}.
    {put_tuple2,{x,0},{list,[{atom,ok},{x,0}]}}.
    return.


{function, solve, 2, 57}.
  {label,56}.
    {line,[{location,"sudoku_logic.erl",105}]}.
    {func_info,{atom,sudoku_logic},{atom,solve},2}.
  {label,57}.
    {'%',{type_info,{x,0},{tuple,4,#{}}}}.
    {get_tuple_element,{x,0},2,{x,2}}.
    {test,is_nonempty_list,{f,59},[{x,2}]}.
    {allocate,5,3}.
    {move,{x,1},{y,4}}.
    {get_list,{x,2},{x,3},{y,3}}.
    {get_tuple_element,{x,0},0,{y,2}}.
    {get_tuple_element,{x,0},1,{y,1}}.
    {get_tuple_element,{x,0},3,{y,0}}.
    {move,{y,1},{x,2}}.
    {move,{y,2},{x,1}}.
    {move,{y,0},{x,0}}.
    {line,[{location,"sudoku_logic.erl",106}]}.
    {call,4,{f,4}}.
    {'%',{type_info,{x,0},cons}}.
    {move,{y,4},{x,1}}.
    {line,[{location,"sudoku_logic.erl",106}]}.
    {call,2,{f,54}}.
    {test,is_tuple,{f,58},[{x,0}]}.
    {test,is_tagged_tuple,{f,60},[{x,0},2,{atom,ok}]}.
    {deallocate,5}.
    return.
  {label,58}.
    {test,is_eq_exact,{f,60},[{x,0},{atom,error}]}.
    {test_heap,5,0}.
    {put_tuple2,{x,0},{list,[{y,2},{y,1},{y,3},{y,0}]}}.
    {move,{y,4},{x,1}}.
    {call_last,2,{f,57},5}.
  {label,59}.
    {test,is_nil,{f,56},[{x,2}]}.
    {move,{atom,error},{x,0}}.
    return.
  {label,60}.
    {line,[{location,"sudoku_logic.erl",106}]}.
    {case_end,{x,0}}.


{function, check, 3, 62}.
  {label,61}.
    {line,[{location,"sudoku_logic.erl",115}]}.
    {func_info,{atom,sudoku_logic},{atom,check},3}.
  {label,62}.
    {'%',{type_info,{x,0},cons}}.
    {test,is_nonempty_list,{f,63},[{x,1}]}.
    {get_list,{x,1},{x,3},{x,4}}.
    {test,is_tuple,{f,61},[{x,3}]}.
    {test,test_arity,{f,61},[{x,3},2]}.
    {allocate,5,5}.
    {move,{x,4},{y,2}}.
    {move,{x,2},{y,3}}.
    {move,{x,0},{y,4}}.
    {get_tuple_element,{x,3},0,{y,1}}.
    {get_tuple_element,{x,3},1,{y,0}}.
    {move,{y,0},{x,2}}.
    {move,{y,1},{x,1}}.
    {line,[{location,"sudoku_logic.erl",116}]}.
    {call,3,{f,31}}.
    {test_heap,5,1}.
    {put_tuple2,{x,0},{list,[{y,1},{y,0},{x,0},{y,4}]}}.
    {move,{y,2},{x,1}}.
    {move,{y,3},{x,2}}.
    {call_last,3,{f,65},5}.
  {label,63}.
    {test,is_nil,{f,61},[{x,1}]}.
    {test_heap,2,3}.
    {put_list,{x,0},{x,2},{x,0}}.
    return.


{function, solve, 3, 65}.
  {label,64}.
    {line,[{location,"sudoku_logic.erl",120}]}.
    {func_info,{atom,sudoku_logic},{atom,solve},3}.
  {label,65}.
    {'%',{type_info,{x,0},{tuple,4,#{}}}}.
    {get_tuple_element,{x,0},2,{x,3}}.
    {test,is_nonempty_list,{f,66},[{x,3}]}.
    {allocate,6,4}.
    {move,{x,2},{y,4}}.
    {move,{x,1},{y,5}}.
    {get_list,{x,3},{x,3},{y,3}}.
    {get_tuple_element,{x,0},0,{y,2}}.
    {get_tuple_element,{x,0},1,{y,1}}.
    {get_tuple_element,{x,0},3,{y,0}}.
    {move,{y,1},{x,2}}.
    {move,{y,2},{x,1}}.
    {move,{y,0},{x,0}}.
    {line,[{location,"sudoku_logic.erl",121}]}.
    {call,4,{f,4}}.
    {'%',{type_info,{x,0},cons}}.
    {move,{y,4},{x,2}}.
    {move,{y,5},{x,1}}.
    {kill,{y,4}}.
    {line,[{location,"sudoku_logic.erl",121}]}.
    {call,3,{f,62}}.
    {test_heap,5,1}.
    {put_tuple2,{x,1},{list,[{y,2},{y,1},{y,3},{y,0}]}}.
    {move,{x,0},{x,2}}.
    {move,{x,1},{x,0}}.
    {move,{y,5},{x,1}}.
    {call_last,3,{f,65},6}.
  {label,66}.
    {test,is_nil,{f,64},[{x,3}]}.
    {move,{x,2},{x,0}}.
    return.


{function, empty, 1, 68}.
  {label,67}.
    {line,[{location,"sudoku_logic.erl",126}]}.
    {func_info,{atom,sudoku_logic},{atom,empty},1}.
  {label,68}.
    {move,nil,{x,2}}.
    {move,{integer,1},{x,1}}.
    {call_only,3,{f,70}}.


{function, empty, 3, 70}.
  {label,69}.
    {line,[{location,"sudoku_logic.erl",129}]}.
    {func_info,{atom,sudoku_logic},{atom,empty},3}.
  {label,70}.
    {'%',{type_info,{x,1},number}}.
    {test,is_nonempty_list,{f,71},[{x,0}]}.
    {get_list,{x,0},{x,3},{x,0}}.
    {line,[{location,"sudoku_logic.erl",132}]}.
    {gc_bif,'+',{f,0},4,[{x,1},{integer,1}],{x,4}}.
    {allocate,3,5}.
    {move,{x,0},{y,0}}.
    {move,{x,4},{y,1}}.
    {move,{x,2},{y,2}}.
    {move,{integer,1},{x,2}}.
    {move,{x,3},{x,0}}.
    {move,nil,{x,3}}.
    {line,[{location,"sudoku_logic.erl",132}]}.
    {call,4,{f,73}}.
    {move,{y,2},{x,1}}.
    {kill,{y,2}}.
    {line,[{location,"sudoku_logic.erl",132}]}.
    {call_ext,2,{extfunc,erlang,'++',2}}.
    {move,{y,1},{x,1}}.
    {move,{x,0},{x,2}}.
    {move,{y,0},{x,0}}.
    {call_last,3,{f,70},3}.
  {label,71}.
    {test,is_nil,{f,69},[{x,0}]}.
    {move,{x,2},{x,0}}.
    {line,[{location,"sudoku_logic.erl",130}]}.
    {call_ext_only,1,{extfunc,lists,reverse,1}}.


{function, empty_row, 4, 73}.
  {label,72}.
    {line,[{location,"sudoku_logic.erl",134}]}.
    {func_info,{atom,sudoku_logic},{atom,empty_row},4}.
  {label,73}.
    {'%',{type_info,{x,2},number}}.
    {test,is_nonempty_list,{f,75},[{x,0}]}.
    {get_list,{x,0},{x,4},{x,0}}.
    {test,is_eq_exact,{f,74},[{x,4},{integer,0}]}.
    {line,[{location,"sudoku_logic.erl",135}]}.
    {gc_bif,'+',{f,0},4,[{x,2},{integer,1}],{x,4}}.
    {test_heap,5,5}.
    {put_tuple2,{x,2},{list,[{x,1},{x,2}]}}.
    {put_list,{x,2},{x,3},{x,3}}.
    {move,{x,4},{x,2}}.
    {call_only,4,{f,73}}.
  {label,74}.
    {line,[{location,"sudoku_logic.erl",137}]}.
    {gc_bif,'+',{f,0},4,[{x,2},{integer,1}],{x,2}}.
    {call_only,4,{f,73}}.
  {label,75}.
    {test,is_nil,{f,72},[{x,0}]}.
    {move,{x,3},{x,0}}.
    return.


{function, exercise, 1, 77}.
  {label,76}.
    {line,[{location,"sudoku_logic.erl",141}]}.
    {func_info,{atom,sudoku_logic},{atom,exercise},1}.
  {label,77}.
    {allocate,1,1}.
    {move,{x,0},{y,0}}.
    {line,[{location,"sudoku_logic.erl",142}]}.
    {call,1,{f,81}}.
    {line,[{location,"sudoku_logic.erl",143}]}.
    {call,1,{f,50}}.
    {test,is_tuple,{f,78},[{x,0}]}.
    {test,is_tagged_tuple,{f,79},[{x,0},2,{atom,ok}]}.
    {get_tuple_element,{x,0},1,{y,0}}.
    {move,{y,0},{x,0}}.
    {line,[{location,"sudoku_logic.erl",145}]}.
    {call,1,{f,88}}.
    {test_heap,3,1}.
    {put_tuple2,{x,0},{list,[{x,0},{y,0}]}}.
    {deallocate,1}.
    return.
  {label,78}.
    {test,is_eq_exact,{f,79},[{x,0},{atom,error}]}.
    {line,[{location,"sudoku_logic.erl",147}]}.
    {gc_bif,'-',{f,0},0,[{y,0},{integer,1}],{x,0}}.
    {call_last,1,{f,77},1}.
  {label,79}.
    {line,[{location,"sudoku_logic.erl",143}]}.
    {case_end,{x,0}}.


{function, generate_grid, 1, 81}.
  {label,80}.
    {line,[{location,"sudoku_logic.erl",150}]}.
    {func_info,{atom,sudoku_logic},{atom,generate_grid},1}.
  {label,81}.
    {allocate,1,1}.
    {move,{x,0},{y,0}}.
    {line,[{location,"sudoku_logic.erl",151}]}.
    {call,0,{f,21}}.
    {'%',{type_info,{x,0},list}}.
    {move,{y,0},{x,1}}.
    {call_last,2,{f,83},1}.


{function, generate_grid, 2, 83}.
  {label,82}.
    {line,[{location,"sudoku_logic.erl",153}]}.
    {func_info,{atom,sudoku_logic},{atom,generate_grid},2}.
  {label,83}.
    {test,is_eq_exact,{f,84},[{x,1},{integer,0}]}.
    return.
  {label,84}.
    {allocate_zero,4,2}.
    {move,{x,1},{y,2}}.
    {move,{x,0},{y,3}}.
    {move,{integer,9},{x,0}}.
    {line,[{location,"sudoku_logic.erl",156}]}.
    {call_ext,1,{extfunc,rand,uniform,1}}.
    {move,{x,0},{y,1}}.
    {move,{integer,9},{x,0}}.
    {line,[{location,"sudoku_logic.erl",157}]}.
    {call_ext,1,{extfunc,rand,uniform,1}}.
    {move,{y,1},{x,2}}.
    {move,{x,0},{y,0}}.
    {move,{y,3},{x,0}}.
    {move,{x,2},{x,1}}.
    {move,{y,0},{x,2}}.
    {line,[{location,"sudoku_logic.erl",158}]}.
    {call,3,{f,2}}.
    {test,is_eq_exact,{f,85},[{x,0},{integer,0}]}.
    {move,{y,0},{x,2}}.
    {move,{y,1},{x,1}}.
    {move,{y,3},{x,0}}.
    {line,[{location,"sudoku_logic.erl",160}]}.
    {call,3,{f,31}}.
    {test,is_ne_exact,{f,85},[{x,0},nil]}.
    {line,[{location,"sudoku_logic.erl",164}]}.
    {call,1,{f,11}}.
    {'%',{type_info,{x,0},list}}.
    {test,is_nonempty_list,{f,86},[{x,0}]}.
    {get_hd,{x,0},{x,3}}.
    {move,{y,0},{x,2}}.
    {move,{y,1},{x,1}}.
    {move,{y,3},{x,0}}.
    {move,{y,2},{y,3}}.
    {trim,3,1}.
    {line,[{location,"sudoku_logic.erl",165}]}.
    {call,4,{f,4}}.
    {'%',{type_info,{x,0},cons}}.
    {line,[{location,"sudoku_logic.erl",166}]}.
    {gc_bif,'-',{f,0},1,[{y,0},{integer,1}],{x,1}}.
    {call_last,2,{f,83},1}.
  {label,85}.
    {move,{y,2},{x,1}}.
    {move,{y,3},{x,0}}.
    {call_last,2,{f,83},4}.
  {label,86}.
    {line,[{location,"sudoku_logic.erl",164}]}.
    {badmatch,{literal,[]}}.


{function, generalize_grid, 1, 88}.
  {label,87}.
    {line,[{location,"sudoku_logic.erl",172}]}.
    {func_info,{atom,sudoku_logic},{atom,generalize_grid},1}.
  {label,88}.
    {allocate_zero,3,1}.
    {move,{x,0},{y,2}}.
    {move,{integer,9},{x,0}}.
    {line,[{location,"sudoku_logic.erl",173}]}.
    {call_ext,1,{extfunc,rand,uniform,1}}.
    {move,{x,0},{y,1}}.
    {move,{integer,9},{x,0}}.
    {line,[{location,"sudoku_logic.erl",174}]}.
    {call_ext,1,{extfunc,rand,uniform,1}}.
    {move,{y,1},{x,2}}.
    {move,{x,0},{y,0}}.
    {move,{y,2},{x,0}}.
    {move,{x,2},{x,1}}.
    {move,{y,0},{x,2}}.
    {line,[{location,"sudoku_logic.erl",175}]}.
    {call,3,{f,2}}.
    {test,is_eq_exact,{f,89},[{x,0},{integer,0}]}.
    {move,{y,2},{x,0}}.
    {call_last,1,{f,88},3}.
  {label,89}.
    {move,{y,0},{x,2}}.
    {move,{y,1},{x,1}}.
    {move,{integer,0},{x,3}}.
    {kill,{y,0}}.
    {kill,{y,1}}.
    {move,{y,2},{x,0}}.
    {line,[{location,"sudoku_logic.erl",179}]}.
    {call,4,{f,4}}.
    {'%',{type_info,{x,0},cons}}.
    {move,{x,0},{y,1}}.
    {line,[{location,"sudoku_logic.erl",180}]}.
    {call,1,{f,52}}.
    {test,is_nonempty_list,{f,90},[{x,0}]}.
    {get_tl,{x,0},{x,0}}.
    {test,is_nil,{f,90},[{x,0}]}.
    {move,{y,1},{x,0}}.
    {call_last,1,{f,88},3}.
  {label,90}.
    {move,{y,2},{x,0}}.
    {deallocate,3}.
    return.


{function, module_info, 0, 92}.
  {label,91}.
    {line,[]}.
    {func_info,{atom,sudoku_logic},{atom,module_info},0}.
  {label,92}.
    {move,{atom,sudoku_logic},{x,0}}.
    {line,[]}.
    {call_ext_only,1,{extfunc,erlang,get_module_info,1}}.


{function, module_info, 1, 94}.
  {label,93}.
    {line,[]}.
    {func_info,{atom,sudoku_logic},{atom,module_info},1}.
  {label,94}.
    {move,{x,0},{x,1}}.
    {move,{atom,sudoku_logic},{x,0}}.
    {line,[]}.
    {call_ext_only,2,{extfunc,erlang,get_module_info,2}}.


{function, '-get_square/3-lc$^0/1-0-', 3, 96}.
  {label,95}.
    {line,[{location,"sudoku_logic.erl",68}]}.
    {func_info,{atom,sudoku_logic},{atom,'-get_square/3-lc$^0/1-0-'},3}.
  {label,96}.
    {test,is_nonempty_list,{f,97},[{x,0}]}.
    {allocate,4,3}.
    {move,{x,2},{y,2}}.
    {move,{x,1},{y,3}}.
    {get_list,{x,0},{y,1},{y,0}}.
    {move,{x,2},{x,0}}.
    {line,[{location,"sudoku_logic.erl",68}]}.
    {call,1,{f,45}}.
    {'%',{type_info,{x,0},cons}}.
    {move,{y,0},{x,3}}.
    {move,{y,1},{x,4}}.
    {move,{y,2},{x,2}}.
    {move,{y,3},{x,1}}.
    {call_last,5,{f,100},4}.
  {label,97}.
    {test,is_nil,{f,98},[{x,0}]}.
    return.
  {label,98}.
    {test_heap,2,1}.
    {put_list,{x,0},nil,{x,1}}.
    {move,{atom,function_clause},{x,0}}.
    {line,[{location,"sudoku_logic.erl",68}]}.
    {call_ext,2,{extfunc,erlang,error,2}}.


{function, '-get_square/3-lc$^1/1-1-', 5, 100}.
  {label,99}.
    {line,[{location,"sudoku_logic.erl",68}]}.
    {func_info,{atom,sudoku_logic},{atom,'-get_square/3-lc$^1/1-1-'},5}.
  {label,100}.
    {test,is_nonempty_list,{f,101},[{x,0}]}.
    {allocate,5,5}.
    {move,{x,4},{y,1}}.
    {move,{x,3},{y,2}}.
    {move,{x,2},{y,3}}.
    {move,{x,1},{y,4}}.
    {get_list,{x,0},{x,2},{y,0}}.
    {move,{x,1},{x,0}}.
    {move,{x,4},{x,1}}.
    {line,[{location,"sudoku_logic.erl",68}]}.
    {call,3,{f,2}}.
    {move,{y,1},{x,5}}.
    {move,{y,2},{x,4}}.
    {move,{y,3},{x,3}}.
    {move,{y,4},{x,2}}.
    {move,{x,0},{y,4}}.
    {move,{y,0},{x,0}}.
    {move,{x,2},{x,1}}.
    {move,{x,3},{x,2}}.
    {move,{x,4},{x,3}}.
    {move,{x,5},{x,4}}.
    {trim,4,1}.
    {line,[{location,"sudoku_logic.erl",68}]}.
    {call,5,{f,100}}.
    {test_heap,2,1}.
    {put_list,{y,0},{x,0},{x,0}}.
    {deallocate,1}.
    return.
  {label,101}.
    {test,is_nil,{f,102},[{x,0}]}.
    {move,{x,3},{x,0}}.
    {call_only,3,{f,96}}.
  {label,102}.
    {test_heap,2,1}.
    {put_list,{x,0},nil,{x,1}}.
    {move,{atom,function_clause},{x,0}}.
    {line,[{location,"sudoku_logic.erl",68}]}.
    {call_ext,2,{extfunc,erlang,error,2}}.
