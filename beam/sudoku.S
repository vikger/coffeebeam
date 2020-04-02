{module, sudoku}.  %% version = 0

{exports, [{grid,0},
           {module_info,0},
           {module_info,1},
           {new_game,0},
           {put,3},
           {start,0},
           {value,2},
           {values,2}]}.

{attributes, []}.

{labels, 75}.


{function, start, 0, 2}.
  {label,1}.
    {line,[{location,"sudoku.erl",8}]}.
    {func_info,{atom,sudoku},{atom,start},0}.
  {label,2}.
    {allocate,0,0}.
    {make_fun2,{f,74},0,0,0}.
    {line,[{location,"sudoku.erl",9}]}.
    {call_ext,1,{extfunc,erlang,spawn,1}}.
    {move,{x,0},{x,1}}.
    {move,{atom,sudoku},{x,0}}.
    {line,[{location,"sudoku.erl",10}]}.
    {call_ext,2,{extfunc,erlang,register,2}}.
    {move,{atom,ok},{x,0}}.
    {deallocate,0}.
    return.


{function, new_game, 0, 4}.
  {label,3}.
    {line,[{location,"sudoku.erl",13}]}.
    {func_info,{atom,sudoku},{atom,new_game},0}.
  {label,4}.
    {move,{atom,new_game},{x,0}}.
    {call_only,1,{f,62}}.


{function, put, 3, 6}.
  {label,5}.
    {line,[{location,"sudoku.erl",16}]}.
    {func_info,{atom,sudoku},{atom,put},3}.
  {label,6}.
    {test_heap,5,3}.
    {put_tuple2,{x,0},{list,[{atom,put},{x,0},{x,1},{x,2}]}}.
    {call_only,1,{f,62}}.


{function, value, 2, 8}.
  {label,7}.
    {line,[{location,"sudoku.erl",19}]}.
    {func_info,{atom,sudoku},{atom,value},2}.
  {label,8}.
    {test_heap,4,2}.
    {put_tuple2,{x,0},{list,[{atom,value},{x,0},{x,1}]}}.
    {call_only,1,{f,62}}.


{function, values, 2, 10}.
  {label,9}.
    {line,[{location,"sudoku.erl",22}]}.
    {func_info,{atom,sudoku},{atom,values},2}.
  {label,10}.
    {test_heap,4,2}.
    {put_tuple2,{x,0},{list,[{atom,values},{x,0},{x,1}]}}.
    {call_only,1,{f,62}}.


{function, grid, 0, 12}.
  {label,11}.
    {line,[{location,"sudoku.erl",25}]}.
    {func_info,{atom,sudoku},{atom,grid},0}.
  {label,12}.
    {move,{atom,grid},{x,0}}.
    {call_only,1,{f,62}}.


{function, init, 0, 14}.
  {label,13}.
    {line,[{location,"sudoku.erl",31}]}.
    {func_info,{atom,sudoku},{atom,init},0}.
  {label,14}.
    {allocate,0,0}.
    {bif,self,{f,0},[],{x,0}}.
    {make_fun2,{f,72},0,0,1}.
    {line,[{location,"sudoku.erl",33}]}.
    {call_ext,1,{extfunc,erlang,spawn,1}}.
    {move,{integer,30},{x,0}}.
    {line,[{location,"sudoku.erl",34}]}.
    {call_ext,1,{extfunc,sudoku_logic,exercise,1}}.
    {call_last,1,{f,16},0}.


{function, waiting, 1, 16}.
  {label,15}.
    {line,[{location,"sudoku.erl",36}]}.
    {func_info,{atom,sudoku},{atom,waiting},1}.
  {label,16}.
    {allocate,1,1}.
    {move,{x,0},{y,0}}.
  {label,17}.
    {loop_rec,{f,20},{x,0}}.
    {test,is_tuple,{f,19},[{x,0}]}.
    {test,test_arity,{f,19},[{x,0},2]}.
    {get_tuple_element,{x,0},0,{x,1}}.
    {get_tuple_element,{x,0},1,{x,0}}.
    {test,is_eq_exact,{f,18},[{x,0},{atom,new_game}]}.
    {move,{x,1},{x,0}}.
    remove_message.
    {move,{y,0},{x,1}}.
    {line,[{location,"sudoku.erl",39}]}.
    send.
    {move,{y,0},{x,0}}.
    {call_last,1,{f,27},1}.
  {label,18}.
    {test,is_eq_exact,{f,19},[{x,1},{atom,new_exercise}]}.
    {move,{x,0},{x,1}}.
    remove_message.
    {move,{y,0},{x,0}}.
    {call_last,2,{f,22},1}.
  {label,19}.
    {loop_rec_end,{f,17}}.
  {label,20}.
    {wait,{f,17}}.


{function, waiting, 2, 22}.
  {label,21}.
    {line,[{location,"sudoku.erl",45}]}.
    {func_info,{atom,sudoku},{atom,waiting},2}.
  {label,22}.
    {allocate,2,2}.
    {move,{x,1},{y,0}}.
    {move,{x,0},{y,1}}.
  {label,23}.
    {loop_rec,{f,25},{x,0}}.
    {test,is_tuple,{f,24},[{x,0}]}.
    {test,test_arity,{f,24},[{x,0},2]}.
    {get_tuple_element,{x,0},1,{x,1}}.
    {test,is_eq_exact,{f,24},[{x,1},{atom,new_game}]}.
    remove_message.
    {get_tuple_element,{x,0},0,{x,0}}.
    {move,{y,1},{x,1}}.
    {line,[{location,"sudoku.erl",48}]}.
    send.
    {move,{y,0},{x,1}}.
    {move,{y,1},{x,0}}.
    {call_last,2,{f,43},2}.
  {label,24}.
    {loop_rec_end,{f,23}}.
  {label,25}.
    {wait,{f,23}}.


{function, loop, 1, 27}.
  {label,26}.
    {line,[{location,"sudoku.erl",52}]}.
    {func_info,{atom,sudoku},{atom,loop},1}.
  {label,27}.
    {test,is_tuple,{f,26},[{x,0}]}.
    {test,test_arity,{f,26},[{x,0},2]}.
    {allocate_zero,7,1}.
    {move,{x,0},{y,6}}.
    {get_tuple_element,{x,0},0,{y,5}}.
    {get_tuple_element,{x,0},1,{y,4}}.
  {label,28}.
    {loop_rec,{f,40},{x,0}}.
    {test,is_tuple,{f,39},[{x,0}]}.
    {test,test_arity,{f,39},[{x,0},2]}.
    {get_tuple_element,{x,0},0,{x,1}}.
    {get_tuple_element,{x,0},1,{x,0}}.
    {test,is_eq_exact,{f,29},[{x,1},{atom,new_exercise}]}.
    {move,{x,0},{x,1}}.
    remove_message.
    {move,{y,6},{x,0}}.
    {call_last,2,{f,43},7}.
  {label,29}.
    {test,is_tuple,{f,38},[{x,0}]}.
    {select_tuple_arity,{x,0},{f,39},{list,[4,{f,35},3,{f,30}]}}.
  {label,30}.
    {get_tuple_element,{x,0},0,{x,2}}.
    {get_tuple_element,{x,0},1,{x,3}}.
    {get_tuple_element,{x,0},2,{x,0}}.
    {select_val,{x,2},
                {f,39},
                {list,[{atom,values},{f,32},{atom,value},{f,31}]}}.
  {label,31}.
    {move,{x,0},{x,2}}.
    {move,{x,1},{y,5}}.
    {move,{x,3},{x,1}}.
    remove_message.
    {move,{y,4},{x,0}}.
    {trim,5,2}.
    {line,[{location,"sudoku.erl",67}]}.
    {call_ext,3,{extfunc,sudoku_logic,get,3}}.
    {move,{x,0},{x,1}}.
    {move,{y,0},{x,0}}.
    {trim,1,1}.
    {line,[{location,"sudoku.erl",67}]}.
    send.
    {move,{y,0},{x,0}}.
    {call_last,1,{f,27},1}.
  {label,32}.
    {move,{x,3},{y,2}}.
    {move,{x,0},{y,3}}.
    {move,{x,1},{y,4}}.
    remove_message.
    {move,{x,3},{x,1}}.
    {move,{x,0},{x,2}}.
    {move,{y,5},{x,0}}.
    {line,[{location,"sudoku.erl",70}]}.
    {call_ext,3,{extfunc,sudoku_logic,get,3}}.
    {test,is_eq_exact,{f,33},[{x,0},{integer,0}]}.
    {move,{y,2},{x,1}}.
    {move,{y,3},{x,2}}.
    {move,{y,5},{x,0}}.
    {kill,{y,2}}.
    {kill,{y,3}}.
    {kill,{y,5}}.
    {line,[{location,"sudoku.erl",72}]}.
    {call_ext,3,{extfunc,sudoku_logic,possible_values,3}}.
    {move,{x,0},{x,1}}.
    {move,{y,4},{x,0}}.
    {kill,{y,4}}.
    {line,[{location,"sudoku.erl",72}]}.
    send.
    {jump,{f,34}}.
  {label,33}.
    {move,nil,{x,1}}.
    {move,{y,4},{x,0}}.
    {kill,{y,2}}.
    {kill,{y,3}}.
    {kill,{y,4}}.
    {kill,{y,5}}.
    {line,[{location,"sudoku.erl",74}]}.
    send.
  {label,34}.
    {move,{y,6},{x,0}}.
    {call_last,1,{f,27},7}.
  {label,35}.
    {get_tuple_element,{x,0},0,{x,2}}.
    {test,is_eq_exact,{f,39},[{x,2},{atom,put}]}.
    {move,{x,1},{y,3}}.
    remove_message.
    {get_tuple_element,{x,0},1,{y,2}}.
    {get_tuple_element,{x,0},2,{y,1}}.
    {get_tuple_element,{x,0},3,{y,0}}.
    {move,{y,0},{x,3}}.
    {move,{y,1},{x,2}}.
    {move,{y,2},{x,1}}.
    {move,{y,5},{x,0}}.
    {line,[{location,"sudoku.erl",57}]}.
    {call_ext,4,{extfunc,sudoku_logic,is_valid,4}}.
    {select_val,{x,0},{f,41},{list,[{atom,false},{f,37},{atom,true},{f,36}]}}.
  {label,36}.
    {move,{y,0},{x,3}}.
    {move,{y,1},{x,2}}.
    {move,{y,2},{x,1}}.
    {move,{y,5},{x,0}}.
    {kill,{y,5}}.
    {kill,{y,6}}.
    {trim,3,4}.
    {line,[{location,"sudoku.erl",59}]}.
    {call_ext,4,{extfunc,sudoku_logic,put,4}}.
    {move,{x,0},{y,3}}.
    {move,{y,0},{x,0}}.
    {move,{atom,ok},{x,1}}.
    {trim,1,3}.
    {line,[{location,"sudoku.erl",60}]}.
    send.
    {test_heap,3,0}.
    {put_tuple2,{x,0},{list,[{y,2},{y,0}]}}.
    {call_last,1,{f,27},3}.
  {label,37}.
    {move,{atom,invalid},{x,1}}.
    {move,{y,3},{x,0}}.
    {trim,6,1}.
    {line,[{location,"sudoku.erl",63}]}.
    send.
    {move,{y,0},{x,0}}.
    {call_last,1,{f,27},1}.
  {label,38}.
    {test,is_eq_exact,{f,39},[{x,0},{atom,grid}]}.
    {move,{x,1},{x,0}}.
    remove_message.
    {move,{y,5},{x,1}}.
    {trim,6,1}.
    {line,[{location,"sudoku.erl",78}]}.
    send.
    {move,{y,0},{x,0}}.
    {call_last,1,{f,27},1}.
  {label,39}.
    {loop_rec_end,{f,28}}.
  {label,40}.
    {wait,{f,28}}.
  {label,41}.
    {line,[{location,"sudoku.erl",57}]}.
    {case_end,{x,0}}.


{function, loop, 2, 43}.
  {label,42}.
    {line,[{location,"sudoku.erl",82}]}.
    {func_info,{atom,sudoku},{atom,loop},2}.
  {label,43}.
    {test,is_tuple,{f,42},[{x,0}]}.
    {test,test_arity,{f,42},[{x,0},2]}.
    {allocate_zero,8,2}.
    {move,{x,1},{y,6}}.
    {move,{x,0},{y,7}}.
    {get_tuple_element,{x,0},0,{y,5}}.
    {get_tuple_element,{x,0},1,{y,4}}.
  {label,44}.
    {loop_rec,{f,57},{x,0}}.
    {test,is_tuple,{f,56},[{x,0}]}.
    {test,test_arity,{f,56},[{x,0},2]}.
    {get_tuple_element,{x,0},0,{x,1}}.
    {get_tuple_element,{x,0},1,{x,0}}.
    {test,is_tuple,{f,53},[{x,0}]}.
    {select_tuple_arity,{x,0},{f,56},{list,[4,{f,50},3,{f,45}]}}.
  {label,45}.
    {get_tuple_element,{x,0},0,{x,2}}.
    {get_tuple_element,{x,0},1,{x,3}}.
    {get_tuple_element,{x,0},2,{x,0}}.
    {select_val,{x,2},
                {f,56},
                {list,[{atom,values},{f,47},{atom,value},{f,46}]}}.
  {label,46}.
    {move,{x,0},{x,2}}.
    {move,{x,1},{y,5}}.
    {move,{x,3},{x,1}}.
    remove_message.
    {move,{y,4},{x,0}}.
    {trim,5,3}.
    {line,[{location,"sudoku.erl",95}]}.
    {call_ext,3,{extfunc,sudoku_logic,get,3}}.
    {move,{x,0},{x,1}}.
    {move,{y,0},{x,0}}.
    {trim,1,2}.
    {line,[{location,"sudoku.erl",95}]}.
    send.
    {move,{y,0},{x,1}}.
    {move,{y,1},{x,0}}.
    {call_last,2,{f,43},2}.
  {label,47}.
    {move,{x,3},{y,2}}.
    {move,{x,0},{y,3}}.
    {move,{x,1},{y,4}}.
    remove_message.
    {move,{x,3},{x,1}}.
    {move,{x,0},{x,2}}.
    {move,{y,5},{x,0}}.
    {line,[{location,"sudoku.erl",98}]}.
    {call_ext,3,{extfunc,sudoku_logic,get,3}}.
    {test,is_eq_exact,{f,48},[{x,0},{integer,0}]}.
    {move,{y,2},{x,1}}.
    {move,{y,3},{x,2}}.
    {move,{y,5},{x,0}}.
    {kill,{y,2}}.
    {kill,{y,3}}.
    {kill,{y,5}}.
    {line,[{location,"sudoku.erl",100}]}.
    {call_ext,3,{extfunc,sudoku_logic,possible_values,3}}.
    {move,{x,0},{x,1}}.
    {move,{y,4},{x,0}}.
    {kill,{y,4}}.
    {line,[{location,"sudoku.erl",100}]}.
    send.
    {jump,{f,49}}.
  {label,48}.
    {move,nil,{x,1}}.
    {move,{y,4},{x,0}}.
    {kill,{y,2}}.
    {kill,{y,3}}.
    {kill,{y,4}}.
    {kill,{y,5}}.
    {line,[{location,"sudoku.erl",102}]}.
    send.
  {label,49}.
    {move,{y,6},{x,1}}.
    {move,{y,7},{x,0}}.
    {call_last,2,{f,43},8}.
  {label,50}.
    {get_tuple_element,{x,0},0,{x,2}}.
    {test,is_eq_exact,{f,56},[{x,2},{atom,put}]}.
    {move,{x,1},{y,3}}.
    remove_message.
    {get_tuple_element,{x,0},1,{y,2}}.
    {get_tuple_element,{x,0},2,{y,1}}.
    {get_tuple_element,{x,0},3,{y,0}}.
    {move,{y,0},{x,3}}.
    {move,{y,1},{x,2}}.
    {move,{y,2},{x,1}}.
    {move,{y,5},{x,0}}.
    {line,[{location,"sudoku.erl",85}]}.
    {call_ext,4,{extfunc,sudoku_logic,is_valid,4}}.
    {select_val,{x,0},{f,58},{list,[{atom,false},{f,52},{atom,true},{f,51}]}}.
  {label,51}.
    {move,{y,0},{x,3}}.
    {move,{y,1},{x,2}}.
    {move,{y,2},{x,1}}.
    {move,{y,5},{x,0}}.
    {kill,{y,5}}.
    {kill,{y,7}}.
    {trim,3,5}.
    {line,[{location,"sudoku.erl",87}]}.
    {call_ext,4,{extfunc,sudoku_logic,put,4}}.
    {move,{x,0},{y,4}}.
    {move,{y,0},{x,0}}.
    {move,{atom,ok},{x,1}}.
    {trim,1,4}.
    {line,[{location,"sudoku.erl",88}]}.
    send.
    {test_heap,3,0}.
    {put_tuple2,{x,0},{list,[{y,3},{y,0}]}}.
    {move,{y,2},{x,1}}.
    {call_last,2,{f,43},4}.
  {label,52}.
    {move,{atom,invalid},{x,1}}.
    {move,{y,3},{x,0}}.
    {trim,6,2}.
    {line,[{location,"sudoku.erl",91}]}.
    send.
    {move,{y,0},{x,1}}.
    {move,{y,1},{x,0}}.
    {call_last,2,{f,43},2}.
  {label,53}.
    {select_val,{x,0},
                {f,56},
                {list,[{atom,grid},{f,55},{atom,new_game},{f,54}]}}.
  {label,54}.
    {move,{x,1},{x,0}}.
    remove_message.
    {move,{y,6},{x,1}}.
    {move,{y,6},{y,7}}.
    {trim,7,1}.
    {line,[{location,"sudoku.erl",106}]}.
    send.
    {bif,self,{f,0},[],{x,0}}.
    {make_fun2,{f,70},0,0,1}.
    {line,[{location,"sudoku.erl",108}]}.
    {call_ext,1,{extfunc,erlang,spawn,1}}.
    {move,{y,0},{x,0}}.
    {call_last,1,{f,27},1}.
  {label,55}.
    {move,{x,1},{x,0}}.
    remove_message.
    {move,{y,5},{x,1}}.
    {trim,6,2}.
    {line,[{location,"sudoku.erl",111}]}.
    send.
    {move,{y,0},{x,1}}.
    {move,{y,1},{x,0}}.
    {call_last,2,{f,43},2}.
  {label,56}.
    {loop_rec_end,{f,44}}.
  {label,57}.
    {wait,{f,44}}.
  {label,58}.
    {line,[{location,"sudoku.erl",85}]}.
    {case_end,{x,0}}.


{function, new_exercise, 1, 60}.
  {label,59}.
    {line,[{location,"sudoku.erl",115}]}.
    {func_info,{atom,sudoku},{atom,new_exercise},1}.
  {label,60}.
    {allocate,1,1}.
    {move,{x,0},{y,0}}.
    {move,{integer,30},{x,0}}.
    {line,[{location,"sudoku.erl",116}]}.
    {call_ext,1,{extfunc,sudoku_logic,exercise,1}}.
    {test_heap,3,1}.
    {put_tuple2,{x,1},{list,[{atom,new_exercise},{x,0}]}}.
    {move,{y,0},{x,0}}.
    {line,[{location,"sudoku.erl",116}]}.
    send.
    {deallocate,1}.
    return.


{function, send, 1, 62}.
  {label,61}.
    {line,[{location,"sudoku.erl",118}]}.
    {func_info,{atom,sudoku},{atom,send},1}.
  {label,62}.
    {allocate_heap,0,3,1}.
    {bif,self,{f,0},[],{x,1}}.
    {put_tuple2,{x,1},{list,[{x,1},{x,0}]}}.
    {move,{atom,sudoku},{x,0}}.
    {line,[{location,"sudoku.erl",119}]}.
    send.
  {label,63}.
    {loop_rec,{f,64},{x,0}}.
    remove_message.
    {deallocate,0}.
    return.
  {label,64}.
    {wait,{f,63}}.


{function, module_info, 0, 66}.
  {label,65}.
    {line,[]}.
    {func_info,{atom,sudoku},{atom,module_info},0}.
  {label,66}.
    {move,{atom,sudoku},{x,0}}.
    {line,[]}.
    {call_ext_only,1,{extfunc,erlang,get_module_info,1}}.


{function, module_info, 1, 68}.
  {label,67}.
    {line,[]}.
    {func_info,{atom,sudoku},{atom,module_info},1}.
  {label,68}.
    {move,{x,0},{x,1}}.
    {move,{atom,sudoku},{x,0}}.
    {line,[]}.
    {call_ext_only,2,{extfunc,erlang,get_module_info,2}}.


{function, '-loop/2-fun-0-', 1, 70}.
  {label,69}.
    {line,[{location,"sudoku.erl",108}]}.
    {func_info,{atom,sudoku},{atom,'-loop/2-fun-0-'},1}.
  {label,70}.
    {call_only,1,{f,60}}.


{function, '-init/0-fun-0-', 1, 72}.
  {label,71}.
    {line,[{location,"sudoku.erl",33}]}.
    {func_info,{atom,sudoku},{atom,'-init/0-fun-0-'},1}.
  {label,72}.
    {call_only,1,{f,60}}.


{function, '-start/0-fun-0-', 0, 74}.
  {label,73}.
    {line,[{location,"sudoku.erl",9}]}.
    {func_info,{atom,sudoku},{atom,'-start/0-fun-0-'},0}.
  {label,74}.
    {call_only,0,{f,14}}.
