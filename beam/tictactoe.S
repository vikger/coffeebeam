{module, tictactoe}.  %% version = 0

{exports, [{module_info,0},{module_info,1},{new_game,1},{put,3},{start,0}]}.

{attributes, []}.

{labels, 129}.


{function, start, 0, 2}.
  {label,1}.
    {line,[{location,"tictactoe.erl",6}]}.
    {func_info,{atom,tictactoe},{atom,start},0}.
  {label,2}.
    {make_fun2,{f,128},0,0,0}.
    {line,[{location,"tictactoe.erl",7}]}.
    {call_ext_only,1,{extfunc,erlang,spawn,1}}.


{function, new_game, 1, 4}.
  {label,3}.
    {line,[{location,"tictactoe.erl",9}]}.
    {func_info,{atom,tictactoe},{atom,new_game},1}.
  {label,4}.
    {allocate,0,1}.
    {move,{atom,new_game},{x,1}}.
    {line,[{location,"tictactoe.erl",10}]}.
    send.
    {deallocate,0}.
    return.


{function, put, 3, 6}.
  {label,5}.
    {line,[{location,"tictactoe.erl",12}]}.
    {func_info,{atom,tictactoe},{atom,put},3}.
  {label,6}.
    {allocate_heap,0,4,3}.
    {put_tuple2,{x,1},{list,[{atom,put},{x,1},{x,2}]}}.
    {line,[{location,"tictactoe.erl",13}]}.
    send.
    {deallocate,0}.
    return.


{function, init, 0, 8}.
  {label,7}.
    {line,[{location,"tictactoe.erl",15}]}.
    {func_info,{atom,tictactoe},{atom,init},0}.
  {label,8}.
    {allocate_zero,1,0}.
    {line,[{location,"tictactoe.erl",16}]}.
    {call,0,{f,80}}.
    {'%',{type_info,{x,0},list}}.
    {move,{x,0},{y,0}}.
    {move,{x,0},{x,1}}.
    {move,{atom,new_game},{x,0}}.
    {line,[{location,"tictactoe.erl",17}]}.
    {call,2,{f,78}}.
    {move,{atom,player},{x,1}}.
    {move,{integer,0},{x,2}}.
    {move,{y,0},{x,0}}.
    {call_last,3,{f,10},1}.


{function, loop, 3, 10}.
  {label,9}.
    {line,[{location,"tictactoe.erl",20}]}.
    {func_info,{atom,tictactoe},{atom,loop},3}.
  {label,10}.
    {'%',{type_info,{x,1},{atom,[]}}}.
    {test,is_eq_exact,{f,11},[{x,2},{integer,9}]}.
    {allocate,0,1}.
    {move,{x,0},{x,1}}.
    {move,{atom,draw},{x,0}}.
    {line,[{location,"tictactoe.erl",21}]}.
    {call,2,{f,78}}.
    {call_last,0,{f,21},0}.
  {label,11}.
    {test,is_eq_exact,{f,18},[{x,1},{atom,player}]}.
    {allocate_zero,4,3}.
    {move,{x,2},{y,2}}.
    {move,{x,0},{y,3}}.
  {label,12}.
    {loop_rec,{f,17},{x,0}}.
    {test,is_tuple,{f,15},[{x,0}]}.
    {test,is_tagged_tuple,{f,16},[{x,0},3,{atom,put}]}.
    remove_message.
    {get_tuple_element,{x,0},1,{y,1}}.
    {get_tuple_element,{x,0},2,{y,0}}.
    {move,{y,0},{x,2}}.
    {move,{y,1},{x,1}}.
    {move,{y,3},{x,0}}.
    {line,[{location,"tictactoe.erl",26}]}.
    {call,3,{f,88}}.
    {test,is_eq_exact,{f,14},[{x,0},{atom,e}]}.
    {move,{y,0},{x,2}}.
    {move,{y,1},{x,1}}.
    {move,{atom,x},{x,3}}.
    {move,{y,3},{x,0}}.
    {kill,{y,0}}.
    {kill,{y,1}}.
    {kill,{y,3}}.
    {line,[{location,"tictactoe.erl",28}]}.
    {call,4,{f,82}}.
    {'%',{type_info,{x,0},cons}}.
    {move,{x,0},{y,3}}.
    {move,{atom,x},{x,1}}.
    {line,[{location,"tictactoe.erl",29}]}.
    {call,2,{f,91}}.
    {'%',{type_info,{x,0},bool}}.
    {test,is_eq_exact,{f,13},[{x,0},{atom,true}]}.
    {move,{y,3},{x,1}}.
    {trim,4,0}.
    {move,{atom,win},{x,0}}.
    {line,[{location,"tictactoe.erl",31}]}.
    {call,2,{f,78}}.
    {call_last,0,{f,21},0}.
  {label,13}.
    {move,{y,3},{x,1}}.
    {move,{atom,put_player},{x,0}}.
    {line,[{location,"tictactoe.erl",34}]}.
    {call,2,{f,78}}.
    {line,[{location,"tictactoe.erl",35}]}.
    {gc_bif,'+',{f,0},0,[{y,2},{integer,1}],{x,2}}.
    {move,{atom,computer},{x,1}}.
    {move,{y,3},{x,0}}.
    {call_last,3,{f,10},4}.
  {label,14}.
    {move,{y,3},{x,1}}.
    {trim,2,2}.
    {move,{atom,invalid},{x,0}}.
    {line,[{location,"tictactoe.erl",38}]}.
    {call,2,{f,78}}.
    {move,{atom,player},{x,1}}.
    {move,{y,0},{x,2}}.
    {move,{y,1},{x,0}}.
    {call_last,3,{f,10},2}.
  {label,15}.
    {test,is_eq_exact,{f,16},[{x,0},{atom,new_game}]}.
    remove_message.
    {call_last,0,{f,8},4}.
  {label,16}.
    {loop_rec_end,{f,12}}.
  {label,17}.
    {wait,{f,12}}.
  {label,18}.
    {allocate,3,3}.
    {init,{y,0}}.
    {move,{x,2},{y,1}}.
    {move,{x,0},{y,2}}.
    {move,{x,0},{x,1}}.
    {move,{literal,[1,2,3]},{x,0}}.
    {line,[{location,"tictactoe.erl",45}]}.
    {call,2,{f,120}}.
    {move,{x,0},{y,0}}.
    {line,[{location,"tictactoe.erl",46}]}.
    {call_ext,1,{extfunc,beamclient,debug,1}}.
    {move,{y,0},{x,0}}.
    {kill,{y,0}}.
    {line,[{location,"tictactoe.erl",47}]}.
    {call,1,{f,26}}.
    {'%',{type_info,{x,0},{tuple,2,#{}}}}.
    {move,{x,0},{y,0}}.
    {line,[{location,"tictactoe.erl",48}]}.
    {call_ext,1,{extfunc,beamclient,debug,1}}.
    {get_tuple_element,{y,0},0,{x,1}}.
    {get_tuple_element,{y,0},1,{x,2}}.
    {move,{atom,o},{x,3}}.
    {move,{y,2},{x,0}}.
    {kill,{y,0}}.
    {kill,{y,2}}.
    {line,[{location,"tictactoe.erl",49}]}.
    {call,4,{f,82}}.
    {'%',{type_info,{x,0},cons}}.
    {move,{x,0},{y,2}}.
    {move,{atom,o},{x,1}}.
    {line,[{location,"tictactoe.erl",50}]}.
    {call,2,{f,91}}.
    {'%',{type_info,{x,0},bool}}.
    {test,is_eq_exact,{f,19},[{x,0},{atom,true}]}.
    {move,{y,2},{x,1}}.
    {trim,3,0}.
    {move,{atom,lose},{x,0}}.
    {line,[{location,"tictactoe.erl",52}]}.
    {call,2,{f,78}}.
    {call_last,0,{f,21},0}.
  {label,19}.
    {move,{y,2},{x,1}}.
    {move,{atom,put_computer},{x,0}}.
    {line,[{location,"tictactoe.erl",55}]}.
    {call,2,{f,78}}.
    {line,[{location,"tictactoe.erl",56}]}.
    {gc_bif,'+',{f,0},0,[{y,1},{integer,1}],{x,2}}.
    {move,{atom,player},{x,1}}.
    {move,{y,2},{x,0}}.
    {call_last,3,{f,10},3}.


{function, end_game, 0, 21}.
  {label,20}.
    {line,[{location,"tictactoe.erl",59}]}.
    {func_info,{atom,tictactoe},{atom,end_game},0}.
  {label,21}.
    {allocate,0,0}.
  {label,22}.
    {loop_rec,{f,24},{x,0}}.
    {test,is_eq_exact,{f,23},[{x,0},{atom,new_game}]}.
    remove_message.
    {call_last,0,{f,8},0}.
  {label,23}.
    remove_message.
    {call_last,0,{f,21},0}.
  {label,24}.
    {wait,{f,22}}.


{function, find_max, 1, 26}.
  {label,25}.
    {line,[{location,"tictactoe.erl",67}]}.
    {func_info,{atom,tictactoe},{atom,find_max},1}.
  {label,26}.
    {test,is_nonempty_list,{f,25},[{x,0}]}.
    {get_list,{x,0},{x,1},{x,0}}.
    {call_only,2,{f,28}}.


{function, find_max1, 2, 28}.
  {label,27}.
    {line,[{location,"tictactoe.erl",69}]}.
    {func_info,{atom,tictactoe},{atom,find_max1},2}.
  {label,28}.
    {test,is_nonempty_list,{f,30},[{x,0}]}.
    {get_list,{x,0},{x,2},{x,0}}.
    {test,is_tuple,{f,29},[{x,2}]}.
    {test,test_arity,{f,29},[{x,2},3]}.
    {test,is_tuple,{f,29},[{x,1}]}.
    {test,test_arity,{f,29},[{x,1},3]}.
    {get_tuple_element,{x,2},2,{x,3}}.
    {get_tuple_element,{x,1},2,{x,4}}.
    {test,is_lt,{f,29},[{x,4},{x,3}]}.
    {move,{x,2},{x,1}}.
    {call_only,2,{f,28}}.
  {label,29}.
    {call_only,2,{f,28}}.
  {label,30}.
    {test,is_nil,{f,27},[{x,0}]}.
    {test,is_tuple,{f,27},[{x,1}]}.
    {test,test_arity,{f,27},[{x,1},3]}.
    {test_heap,3,2}.
    {get_tuple_element,{x,1},0,{x,0}}.
    {get_tuple_element,{x,1},1,{x,1}}.
    {put_tuple2,{x,0},{list,[{x,0},{x,1}]}}.
    return.


{function, check, 3, 32}.
  {label,31}.
    {line,[{location,"tictactoe.erl",76}]}.
    {func_info,{atom,tictactoe},{atom,check},3}.
  {label,32}.
    {allocate,3,3}.
    {move,{x,2},{y,0}}.
    {move,{x,1},{y,1}}.
    {move,{x,0},{y,2}}.
    {line,[{location,"tictactoe.erl",77}]}.
    {call,3,{f,88}}.
    {test,is_eq_exact,{f,33},[{x,0},{atom,e}]}.
    {move,{y,0},{x,2}}.
    {move,{y,1},{x,1}}.
    {move,{atom,o},{x,3}}.
    {move,{y,2},{x,0}}.
    {kill,{y,2}}.
    {line,[{location,"tictactoe.erl",79}]}.
    {call,4,{f,82}}.
    {'%',{type_info,{x,0},cons}}.
    {move,{y,0},{x,2}}.
    {move,{y,1},{x,1}}.
    {line,[{location,"tictactoe.erl",80}]}.
    {call,3,{f,35}}.
    {'%',{type_info,{x,0},number}}.
    {test_heap,4,1}.
    {put_tuple2,{x,0},{list,[{y,1},{y,0},{x,0}]}}.
    {deallocate,3}.
    return.
  {label,33}.
    {test_heap,4,0}.
    {put_tuple2,{x,0},{list,[{y,1},{y,0},{integer,0}]}}.
    {deallocate,3}.
    return.


{function, calculate, 3, 35}.
  {label,34}.
    {line,[{location,"tictactoe.erl",86}]}.
    {func_info,{atom,tictactoe},{atom,calculate},3}.
  {label,35}.
    {'%',{type_info,{x,0},cons}}.
    {allocate,4,3}.
    {init,{y,0}}.
    {move,{x,2},{y,1}}.
    {move,{x,1},{y,2}}.
    {move,{x,0},{y,3}}.
    {move,{atom,o},{x,1}}.
    {line,[{location,"tictactoe.erl",87}]}.
    {call,2,{f,91}}.
    {'%',{type_info,{x,0},bool}}.
    {test,is_eq_exact,{f,36},[{x,0},{atom,true}]}.
    {move,{integer,10000},{x,0}}.
    {deallocate,4}.
    return.
  {label,36}.
    {move,{y,1},{x,1}}.
    {move,{y,3},{x,0}}.
    {line,[{location,"tictactoe.erl",91}]}.
    {call,2,{f,56}}.
    {'%',{type_info,{x,0},cons}}.
    {line,[{location,"tictactoe.erl",91}]}.
    {call,1,{f,38}}.
    {'%',{type_info,{x,0},number}}.
    {move,{y,2},{x,2}}.
    {move,{x,0},{y,0}}.
    {move,{y,3},{x,0}}.
    {move,{x,2},{x,1}}.
    {line,[{location,"tictactoe.erl",91}]}.
    {call,2,{f,58}}.
    {'%',{type_info,{x,0},cons}}.
    {line,[{location,"tictactoe.erl",91}]}.
    {call,1,{f,38}}.
    {'%',{type_info,{x,0},number}}.
    {line,[{location,"tictactoe.erl",91}]}.
    {gc_bif,'+',{f,0},1,[{y,0},{x,0}],{y,0}}.
    {move,{y,1},{x,2}}.
    {move,{y,2},{x,1}}.
    {move,{y,3},{x,0}}.
    {line,[{location,"tictactoe.erl",91}]}.
    {call,3,{f,60}}.
    {line,[{location,"tictactoe.erl",91}]}.
    {call,1,{f,38}}.
    {'%',{type_info,{x,0},number}}.
    {line,[{location,"tictactoe.erl",91}]}.
    {gc_bif,'+',{f,0},1,[{y,0},{x,0}],{y,0}}.
    {move,{y,1},{x,2}}.
    {move,{y,2},{x,1}}.
    {move,{y,3},{x,0}}.
    {move,{y,0},{y,3}}.
    {trim,3,1}.
    {line,[{location,"tictactoe.erl",91}]}.
    {call,3,{f,69}}.
    {line,[{location,"tictactoe.erl",91}]}.
    {call,1,{f,38}}.
    {'%',{type_info,{x,0},number}}.
    {line,[{location,"tictactoe.erl",91}]}.
    {gc_bif,'+',{f,0},1,[{y,0},{x,0}],{x,0}}.
    {deallocate,1}.
    return.


{function, calc, 1, 38}.
  {label,37}.
    {line,[{location,"tictactoe.erl",94}]}.
    {func_info,{atom,tictactoe},{atom,calc},1}.
  {label,38}.
    {test,is_nonempty_list,{f,53},[{x,0}]}.
    {get_list,{x,0},{x,1},{x,0}}.
    {test,is_nonempty_list,{f,39},[{x,0}]}.
    {get_list,{x,0},{x,2},{x,3}}.
    {test,is_nil,{f,39},[{x,3}]}.
    {allocate,1,3}.
    {move,{x,2},{y,0}}.
    {move,{x,1},{x,0}}.
    {line,[{location,"tictactoe.erl",97}]}.
    {call,1,{f,38}}.
    {'%',{type_info,{x,0},number}}.
    {move,{y,0},{x,1}}.
    {move,{x,0},{y,0}}.
    {move,{x,1},{x,0}}.
    {line,[{location,"tictactoe.erl",97}]}.
    {call,1,{f,38}}.
    {'%',{type_info,{x,0},number}}.
    {line,[{location,"tictactoe.erl",97}]}.
    {gc_bif,'+',{f,0},1,[{y,0},{x,0}],{x,0}}.
    {deallocate,1}.
    return.
  {label,39}.
    {select_val,{x,1},
                {f,54},
                {list,[{atom,o},{f,44},{atom,x},{f,42},{atom,e},{f,40}]}}.
  {label,40}.
    {test,is_nonempty_list,{f,54},[{x,0}]}.
    {get_list,{x,0},{x,1},{x,0}}.
    {select_val,{x,1},{f,54},{list,[{atom,o},{f,45},{atom,e},{f,41}]}}.
  {label,41}.
    {test,is_eq_exact,{f,54},[{x,0},{literal,[o]}]}.
    {jump,{f,47}}.
  {label,42}.
    {test,is_nonempty_list,{f,54},[{x,0}]}.
    {get_list,{x,0},{x,1},{x,0}}.
    {select_val,{x,1},{f,54},{list,[{atom,o},{f,49},{atom,x},{f,43}]}}.
  {label,43}.
    {test,is_eq_exact,{f,54},[{x,0},{literal,[o]}]}.
    {jump,{f,50}}.
  {label,44}.
    {test,is_nonempty_list,{f,54},[{x,0}]}.
    {get_list,{x,0},{x,1},{x,0}}.
    {select_val,{x,1},
                {f,54},
                {list,[{atom,o},{f,51},{atom,x},{f,49},{atom,e},{f,45}]}}.
  {label,45}.
    {test,is_nonempty_list,{f,54},[{x,0}]}.
    {get_list,{x,0},{x,1},{x,0}}.
    {select_val,{x,1},{f,54},{list,[{atom,o},{f,48},{atom,e},{f,46}]}}.
  {label,46}.
    {test,is_nil,{f,54},[{x,0}]}.
  {label,47}.
    {move,{integer,10},{x,0}}.
    return.
  {label,48}.
    {test,is_nil,{f,54},[{x,0}]}.
    {jump,{f,52}}.
  {label,49}.
    {test,is_eq_exact,{f,54},[{x,0},{literal,[x]}]}.
  {label,50}.
    {move,{integer,1000},{x,0}}.
    return.
  {label,51}.
    {test,is_eq_exact,{f,54},[{x,0},{literal,[e]}]}.
  {label,52}.
    {move,{integer,100},{x,0}}.
    return.
  {label,53}.
    {test,is_eq_exact,{f,54},[{x,0},{atom,invalid}]}.
    {move,{integer,0},{x,0}}.
    return.
  {label,54}.
    {move,{integer,1},{x,0}}.
    return.


{function, get_row, 2, 56}.
  {label,55}.
    {line,[{location,"tictactoe.erl",119}]}.
    {func_info,{atom,tictactoe},{atom,get_row},2}.
  {label,56}.
    {'%',{type_info,{x,0},cons}}.
    {allocate,3,2}.
    {init,{y,0}}.
    {move,{x,1},{y,1}}.
    {move,{x,0},{y,2}}.
    {move,{x,1},{x,2}}.
    {move,{integer,1},{x,1}}.
    {line,[{location,"tictactoe.erl",120}]}.
    {call,3,{f,88}}.
    {move,{y,1},{x,2}}.
    {move,{x,0},{y,0}}.
    {move,{y,2},{x,0}}.
    {move,{integer,2},{x,1}}.
    {line,[{location,"tictactoe.erl",120}]}.
    {call,3,{f,88}}.
    {move,{y,1},{x,2}}.
    {move,{y,2},{x,1}}.
    {move,{x,0},{y,2}}.
    {move,{x,1},{x,0}}.
    {move,{integer,3},{x,1}}.
    {kill,{y,1}}.
    {line,[{location,"tictactoe.erl",120}]}.
    {call,3,{f,88}}.
    {test_heap,6,1}.
    {put_list,{x,0},nil,{x,0}}.
    {put_list,{y,2},{x,0},{x,0}}.
    {put_list,{y,0},{x,0},{x,0}}.
    {deallocate,3}.
    return.


{function, get_col, 2, 58}.
  {label,57}.
    {line,[{location,"tictactoe.erl",122}]}.
    {func_info,{atom,tictactoe},{atom,get_col},2}.
  {label,58}.
    {'%',{type_info,{x,0},cons}}.
    {allocate,3,2}.
    {init,{y,0}}.
    {move,{x,1},{y,1}}.
    {move,{x,0},{y,2}}.
    {move,{integer,1},{x,2}}.
    {line,[{location,"tictactoe.erl",123}]}.
    {call,3,{f,88}}.
    {move,{y,1},{x,2}}.
    {move,{x,0},{y,0}}.
    {move,{y,2},{x,0}}.
    {move,{x,2},{x,1}}.
    {move,{integer,2},{x,2}}.
    {line,[{location,"tictactoe.erl",123}]}.
    {call,3,{f,88}}.
    {move,{y,1},{x,2}}.
    {move,{y,2},{x,1}}.
    {move,{x,0},{y,2}}.
    {move,{x,1},{x,0}}.
    {move,{x,2},{x,1}}.
    {move,{integer,3},{x,2}}.
    {kill,{y,1}}.
    {line,[{location,"tictactoe.erl",123}]}.
    {call,3,{f,88}}.
    {test_heap,6,1}.
    {put_list,{x,0},nil,{x,0}}.
    {put_list,{y,2},{x,0},{x,0}}.
    {put_list,{y,0},{x,0},{x,0}}.
    {deallocate,3}.
    return.


{function, get_diag1, 3, 60}.
  {label,59}.
    {line,[{location,"tictactoe.erl",125}]}.
    {func_info,{atom,tictactoe},{atom,get_diag1},3}.
  {label,60}.
    {'%',{type_info,{x,0},cons}}.
    {select_val,{x,1},
                {f,65},
                {list,[{integer,1},
                       {f,63},
                       {integer,2},
                       {f,62},
                       {integer,3},
                       {f,61}]}}.
  {label,61}.
    {test,is_eq_exact,{f,65},[{x,2},{integer,3}]}.
    {jump,{f,64}}.
  {label,62}.
    {test,is_eq_exact,{f,65},[{x,2},{integer,2}]}.
    {jump,{f,64}}.
  {label,63}.
    {test,is_eq_exact,{f,65},[{x,2},{integer,1}]}.
  {label,64}.
    {call_only,1,{f,67}}.
  {label,65}.
    {move,{atom,invalid},{x,0}}.
    return.


{function, do_get_diag1, 1, 67}.
  {label,66}.
    {line,[{location,"tictactoe.erl",134}]}.
    {func_info,{atom,tictactoe},{atom,do_get_diag1},1}.
  {label,67}.
    {'%',{type_info,{x,0},cons}}.
    {allocate_zero,2,1}.
    {move,{x,0},{y,1}}.
    {move,{integer,1},{x,2}}.
    {move,{integer,1},{x,1}}.
    {line,[{location,"tictactoe.erl",135}]}.
    {call,3,{f,88}}.
    {move,{x,0},{y,0}}.
    {move,{y,1},{x,1}}.
    {move,{integer,2},{x,2}}.
    {move,{x,1},{x,0}}.
    {move,{integer,2},{x,1}}.
    {line,[{location,"tictactoe.erl",135}]}.
    {call,3,{f,88}}.
    {move,{y,1},{x,1}}.
    {move,{x,0},{y,1}}.
    {move,{integer,3},{x,2}}.
    {move,{x,1},{x,0}}.
    {move,{integer,3},{x,1}}.
    {line,[{location,"tictactoe.erl",135}]}.
    {call,3,{f,88}}.
    {test_heap,6,1}.
    {put_list,{x,0},nil,{x,0}}.
    {put_list,{y,1},{x,0},{x,0}}.
    {put_list,{y,0},{x,0},{x,0}}.
    {deallocate,2}.
    return.


{function, get_diag2, 3, 69}.
  {label,68}.
    {line,[{location,"tictactoe.erl",137}]}.
    {func_info,{atom,tictactoe},{atom,get_diag2},3}.
  {label,69}.
    {'%',{type_info,{x,0},cons}}.
    {select_val,{x,1},
                {f,74},
                {list,[{integer,1},
                       {f,72},
                       {integer,2},
                       {f,71},
                       {integer,3},
                       {f,70}]}}.
  {label,70}.
    {test,is_eq_exact,{f,74},[{x,2},{integer,1}]}.
    {jump,{f,73}}.
  {label,71}.
    {test,is_eq_exact,{f,74},[{x,2},{integer,2}]}.
    {jump,{f,73}}.
  {label,72}.
    {test,is_eq_exact,{f,74},[{x,2},{integer,3}]}.
  {label,73}.
    {call_only,1,{f,76}}.
  {label,74}.
    {move,{atom,invalid},{x,0}}.
    return.


{function, do_get_diag2, 1, 76}.
  {label,75}.
    {line,[{location,"tictactoe.erl",146}]}.
    {func_info,{atom,tictactoe},{atom,do_get_diag2},1}.
  {label,76}.
    {'%',{type_info,{x,0},cons}}.
    {allocate_zero,2,1}.
    {move,{x,0},{y,1}}.
    {move,{integer,1},{x,2}}.
    {move,{integer,3},{x,1}}.
    {line,[{location,"tictactoe.erl",147}]}.
    {call,3,{f,88}}.
    {move,{x,0},{y,0}}.
    {move,{y,1},{x,1}}.
    {move,{integer,2},{x,2}}.
    {move,{x,1},{x,0}}.
    {move,{integer,2},{x,1}}.
    {line,[{location,"tictactoe.erl",147}]}.
    {call,3,{f,88}}.
    {move,{y,1},{x,1}}.
    {move,{x,0},{y,1}}.
    {move,{integer,3},{x,2}}.
    {move,{x,1},{x,0}}.
    {move,{integer,1},{x,1}}.
    {line,[{location,"tictactoe.erl",147}]}.
    {call,3,{f,88}}.
    {test_heap,6,1}.
    {put_list,{x,0},nil,{x,0}}.
    {put_list,{y,1},{x,0},{x,0}}.
    {put_list,{y,0},{x,0},{x,0}}.
    {deallocate,2}.
    return.


{function, update, 2, 78}.
  {label,77}.
    {line,[{location,"tictactoe.erl",149}]}.
    {func_info,{atom,tictactoe},{atom,update},2}.
  {label,78}.
    {'%',{type_info,{x,0},{atom,[]}}}.
    {test_heap,3,2}.
    {put_tuple2,{x,0},{list,[{x,0},{x,1}]}}.
    {line,[{location,"tictactoe.erl",150}]}.
    {call_ext_only,1,{extfunc,beamclient,update,1}}.


{function, init_board, 0, 80}.
  {label,79}.
    {line,[{location,"tictactoe.erl",159}]}.
    {func_info,{atom,tictactoe},{atom,init_board},0}.
  {label,80}.
    {allocate,0,0}.
    {move,{atom,e},{x,1}}.
    {move,{integer,3},{x,0}}.
    {line,[{location,"tictactoe.erl",160}]}.
    {call,2,{f,110}}.
    {'%',{type_info,{x,0},list}}.
    {move,{x,0},{x,1}}.
    {move,{integer,3},{x,0}}.
    {call_last,2,{f,110},0}.


{function, put, 4, 82}.
  {label,81}.
    {line,[{location,"tictactoe.erl",162}]}.
    {func_info,{atom,tictactoe},{atom,put},4}.
  {label,82}.
    {test,is_nonempty_list,{f,81},[{x,0}]}.
    {get_list,{x,0},{x,4},{x,0}}.
    {test,is_eq_exact,{f,83},[{x,2},{integer,1}]}.
    {allocate,1,5}.
    {move,{x,0},{y,0}}.
    {move,{x,3},{x,2}}.
    {move,{x,4},{x,0}}.
    {line,[{location,"tictactoe.erl",163}]}.
    {call,3,{f,85}}.
    {'%',{type_info,{x,0},cons}}.
    {test_heap,2,1}.
    {put_list,{x,0},{y,0},{x,0}}.
    {deallocate,1}.
    return.
  {label,83}.
    {line,[{location,"tictactoe.erl",165}]}.
    {gc_bif,'-',{f,0},5,[{x,2},{integer,1}],{x,2}}.
    {allocate,1,5}.
    {move,{x,4},{y,0}}.
    {line,[{location,"tictactoe.erl",165}]}.
    {call,4,{f,82}}.
    {'%',{type_info,{x,0},cons}}.
    {test_heap,2,1}.
    {put_list,{y,0},{x,0},{x,0}}.
    {deallocate,1}.
    return.


{function, put1, 3, 85}.
  {label,84}.
    {line,[{location,"tictactoe.erl",167}]}.
    {func_info,{atom,tictactoe},{atom,put1},3}.
  {label,85}.
    {test,is_nonempty_list,{f,84},[{x,0}]}.
    {get_list,{x,0},{x,3},{x,0}}.
    {test,is_eq_exact,{f,86},[{x,1},{integer,1}]}.
    {test_heap,2,3}.
    {put_list,{x,2},{x,0},{x,0}}.
    return.
  {label,86}.
    {line,[{location,"tictactoe.erl",170}]}.
    {gc_bif,'-',{f,0},4,[{x,1},{integer,1}],{x,1}}.
    {allocate,1,4}.
    {move,{x,3},{y,0}}.
    {line,[{location,"tictactoe.erl",170}]}.
    {call,3,{f,85}}.
    {'%',{type_info,{x,0},cons}}.
    {test_heap,2,1}.
    {put_list,{y,0},{x,0},{x,0}}.
    {deallocate,1}.
    return.


{function, get, 3, 88}.
  {label,87}.
    {line,[{location,"tictactoe.erl",172}]}.
    {func_info,{atom,tictactoe},{atom,get},3}.
  {label,88}.
    {test,is_ge,{f,89},[{x,1},{integer,1}]}.
    {test,is_ge,{f,89},[{integer,3},{x,1}]}.
    {test,is_ge,{f,89},[{x,2},{integer,1}]}.
    {test,is_ge,{f,89},[{integer,3},{x,2}]}.
    {allocate,1,3}.
    {move,{x,1},{y,0}}.
    {move,{x,0},{x,1}}.
    {move,{x,2},{x,0}}.
    {line,[{location,"tictactoe.erl",173}]}.
    {call,2,{f,113}}.
    {move,{x,0},{x,1}}.
    {move,{y,0},{x,0}}.
    {call_last,2,{f,113},1}.
  {label,89}.
    {move,{atom,invalid},{x,0}}.
    return.


{function, is_winner, 2, 91}.
  {label,90}.
    {line,[{location,"tictactoe.erl",177}]}.
    {func_info,{atom,tictactoe},{atom,is_winner},2}.
  {label,91}.
    {'%',{type_info,{x,0},cons}}.
    {'%',{type_info,{x,1},{atom,[]}}}.
    {allocate,2,2}.
    {move,{x,1},{y,0}}.
    {move,{x,0},{y,1}}.
    {line,[{location,"tictactoe.erl",178}]}.
    {call,2,{f,95}}.
    {'%',{type_info,{x,0},bool}}.
    {test,is_ne_exact,{f,92},[{x,0},{atom,true}]}.
    {move,{y,0},{x,1}}.
    {move,{y,1},{x,0}}.
    {line,[{location,"tictactoe.erl",178}]}.
    {call,2,{f,99}}.
    {'%',{type_info,{x,0},bool}}.
    {test,is_eq_exact,{f,93},[{x,0},{atom,true}]}.
  {label,92}.
    {deallocate,2}.
    return.
  {label,93}.
    {move,{y,0},{x,1}}.
    {move,{y,1},{x,0}}.
    {call_last,2,{f,103},2}.


{function, all_row, 2, 95}.
  {label,94}.
    {line,[{location,"tictactoe.erl",180}]}.
    {func_info,{atom,tictactoe},{atom,all_row},2}.
  {label,95}.
    {'%',{type_info,{x,0},cons}}.
    {'%',{type_info,{x,1},{atom,[]}}}.
    {allocate,2,2}.
    {move,{x,1},{y,0}}.
    {move,{x,0},{y,1}}.
    {move,{x,1},{x,2}}.
    {move,{literal,[{1,1},{2,1},{3,1}]},{x,1}}.
    {line,[{location,"tictactoe.erl",181}]}.
    {call,3,{f,106}}.
    {'%',{type_info,{x,0},bool}}.
    {test,is_ne_exact,{f,96},[{x,0},{atom,true}]}.
    {move,{literal,[{1,2},{2,2},{3,2}]},{x,1}}.
    {move,{y,0},{x,2}}.
    {move,{y,1},{x,0}}.
    {line,[{location,"tictactoe.erl",182}]}.
    {call,3,{f,106}}.
    {'%',{type_info,{x,0},bool}}.
    {test,is_eq_exact,{f,97},[{x,0},{atom,true}]}.
  {label,96}.
    {deallocate,2}.
    return.
  {label,97}.
    {move,{literal,[{1,3},{2,3},{3,3}]},{x,1}}.
    {move,{y,0},{x,2}}.
    {move,{y,1},{x,0}}.
    {call_last,3,{f,106},2}.


{function, all_col, 2, 99}.
  {label,98}.
    {line,[{location,"tictactoe.erl",185}]}.
    {func_info,{atom,tictactoe},{atom,all_col},2}.
  {label,99}.
    {'%',{type_info,{x,0},cons}}.
    {'%',{type_info,{x,1},{atom,[]}}}.
    {allocate,2,2}.
    {move,{x,1},{y,0}}.
    {move,{x,0},{y,1}}.
    {move,{x,1},{x,2}}.
    {move,{literal,[{1,1},{1,2},{1,3}]},{x,1}}.
    {line,[{location,"tictactoe.erl",186}]}.
    {call,3,{f,106}}.
    {'%',{type_info,{x,0},bool}}.
    {test,is_ne_exact,{f,100},[{x,0},{atom,true}]}.
    {move,{literal,[{2,1},{2,2},{2,3}]},{x,1}}.
    {move,{y,0},{x,2}}.
    {move,{y,1},{x,0}}.
    {line,[{location,"tictactoe.erl",187}]}.
    {call,3,{f,106}}.
    {'%',{type_info,{x,0},bool}}.
    {test,is_eq_exact,{f,101},[{x,0},{atom,true}]}.
  {label,100}.
    {deallocate,2}.
    return.
  {label,101}.
    {move,{literal,[{3,1},{3,2},{3,3}]},{x,1}}.
    {move,{y,0},{x,2}}.
    {move,{y,1},{x,0}}.
    {call_last,3,{f,106},2}.


{function, all_diag, 2, 103}.
  {label,102}.
    {line,[{location,"tictactoe.erl",190}]}.
    {func_info,{atom,tictactoe},{atom,all_diag},2}.
  {label,103}.
    {'%',{type_info,{x,0},cons}}.
    {'%',{type_info,{x,1},{atom,[]}}}.
    {allocate,2,2}.
    {move,{x,1},{y,0}}.
    {move,{x,0},{y,1}}.
    {move,{x,1},{x,2}}.
    {move,{literal,[{1,1},{2,2},{3,3}]},{x,1}}.
    {line,[{location,"tictactoe.erl",191}]}.
    {call,3,{f,106}}.
    {'%',{type_info,{x,0},bool}}.
    {test,is_eq_exact,{f,104},[{x,0},{atom,true}]}.
    {deallocate,2}.
    return.
  {label,104}.
    {move,{literal,[{3,1},{2,2},{1,3}]},{x,1}}.
    {move,{y,0},{x,2}}.
    {move,{y,1},{x,0}}.
    {call_last,3,{f,106},2}.


{function, all, 3, 106}.
  {label,105}.
    {line,[{location,"tictactoe.erl",194}]}.
    {func_info,{atom,tictactoe},{atom,all},3}.
  {label,106}.
    {test,is_nonempty_list,{f,108},[{x,1}]}.
    {get_list,{x,1},{x,3},{x,4}}.
    {test,is_tuple,{f,105},[{x,3}]}.
    {test,test_arity,{f,105},[{x,3},2]}.
    {allocate,3,5}.
    {move,{x,4},{y,0}}.
    {move,{x,2},{y,1}}.
    {move,{x,0},{y,2}}.
    {get_tuple_element,{x,3},0,{x,1}}.
    {get_tuple_element,{x,3},1,{x,2}}.
    {line,[{location,"tictactoe.erl",195}]}.
    {call,3,{f,88}}.
    {test,is_eq_exact,{f,107},[{x,0},{y,1}]}.
    {move,{y,0},{x,1}}.
    {move,{y,1},{x,2}}.
    {move,{y,2},{x,0}}.
    {call_last,3,{f,106},3}.
  {label,107}.
    {move,{atom,false},{x,0}}.
    {deallocate,3}.
    return.
  {label,108}.
    {test,is_nil,{f,105},[{x,1}]}.
    {move,{atom,true},{x,0}}.
    return.


{function, duplicate, 2, 110}.
  {label,109}.
    {line,[{location,"tictactoe.erl",202}]}.
    {func_info,{atom,tictactoe},{atom,duplicate},2}.
  {label,110}.
    {'%',{type_info,{x,0},number}}.
    {test,is_eq_exact,{f,111},[{x,0},{integer,0}]}.
    {move,nil,{x,0}}.
    return.
  {label,111}.
    {line,[{location,"tictactoe.erl",205}]}.
    {gc_bif,'-',{f,0},2,[{x,0},{integer,1}],{x,0}}.
    {allocate,1,2}.
    {move,{x,1},{y,0}}.
    {line,[{location,"tictactoe.erl",205}]}.
    {call,2,{f,110}}.
    {'%',{type_info,{x,0},list}}.
    {test_heap,2,1}.
    {put_list,{y,0},{x,0},{x,0}}.
    {deallocate,1}.
    return.


{function, nth, 2, 113}.
  {label,112}.
    {line,[{location,"tictactoe.erl",207}]}.
    {func_info,{atom,tictactoe},{atom,nth},2}.
  {label,113}.
    {test,is_eq_exact,{f,114},[{x,0},{integer,1}]}.
    {test,is_nonempty_list,{f,112},[{x,1}]}.
    {get_hd,{x,1},{x,0}}.
    return.
  {label,114}.
    {test,is_nonempty_list,{f,112},[{x,1}]}.
    {get_tl,{x,1},{x,1}}.
    {line,[{location,"tictactoe.erl",210}]}.
    {gc_bif,'-',{f,0},2,[{x,0},{integer,1}],{x,0}}.
    {call_only,2,{f,113}}.


{function, module_info, 0, 116}.
  {label,115}.
    {line,[]}.
    {func_info,{atom,tictactoe},{atom,module_info},0}.
  {label,116}.
    {move,{atom,tictactoe},{x,0}}.
    {line,[]}.
    {call_ext_only,1,{extfunc,erlang,get_module_info,1}}.


{function, module_info, 1, 118}.
  {label,117}.
    {line,[]}.
    {func_info,{atom,tictactoe},{atom,module_info},1}.
  {label,118}.
    {move,{x,0},{x,1}}.
    {move,{atom,tictactoe},{x,0}}.
    {line,[]}.
    {call_ext_only,2,{extfunc,erlang,get_module_info,2}}.


{function, '-loop/3-lc$^0/1-0-', 2, 120}.
  {label,119}.
    {line,[{location,"tictactoe.erl",45}]}.
    {func_info,{atom,tictactoe},{atom,'-loop/3-lc$^0/1-0-'},2}.
  {label,120}.
    {test,is_nonempty_list,{f,121},[{x,0}]}.
    {get_list,{x,0},{x,3},{x,2}}.
    {move,{literal,[1,2,3]},{x,0}}.
    {call_only,4,{f,124}}.
  {label,121}.
    {test,is_nil,{f,122},[{x,0}]}.
    return.
  {label,122}.
    {test_heap,2,1}.
    {put_list,{x,0},nil,{x,1}}.
    {move,{atom,function_clause},{x,0}}.
    {line,[{location,"tictactoe.erl",45}]}.
    {call_ext,2,{extfunc,erlang,error,2}}.


{function, '-loop/3-lc$^1/1-1-', 4, 124}.
  {label,123}.
    {line,[{location,"tictactoe.erl",45}]}.
    {func_info,{atom,tictactoe},{atom,'-loop/3-lc$^1/1-1-'},4}.
  {label,124}.
    {test,is_nonempty_list,{f,125},[{x,0}]}.
    {allocate,4,4}.
    {move,{x,3},{y,1}}.
    {move,{x,2},{y,2}}.
    {move,{x,1},{y,3}}.
    {get_list,{x,0},{x,2},{y,0}}.
    {move,{x,1},{x,0}}.
    {move,{x,3},{x,1}}.
    {line,[{location,"tictactoe.erl",45}]}.
    {call,3,{f,32}}.
    {'%',{type_info,{x,0},{tuple,3,#{{integer,3} => number}}}}.
    {move,{y,1},{x,4}}.
    {move,{y,2},{x,3}}.
    {move,{y,3},{x,2}}.
    {move,{x,0},{y,3}}.
    {move,{y,0},{x,0}}.
    {move,{x,2},{x,1}}.
    {move,{x,3},{x,2}}.
    {move,{x,4},{x,3}}.
    {trim,3,1}.
    {line,[{location,"tictactoe.erl",45}]}.
    {call,4,{f,124}}.
    {test_heap,2,1}.
    {put_list,{y,0},{x,0},{x,0}}.
    {deallocate,1}.
    return.
  {label,125}.
    {test,is_nil,{f,126},[{x,0}]}.
    {move,{x,2},{x,0}}.
    {call_only,2,{f,120}}.
  {label,126}.
    {test_heap,2,1}.
    {put_list,{x,0},nil,{x,1}}.
    {move,{atom,function_clause},{x,0}}.
    {line,[{location,"tictactoe.erl",45}]}.
    {call_ext,2,{extfunc,erlang,error,2}}.


{function, '-start/0-fun-0-', 0, 128}.
  {label,127}.
    {line,[{location,"tictactoe.erl",7}]}.
    {func_info,{atom,tictactoe},{atom,'-start/0-fun-0-'},0}.
  {label,128}.
    {call_only,0,{f,8}}.
