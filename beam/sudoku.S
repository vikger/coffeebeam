{module, sudoku}.  %% version = 0

{exports, [{grid,0},
           {module_info,0},
           {module_info,1},
           {new_game,0},
           {put,3},
           {start,0},
           {values,2}]}.

{attributes, []}.

{labels, 43}.


{function, start, 0, 2}.
  {label,1}.
    {line,[{location,"sudoku.erl",5}]}.
    {func_info,{atom,sudoku},{atom,start},0}.
  {label,2}.
    {allocate,0,0}.
    {make_fun2,{f,42},0,0,0}.
    {line,[{location,"sudoku.erl",6}]}.
    {call_ext,1,{extfunc,erlang,spawn,1}}.
    {move,{x,0},{x,1}}.
    {move,{atom,sudoku},{x,0}}.
    {line,[{location,"sudoku.erl",7}]}.
    {call_ext,2,{extfunc,erlang,register,2}}.
    {move,{atom,ok},{x,0}}.
    {deallocate,0}.
    return.


{function, new_game, 0, 4}.
  {label,3}.
    {line,[{location,"sudoku.erl",10}]}.
    {func_info,{atom,sudoku},{atom,new_game},0}.
  {label,4}.
    {allocate_heap,0,3,0}.
    {bif,self,{f,0},[],{x,0}}.
    {put_tuple2,{x,1},{list,[{x,0},{atom,new_game}]}}.
    {move,{atom,sudoku},{x,0}}.
    {line,[{location,"sudoku.erl",11}]}.
    send.
  {label,5}.
    {loop_rec,{f,6},{x,0}}.
    remove_message.
    {deallocate,0}.
    return.
  {label,6}.
    {wait,{f,5}}.


{function, put, 3, 8}.
  {label,7}.
    {line,[{location,"sudoku.erl",17}]}.
    {func_info,{atom,sudoku},{atom,put},3}.
  {label,8}.
    {allocate_heap,0,8,3}.
    {bif,self,{f,0},[],{x,3}}.
    {put_tuple2,{x,0},{list,[{atom,put},{x,0},{x,1},{x,2}]}}.
    {put_tuple2,{x,1},{list,[{x,3},{x,0}]}}.
    {move,{atom,sudoku},{x,0}}.
    {line,[{location,"sudoku.erl",18}]}.
    send.
  {label,9}.
    {loop_rec,{f,10},{x,0}}.
    remove_message.
    {deallocate,0}.
    return.
  {label,10}.
    {wait,{f,9}}.


{function, values, 2, 12}.
  {label,11}.
    {line,[{location,"sudoku.erl",24}]}.
    {func_info,{atom,sudoku},{atom,values},2}.
  {label,12}.
    {allocate_heap,0,7,2}.
    {bif,self,{f,0},[],{x,2}}.
    {put_tuple2,{x,0},{list,[{atom,values},{x,0},{x,1}]}}.
    {put_tuple2,{x,1},{list,[{x,2},{x,0}]}}.
    {move,{atom,sudoku},{x,0}}.
    {line,[{location,"sudoku.erl",25}]}.
    send.
  {label,13}.
    {loop_rec,{f,14},{x,0}}.
    remove_message.
    {deallocate,0}.
    return.
  {label,14}.
    {wait,{f,13}}.


{function, grid, 0, 16}.
  {label,15}.
    {line,[{location,"sudoku.erl",31}]}.
    {func_info,{atom,sudoku},{atom,grid},0}.
  {label,16}.
    {allocate_heap,0,3,0}.
    {bif,self,{f,0},[],{x,0}}.
    {put_tuple2,{x,1},{list,[{x,0},{atom,grid}]}}.
    {move,{atom,sudoku},{x,0}}.
    {line,[{location,"sudoku.erl",32}]}.
    send.
  {label,17}.
    {loop_rec,{f,18},{x,0}}.
    remove_message.
    {deallocate,0}.
    return.
  {label,18}.
    {wait,{f,17}}.


{function, init, 0, 20}.
  {label,19}.
    {line,[{location,"sudoku.erl",38}]}.
    {func_info,{atom,sudoku},{atom,init},0}.
  {label,20}.
    {allocate,0,0}.
    {bif,self,{f,0},[],{x,0}}.
    {move,{atom,generate_spare},{x,1}}.
    {line,[{location,"sudoku.erl",39}]}.
    send.
    {move,{integer,30},{x,0}}.
    {line,[{location,"sudoku.erl",40}]}.
    {call_ext,1,{extfunc,sudoku_logic,exercise,1}}.
    {move,{atom,no_spare},{x,1}}.
    {call_last,2,{f,22},0}.


{function, loop, 2, 22}.
  {label,21}.
    {line,[{location,"sudoku.erl",42}]}.
    {func_info,{atom,sudoku},{atom,loop},2}.
  {label,22}.
    {test,is_tuple,{f,21},[{x,0}]}.
    {test,test_arity,{f,21},[{x,0},2]}.
    {allocate_zero,7,2}.
    {move,{x,1},{y,5}}.
    {move,{x,0},{y,6}}.
    {get_tuple_element,{x,0},0,{y,4}}.
  {label,23}.
    {loop_rec,{f,35},{x,0}}.
    {test,is_tuple,{f,33},[{x,0}]}.
    {test,test_arity,{f,34},[{x,0},2]}.
    {get_tuple_element,{x,0},0,{x,1}}.
    {get_tuple_element,{x,0},1,{x,0}}.
    {test,is_tuple,{f,30},[{x,0}]}.
    {select_tuple_arity,{x,0},{f,34},{list,[4,{f,27},3,{f,24}]}}.
  {label,24}.
    {get_tuple_element,{x,0},0,{x,2}}.
    {test,is_eq_exact,{f,34},[{x,2},{atom,values}]}.
    {move,{x,1},{y,3}}.
    remove_message.
    {get_tuple_element,{x,0},1,{y,2}}.
    {get_tuple_element,{x,0},2,{y,1}}.
    {move,{y,1},{x,2}}.
    {move,{y,2},{x,1}}.
    {move,{y,4},{x,0}}.
    {line,[{location,"sudoku.erl",55}]}.
    {call_ext,3,{extfunc,sudoku_logic,get,3}}.
    {test,is_eq_exact,{f,25},[{x,0},{integer,0}]}.
    {move,{y,1},{x,2}}.
    {move,{y,2},{x,1}}.
    {move,{y,4},{x,0}}.
    {kill,{y,1}}.
    {kill,{y,2}}.
    {kill,{y,4}}.
    {line,[{location,"sudoku.erl",57}]}.
    {call_ext,3,{extfunc,sudoku_logic,possible_values,3}}.
    {move,{x,0},{x,1}}.
    {move,{y,3},{x,0}}.
    {kill,{y,3}}.
    {line,[{location,"sudoku.erl",57}]}.
    send.
    {jump,{f,26}}.
  {label,25}.
    {move,nil,{x,1}}.
    {move,{y,3},{x,0}}.
    {kill,{y,1}}.
    {kill,{y,2}}.
    {kill,{y,3}}.
    {kill,{y,4}}.
    {line,[{location,"sudoku.erl",59}]}.
    send.
  {label,26}.
    {move,{y,5},{x,1}}.
    {move,{y,6},{x,0}}.
    {call_last,2,{f,22},7}.
  {label,27}.
    {get_tuple_element,{x,0},0,{x,2}}.
    {test,is_eq_exact,{f,34},[{x,2},{atom,put}]}.
    {move,{x,1},{y,3}}.
    remove_message.
    {get_tuple_element,{x,0},1,{y,2}}.
    {get_tuple_element,{x,0},2,{y,1}}.
    {get_tuple_element,{x,0},3,{y,0}}.
    {move,{y,0},{x,3}}.
    {move,{y,1},{x,2}}.
    {move,{y,2},{x,1}}.
    {move,{y,4},{x,0}}.
    {line,[{location,"sudoku.erl",45}]}.
    {call_ext,4,{extfunc,sudoku_logic,is_valid,4}}.
    {select_val,{x,0},{f,36},{list,[{atom,false},{f,29},{atom,true},{f,28}]}}.
  {label,28}.
    {move,{y,0},{x,3}}.
    {move,{y,1},{x,2}}.
    {move,{y,2},{x,1}}.
    {move,{y,4},{x,0}}.
    {kill,{y,4}}.
    {trim,3,4}.
    {line,[{location,"sudoku.erl",47}]}.
    {call_ext,4,{extfunc,sudoku_logic,put,4}}.
    {move,{x,0},{y,1}}.
    {move,{y,0},{x,0}}.
    {move,{atom,ok},{x,1}}.
    {trim,1,3}.
    {line,[{location,"sudoku.erl",48}]}.
    send.
    {test_heap,3,0}.
    {get_tuple_element,{y,2},1,{x,0}}.
    {put_tuple2,{x,0},{list,[{y,0},{x,0}]}}.
    {move,{y,1},{x,1}}.
    {call_last,2,{f,22},3}.
  {label,29}.
    {move,{atom,invalid},{x,1}}.
    {move,{y,3},{x,0}}.
    {trim,5,2}.
    {line,[{location,"sudoku.erl",51}]}.
    send.
    {move,{y,0},{x,1}}.
    {move,{y,1},{x,0}}.
    {call_last,2,{f,22},2}.
  {label,30}.
    {select_val,{x,0},
                {f,34},
                {list,[{atom,grid},{f,32},{atom,new_game},{f,31}]}}.
  {label,31}.
    {move,{x,1},{x,0}}.
    remove_message.
    {move,{y,5},{x,1}}.
    {kill,{y,6}}.
    {trim,5,2}.
    {line,[{location,"sudoku.erl",65}]}.
    send.
    {bif,self,{f,0},[],{x,0}}.
    {move,{atom,generate_spare},{x,1}}.
    {line,[{location,"sudoku.erl",66}]}.
    send.
    {move,{atom,no_spare},{x,1}}.
    {move,{y,0},{x,0}}.
    {call_last,2,{f,22},2}.
  {label,32}.
    {move,{x,1},{x,0}}.
    remove_message.
    {move,{y,4},{x,1}}.
    {trim,5,2}.
    {line,[{location,"sudoku.erl",69}]}.
    send.
    {move,{y,0},{x,1}}.
    {move,{y,1},{x,0}}.
    {call_last,2,{f,22},2}.
  {label,33}.
    {test,is_eq_exact,{f,34},[{x,0},{atom,generate_spare}]}.
    remove_message.
    {trim,6,1}.
    {move,{integer,30},{x,0}}.
    {line,[{location,"sudoku.erl",63}]}.
    {call_ext,1,{extfunc,sudoku_logic,exercise,1}}.
    {move,{x,0},{x,1}}.
    {move,{y,0},{x,0}}.
    {call_last,2,{f,22},1}.
  {label,34}.
    {loop_rec_end,{f,23}}.
  {label,35}.
    {wait,{f,23}}.
  {label,36}.
    {line,[{location,"sudoku.erl",45}]}.
    {case_end,{x,0}}.


{function, module_info, 0, 38}.
  {label,37}.
    {line,[]}.
    {func_info,{atom,sudoku},{atom,module_info},0}.
  {label,38}.
    {move,{atom,sudoku},{x,0}}.
    {line,[]}.
    {call_ext_only,1,{extfunc,erlang,get_module_info,1}}.


{function, module_info, 1, 40}.
  {label,39}.
    {line,[]}.
    {func_info,{atom,sudoku},{atom,module_info},1}.
  {label,40}.
    {move,{x,0},{x,1}}.
    {move,{atom,sudoku},{x,0}}.
    {line,[]}.
    {call_ext_only,2,{extfunc,erlang,get_module_info,2}}.


{function, '-start/0-fun-0-', 0, 42}.
  {label,41}.
    {line,[{location,"sudoku.erl",6}]}.
    {func_info,{atom,sudoku},{atom,'-start/0-fun-0-'},0}.
  {label,42}.
    {call_only,0,{f,20}}.
