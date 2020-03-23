{module, sudoku}.  %% version = 0

{exports, [{module_info,0},
           {module_info,1},
           {new_game,1},
           {put,4},
           {start,0},
           {values,3}]}.

{attributes, []}.

{labels, 37}.


{function, start, 0, 2}.
  {label,1}.
    {line,[{location,"sudoku.erl",5}]}.
    {func_info,{atom,sudoku},{atom,start},0}.
  {label,2}.
    {make_fun2,{f,36},0,0,0}.
    {line,[{location,"sudoku.erl",6}]}.
    {call_ext_only,1,{extfunc,erlang,spawn,1}}.


{function, new_game, 1, 4}.
  {label,3}.
    {line,[{location,"sudoku.erl",8}]}.
    {func_info,{atom,sudoku},{atom,new_game},1}.
  {label,4}.
    {allocate_heap,0,3,1}.
    {bif,self,{f,0},[],{x,1}}.
    {put_tuple2,{x,1},{list,[{x,1},{atom,new_game}]}}.
    {line,[{location,"sudoku.erl",9}]}.
    send.
  {label,5}.
    {loop_rec,{f,6},{x,0}}.
    remove_message.
    {deallocate,0}.
    return.
  {label,6}.
    {wait,{f,5}}.


{function, put, 4, 8}.
  {label,7}.
    {line,[{location,"sudoku.erl",15}]}.
    {func_info,{atom,sudoku},{atom,put},4}.
  {label,8}.
    {allocate_heap,0,8,4}.
    {bif,self,{f,0},[],{x,4}}.
    {put_tuple2,{x,1},{list,[{atom,put},{x,1},{x,2},{x,3}]}}.
    {put_tuple2,{x,1},{list,[{x,4},{x,1}]}}.
    {line,[{location,"sudoku.erl",16}]}.
    send.
  {label,9}.
    {loop_rec,{f,10},{x,0}}.
    remove_message.
    {deallocate,0}.
    return.
  {label,10}.
    {wait,{f,9}}.


{function, values, 3, 12}.
  {label,11}.
    {line,[{location,"sudoku.erl",22}]}.
    {func_info,{atom,sudoku},{atom,values},3}.
  {label,12}.
    {allocate_heap,0,7,3}.
    {bif,self,{f,0},[],{x,3}}.
    {put_tuple2,{x,1},{list,[{atom,values},{x,1},{x,2}]}}.
    {put_tuple2,{x,1},{list,[{x,3},{x,1}]}}.
    {line,[{location,"sudoku.erl",23}]}.
    send.
  {label,13}.
    {loop_rec,{f,14},{x,0}}.
    remove_message.
    {deallocate,0}.
    return.
  {label,14}.
    {wait,{f,13}}.


{function, init, 0, 16}.
  {label,15}.
    {line,[{location,"sudoku.erl",29}]}.
    {func_info,{atom,sudoku},{atom,init},0}.
  {label,16}.
    {allocate,0,0}.
    {bif,self,{f,0},[],{x,0}}.
    {move,{atom,generate_spare},{x,1}}.
    {line,[{location,"sudoku.erl",30}]}.
    send.
    {move,{integer,30},{x,0}}.
    {line,[{location,"sudoku.erl",31}]}.
    {call_ext,1,{extfunc,sudoku_logic,exercise,1}}.
    {move,{atom,no_spare},{x,1}}.
    {call_last,2,{f,18},0}.


{function, loop, 2, 18}.
  {label,17}.
    {line,[{location,"sudoku.erl",33}]}.
    {func_info,{atom,sudoku},{atom,loop},2}.
  {label,18}.
    {test,is_tuple,{f,17},[{x,0}]}.
    {test,test_arity,{f,17},[{x,0},2]}.
    {allocate_zero,7,2}.
    {move,{x,1},{y,5}}.
    {move,{x,0},{y,6}}.
    {get_tuple_element,{x,0},0,{y,4}}.
  {label,19}.
    {loop_rec,{f,29},{x,0}}.
    {test,is_tuple,{f,27},[{x,0}]}.
    {test,test_arity,{f,28},[{x,0},2]}.
    {get_tuple_element,{x,0},0,{x,1}}.
    {get_tuple_element,{x,0},1,{x,0}}.
    {test,is_tuple,{f,26},[{x,0}]}.
    {select_tuple_arity,{x,0},{f,28},{list,[4,{f,23},3,{f,20}]}}.
  {label,20}.
    {get_tuple_element,{x,0},0,{x,2}}.
    {test,is_eq_exact,{f,28},[{x,2},{atom,values}]}.
    {move,{x,1},{y,3}}.
    remove_message.
    {get_tuple_element,{x,0},1,{y,2}}.
    {get_tuple_element,{x,0},2,{y,1}}.
    {move,{y,1},{x,2}}.
    {move,{y,2},{x,1}}.
    {move,{y,4},{x,0}}.
    {line,[{location,"sudoku.erl",46}]}.
    {call_ext,3,{extfunc,sudoku_logic,get,3}}.
    {test,is_eq_exact,{f,21},[{x,0},{integer,0}]}.
    {move,{y,1},{x,2}}.
    {move,{y,2},{x,1}}.
    {move,{y,4},{x,0}}.
    {kill,{y,1}}.
    {kill,{y,2}}.
    {kill,{y,4}}.
    {line,[{location,"sudoku.erl",48}]}.
    {call_ext,3,{extfunc,sudoku_logic,possible_values,3}}.
    {move,{x,0},{x,1}}.
    {move,{y,3},{x,0}}.
    {kill,{y,3}}.
    {line,[{location,"sudoku.erl",48}]}.
    send.
    {jump,{f,22}}.
  {label,21}.
    {move,nil,{x,1}}.
    {move,{y,3},{x,0}}.
    {kill,{y,1}}.
    {kill,{y,2}}.
    {kill,{y,3}}.
    {kill,{y,4}}.
    {line,[{location,"sudoku.erl",50}]}.
    send.
  {label,22}.
    {move,{y,5},{x,1}}.
    {move,{y,6},{x,0}}.
    {call_last,2,{f,18},7}.
  {label,23}.
    {get_tuple_element,{x,0},0,{x,2}}.
    {test,is_eq_exact,{f,28},[{x,2},{atom,put}]}.
    {move,{x,1},{y,3}}.
    remove_message.
    {get_tuple_element,{x,0},1,{y,2}}.
    {get_tuple_element,{x,0},2,{y,1}}.
    {get_tuple_element,{x,0},3,{y,0}}.
    {move,{y,0},{x,3}}.
    {move,{y,1},{x,2}}.
    {move,{y,2},{x,1}}.
    {move,{y,4},{x,0}}.
    {line,[{location,"sudoku.erl",36}]}.
    {call_ext,4,{extfunc,sudoku_logic,is_valid,4}}.
    {select_val,{x,0},{f,30},{list,[{atom,false},{f,25},{atom,true},{f,24}]}}.
  {label,24}.
    {move,{y,0},{x,3}}.
    {move,{y,1},{x,2}}.
    {move,{y,2},{x,1}}.
    {move,{y,4},{x,0}}.
    {kill,{y,4}}.
    {trim,3,4}.
    {line,[{location,"sudoku.erl",38}]}.
    {call_ext,4,{extfunc,sudoku_logic,put,4}}.
    {move,{x,0},{y,1}}.
    {move,{y,0},{x,0}}.
    {move,{y,1},{x,1}}.
    {trim,1,3}.
    {line,[{location,"sudoku.erl",39}]}.
    send.
    {test_heap,3,0}.
    {get_tuple_element,{y,2},1,{x,0}}.
    {put_tuple2,{x,0},{list,[{y,0},{x,0}]}}.
    {move,{y,1},{x,1}}.
    {call_last,2,{f,18},3}.
  {label,25}.
    {move,{atom,invalid},{x,1}}.
    {move,{y,3},{x,0}}.
    {trim,5,2}.
    {line,[{location,"sudoku.erl",42}]}.
    send.
    {move,{y,0},{x,1}}.
    {move,{y,1},{x,0}}.
    {call_last,2,{f,18},2}.
  {label,26}.
    {test,is_eq_exact,{f,28},[{x,0},{atom,new_game}]}.
    {move,{x,1},{x,0}}.
    remove_message.
    {move,{y,5},{x,1}}.
    {kill,{y,6}}.
    {trim,5,2}.
    {line,[{location,"sudoku.erl",56}]}.
    send.
    {bif,self,{f,0},[],{x,0}}.
    {move,{atom,generate_spare},{x,1}}.
    {line,[{location,"sudoku.erl",57}]}.
    send.
    {move,{atom,no_spare},{x,1}}.
    {move,{y,0},{x,0}}.
    {call_last,2,{f,18},2}.
  {label,27}.
    {test,is_eq_exact,{f,28},[{x,0},{atom,generate_spare}]}.
    remove_message.
    {trim,6,1}.
    {move,{integer,30},{x,0}}.
    {line,[{location,"sudoku.erl",54}]}.
    {call_ext,1,{extfunc,sudoku_logic,exercise,1}}.
    {move,{x,0},{x,1}}.
    {move,{y,0},{x,0}}.
    {call_last,2,{f,18},1}.
  {label,28}.
    {loop_rec_end,{f,19}}.
  {label,29}.
    {wait,{f,19}}.
  {label,30}.
    {line,[{location,"sudoku.erl",36}]}.
    {case_end,{x,0}}.


{function, module_info, 0, 32}.
  {label,31}.
    {line,[]}.
    {func_info,{atom,sudoku},{atom,module_info},0}.
  {label,32}.
    {move,{atom,sudoku},{x,0}}.
    {line,[]}.
    {call_ext_only,1,{extfunc,erlang,get_module_info,1}}.


{function, module_info, 1, 34}.
  {label,33}.
    {line,[]}.
    {func_info,{atom,sudoku},{atom,module_info},1}.
  {label,34}.
    {move,{x,0},{x,1}}.
    {move,{atom,sudoku},{x,0}}.
    {line,[]}.
    {call_ext_only,2,{extfunc,erlang,get_module_info,2}}.


{function, '-start/0-fun-0-', 0, 36}.
  {label,35}.
    {line,[{location,"sudoku.erl",6}]}.
    {func_info,{atom,sudoku},{atom,'-start/0-fun-0-'},0}.
  {label,36}.
    {call_only,0,{f,16}}.
