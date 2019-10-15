{module, lists}.  %% version = 0

{exports, [{all,2},
           {any,2},
           {append,1},
           {append,2},
           {concat,1},
           {delete,2},
           {droplast,1},
           {dropwhile,2},
           {duplicate,2},
           {filter,2},
           {map,2},
           {module_info,0},
           {module_info,1},
           {reverse,1},
           {reverse,2},
           {zip,2}]}.

{attributes, []}.

{labels, 63}.


{function, all, 2, 2}.
  {label,1}.
    {line,[{location,"lists.erl",20}]}.
    {func_info,{atom,lists},{atom,all},2}.
  {label,2}.
    {test,is_nonempty_list,{f,5},[{x,1}]}.
    {allocate,2,2}.
    {move,{x,0},{y,1}}.
    {get_list,{x,1},{x,0},{y,0}}.
    {move,{y,1},{x,1}}.
    {line,[{location,"lists.erl",21}]}.
    {call_fun,1}.
    {select_val,{x,0},{f,6},{list,[{atom,true},{f,4},{atom,false},{f,3}]}}.
  {label,3}.
    {deallocate,2}.
    return.
  {label,4}.
    {move,{y,0},{x,1}}.
    {move,{y,1},{x,0}}.
    {call_last,2,{f,2},2}.
  {label,5}.
    {test,is_nil,{f,1},[{x,1}]}.
    {move,{atom,true},{x,0}}.
    return.
  {label,6}.
    {test_heap,3,1}.
    {put_tuple2,{x,0},{list,[{atom,badarg},{x,0}]}}.
    {line,[{location,"lists.erl",21}]}.
    {call_ext,1,{extfunc,erlang,error,1}}.


{function, any, 2, 8}.
  {label,7}.
    {line,[{location,"lists.erl",25}]}.
    {func_info,{atom,lists},{atom,any},2}.
  {label,8}.
    {test,is_nonempty_list,{f,11},[{x,1}]}.
    {allocate,2,2}.
    {move,{x,0},{y,1}}.
    {get_list,{x,1},{x,0},{y,0}}.
    {move,{y,1},{x,1}}.
    {line,[{location,"lists.erl",26}]}.
    {call_fun,1}.
    {select_val,{x,0},{f,12},{list,[{atom,false},{f,10},{atom,true},{f,9}]}}.
  {label,9}.
    {deallocate,2}.
    return.
  {label,10}.
    {move,{y,0},{x,1}}.
    {move,{y,1},{x,0}}.
    {call_last,2,{f,8},2}.
  {label,11}.
    {test,is_nil,{f,7},[{x,1}]}.
    {move,{atom,false},{x,0}}.
    return.
  {label,12}.
    {test_heap,3,1}.
    {put_tuple2,{x,0},{list,[{atom,badarg},{x,0}]}}.
    {line,[{location,"lists.erl",26}]}.
    {call_ext,1,{extfunc,erlang,error,1}}.


{function, append, 1, 14}.
  {label,13}.
    {line,[{location,"lists.erl",30}]}.
    {func_info,{atom,lists},{atom,append},1}.
  {label,14}.
    {move,nil,{x,1}}.
    {call_only,2,{f,16}}.


{function, append11, 2, 16}.
  {label,15}.
    {line,[{location,"lists.erl",33}]}.
    {func_info,{atom,lists},{atom,append11},2}.
  {label,16}.
    {test,is_nonempty_list,{f,18},[{x,0}]}.
    {get_list,{x,0},{x,2},{x,3}}.
    {test,is_nonempty_list,{f,17},[{x,2}]}.
    {test_heap,4,4}.
    {get_list,{x,2},{x,0},{x,2}}.
    {put_list,{x,2},{x,3},{x,2}}.
    {put_list,{x,0},{x,1},{x,1}}.
    {move,{x,2},{x,0}}.
    {call_only,2,{f,16}}.
  {label,17}.
    {test,is_nil,{f,15},[{x,2}]}.
    {move,{x,3},{x,0}}.
    {call_only,2,{f,16}}.
  {label,18}.
    {test,is_nil,{f,15},[{x,0}]}.
    {move,{x,1},{x,0}}.
    {call_only,1,{f,52}}.


{function, append, 2, 20}.
  {label,19}.
    {line,[{location,"lists.erl",40}]}.
    {func_info,{atom,lists},{atom,append},2}.
  {label,20}.
    {allocate,1,2}.
    {move,{x,1},{y,0}}.
    {line,[{location,"lists.erl",41}]}.
    {call,1,{f,52}}.
    {move,{y,0},{x,1}}.
    {call_last,2,{f,22},1}.


{function, append21, 2, 22}.
  {label,21}.
    {line,[{location,"lists.erl",43}]}.
    {func_info,{atom,lists},{atom,append21},2}.
  {label,22}.
    {test,is_nonempty_list,{f,23},[{x,0}]}.
    {test_heap,2,2}.
    {get_list,{x,0},{x,2},{x,0}}.
    {put_list,{x,2},{x,1},{x,1}}.
    {call_only,2,{f,22}}.
  {label,23}.
    {test,is_nil,{f,21},[{x,0}]}.
    {move,{x,1},{x,0}}.
    return.


{function, concat, 1, 25}.
  {label,24}.
    {line,[{location,"lists.erl",48}]}.
    {func_info,{atom,lists},{atom,concat},1}.
  {label,25}.
    {test,is_nonempty_list,{f,29},[{x,0}]}.
    {get_list,{x,0},{x,1},{x,2}}.
    {test,is_atom,{f,26},[{x,1}]}.
    {allocate,1,3}.
    {move,{x,2},{y,0}}.
    {move,{x,1},{x,0}}.
    {line,[{location,"lists.erl",49}]}.
    {call_ext,1,{extfunc,erlang,atom_to_list,1}}.
    {move,{y,0},{x,1}}.
    {move,{x,0},{y,0}}.
    {move,{x,1},{x,0}}.
    {line,[{location,"lists.erl",49}]}.
    {call,1,{f,25}}.
    {move,{x,0},{x,1}}.
    {move,{y,0},{x,0}}.
    {call_last,2,{f,20},1}.
  {label,26}.
    {test,is_integer,{f,27},[{x,1}]}.
    {allocate,1,3}.
    {move,{x,2},{y,0}}.
    {move,{x,1},{x,0}}.
    {line,[{location,"lists.erl",51}]}.
    {call_ext,1,{extfunc,erlang,integer_to_list,1}}.
    {move,{y,0},{x,1}}.
    {move,{x,0},{y,0}}.
    {move,{x,1},{x,0}}.
    {line,[{location,"lists.erl",51}]}.
    {call,1,{f,25}}.
    {move,{x,0},{x,1}}.
    {move,{y,0},{x,0}}.
    {call_last,2,{f,20},1}.
  {label,27}.
    {test,is_float,{f,28},[{x,1}]}.
    {allocate,1,3}.
    {move,{x,2},{y,0}}.
    {move,{x,1},{x,0}}.
    {line,[{location,"lists.erl",53}]}.
    {call_ext,1,{extfunc,erlang,float_to_list,1}}.
    {move,{y,0},{x,1}}.
    {move,{x,0},{y,0}}.
    {move,{x,1},{x,0}}.
    {line,[{location,"lists.erl",53}]}.
    {call,1,{f,25}}.
    {move,{x,0},{x,1}}.
    {move,{y,0},{x,0}}.
    {call_last,2,{f,20},1}.
  {label,28}.
    {test,is_list,{f,24},[{x,1}]}.
    {allocate,1,3}.
    {move,{x,1},{y,0}}.
    {move,{x,2},{x,0}}.
    {line,[{location,"lists.erl",55}]}.
    {call,1,{f,25}}.
    {move,{x,0},{x,1}}.
    {move,{y,0},{x,0}}.
    {call_last,2,{f,20},1}.
  {label,29}.
    {test,is_nil,{f,24},[{x,0}]}.
    return.


{function, delete, 2, 31}.
  {label,30}.
    {line,[{location,"lists.erl",59}]}.
    {func_info,{atom,lists},{atom,delete},2}.
  {label,31}.
    {test,is_nonempty_list,{f,33},[{x,1}]}.
    {get_list,{x,1},{x,2},{x,1}}.
    {test,is_eq_exact,{f,32},[{x,2},{x,0}]}.
    {move,{x,1},{x,0}}.
    return.
  {label,32}.
    {allocate,1,3}.
    {move,{x,2},{y,0}}.
    {line,[{location,"lists.erl",62}]}.
    {call,2,{f,31}}.
    {test_heap,2,1}.
    {put_list,{y,0},{x,0},{x,0}}.
    {deallocate,1}.
    return.
  {label,33}.
    {test,is_nil,{f,30},[{x,1}]}.
    {move,nil,{x,0}}.
    return.


{function, droplast, 1, 35}.
  {label,34}.
    {line,[{location,"lists.erl",66}]}.
    {func_info,{atom,lists},{atom,droplast},1}.
  {label,35}.
    {test,is_nonempty_list,{f,34},[{x,0}]}.
    {get_list,{x,0},{x,1},{x,0}}.
    {test,is_nil,{f,36},[{x,0}]}.
    return.
  {label,36}.
    {allocate,1,2}.
    {move,{x,1},{y,0}}.
    {line,[{location,"lists.erl",69}]}.
    {call,1,{f,35}}.
    {'%',{type_info,{x,0},list}}.
    {test_heap,2,1}.
    {put_list,{y,0},{x,0},{x,0}}.
    {deallocate,1}.
    return.


{function, dropwhile, 2, 38}.
  {label,37}.
    {line,[{location,"lists.erl",71}]}.
    {func_info,{atom,lists},{atom,dropwhile},2}.
  {label,38}.
    {test,is_nonempty_list,{f,40},[{x,1}]}.
    {allocate,3,2}.
    {move,{x,1},{y,1}}.
    {move,{x,0},{y,2}}.
    {get_list,{x,1},{x,0},{y,0}}.
    {move,{y,2},{x,1}}.
    {line,[{location,"lists.erl",72}]}.
    {call_fun,1}.
    {test,is_eq_exact,{f,39},[{x,0},{atom,true}]}.
    {move,{y,0},{x,1}}.
    {move,{y,2},{x,0}}.
    {call_last,2,{f,38},3}.
  {label,39}.
    {move,{y,1},{x,0}}.
    {deallocate,3}.
    return.
  {label,40}.
    {test,is_nil,{f,37},[{x,1}]}.
    {move,nil,{x,0}}.
    return.


{function, duplicate, 2, 42}.
  {label,41}.
    {line,[{location,"lists.erl",81}]}.
    {func_info,{atom,lists},{atom,duplicate},2}.
  {label,42}.
    {test,is_eq_exact,{f,43},[{x,0},{integer,0}]}.
    {move,nil,{x,0}}.
    return.
  {label,43}.
    {line,[{location,"lists.erl",84}]}.
    {gc_bif,'-',{f,0},2,[{x,0},{integer,1}],{x,0}}.
    {allocate,1,2}.
    {move,{x,1},{y,0}}.
    {line,[{location,"lists.erl",84}]}.
    {call,2,{f,42}}.
    {'%',{type_info,{x,0},list}}.
    {test_heap,2,1}.
    {put_list,{y,0},{x,0},{x,0}}.
    {deallocate,1}.
    return.


{function, filter, 2, 45}.
  {label,44}.
    {line,[{location,"lists.erl",86}]}.
    {func_info,{atom,lists},{atom,filter},2}.
  {label,45}.
    {test,is_nonempty_list,{f,47},[{x,1}]}.
    {allocate,3,2}.
    {move,{x,0},{y,2}}.
    {get_list,{x,1},{y,1},{y,0}}.
    {move,{y,2},{x,1}}.
    {move,{y,1},{x,0}}.
    {line,[{location,"lists.erl",87}]}.
    {call_fun,1}.
    {test,is_eq_exact,{f,46},[{x,0},{atom,true}]}.
    {move,{y,0},{x,1}}.
    {move,{y,2},{x,0}}.
    {kill,{y,2}}.
    {trim,1,2}.
    {line,[{location,"lists.erl",89}]}.
    {call,2,{f,45}}.
    {'%',{type_info,{x,0},list}}.
    {test_heap,2,1}.
    {put_list,{y,0},{x,0},{x,0}}.
    {deallocate,2}.
    return.
  {label,46}.
    {move,{y,0},{x,1}}.
    {move,{y,2},{x,0}}.
    {call_last,2,{f,45},3}.
  {label,47}.
    {test,is_nil,{f,44},[{x,1}]}.
    {move,nil,{x,0}}.
    return.


{function, map, 2, 49}.
  {label,48}.
    {line,[{location,"lists.erl",96}]}.
    {func_info,{atom,lists},{atom,map},2}.
  {label,49}.
    {test,is_nonempty_list,{f,50},[{x,1}]}.
    {allocate,2,2}.
    {move,{x,0},{y,1}}.
    {get_list,{x,1},{x,0},{y,0}}.
    {move,{y,1},{x,1}}.
    {line,[{location,"lists.erl",97}]}.
    {call_fun,1}.
    {move,{y,0},{x,2}}.
    {move,{y,1},{x,1}}.
    {move,{x,0},{y,1}}.
    {move,{x,1},{x,0}}.
    {move,{x,2},{x,1}}.
    {trim,1,1}.
    {line,[{location,"lists.erl",97}]}.
    {call,2,{f,49}}.
    {'%',{type_info,{x,0},list}}.
    {test_heap,2,1}.
    {put_list,{y,0},{x,0},{x,0}}.
    {deallocate,1}.
    return.
  {label,50}.
    {test,is_nil,{f,48},[{x,1}]}.
    {move,nil,{x,0}}.
    return.


{function, reverse, 1, 52}.
  {label,51}.
    {line,[{location,"lists.erl",101}]}.
    {func_info,{atom,lists},{atom,reverse},1}.
  {label,52}.
    {move,nil,{x,1}}.
    {call_only,2,{f,54}}.


{function, reverse, 2, 54}.
  {label,53}.
    {line,[{location,"lists.erl",104}]}.
    {func_info,{atom,lists},{atom,reverse},2}.
  {label,54}.
    {test,is_nonempty_list,{f,55},[{x,0}]}.
    {test_heap,2,2}.
    {get_list,{x,0},{x,2},{x,0}}.
    {put_list,{x,2},{x,1},{x,1}}.
    {call_only,2,{f,54}}.
  {label,55}.
    {test,is_nil,{f,53},[{x,0}]}.
    {move,{x,1},{x,0}}.
    return.


{function, zip, 2, 57}.
  {label,56}.
    {line,[{location,"lists.erl",109}]}.
    {func_info,{atom,lists},{atom,zip},2}.
  {label,57}.
    {test,is_nonempty_list,{f,58},[{x,0}]}.
    {get_list,{x,0},{x,2},{x,3}}.
    {test,is_nonempty_list,{f,56},[{x,1}]}.
    {allocate,2,4}.
    {move,{x,2},{y,1}}.
    {get_list,{x,1},{y,0},{x,1}}.
    {move,{x,3},{x,0}}.
    {line,[{location,"lists.erl",110}]}.
    {call,2,{f,57}}.
    {'%',{type_info,{x,0},list}}.
    {test_heap,5,1}.
    {put_tuple2,{x,1},{list,[{y,1},{y,0}]}}.
    {put_list,{x,1},{x,0},{x,0}}.
    {deallocate,2}.
    return.
  {label,58}.
    {test,is_nil,{f,56},[{x,0}]}.
    {test,is_nil,{f,56},[{x,1}]}.
    {move,nil,{x,0}}.
    return.


{function, module_info, 0, 60}.
  {label,59}.
    {line,[]}.
    {func_info,{atom,lists},{atom,module_info},0}.
  {label,60}.
    {move,{atom,lists},{x,0}}.
    {line,[]}.
    {call_ext_only,1,{extfunc,erlang,get_module_info,1}}.


{function, module_info, 1, 62}.
  {label,61}.
    {line,[]}.
    {func_info,{atom,lists},{atom,module_info},1}.
  {label,62}.
    {move,{x,0},{x,1}}.
    {move,{atom,lists},{x,0}}.
    {line,[]}.
    {call_ext_only,2,{extfunc,erlang,get_module_info,2}}.
