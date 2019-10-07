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

{labels, 59}.


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
    {test,is_nonempty_list,{f,16},[{x,0}]}.
    {get_list,{x,0},{x,1},{x,2}}.
    {test,is_nonempty_list,{f,15},[{x,1}]}.
    {allocate_heap,1,2,3}.
    {get_list,{x,1},{y,0},{x,0}}.
    {put_list,{x,0},{x,2},{x,0}}.
    {line,[{location,"lists.erl",31}]}.
    {call,1,{f,14}}.
    {'%',{type_info,{x,0},list}}.
    {test_heap,2,1}.
    {put_list,{y,0},{x,0},{x,0}}.
    {deallocate,1}.
    return.
  {label,15}.
    {test,is_nil,{f,13},[{x,1}]}.
    {move,{x,2},{x,0}}.
    {call_only,1,{f,14}}.
  {label,16}.
    {test,is_nil,{f,13},[{x,0}]}.
    return.


{function, append, 2, 18}.
  {label,17}.
    {line,[{location,"lists.erl",37}]}.
    {func_info,{atom,lists},{atom,append},2}.
  {label,18}.
    {test,is_nonempty_list,{f,19},[{x,0}]}.
    {allocate,1,2}.
    {get_list,{x,0},{y,0},{x,0}}.
    {line,[{location,"lists.erl",38}]}.
    {call,2,{f,18}}.
    {test_heap,2,1}.
    {put_list,{y,0},{x,0},{x,0}}.
    {deallocate,1}.
    return.
  {label,19}.
    {test,is_nil,{f,17},[{x,0}]}.
    {move,{x,1},{x,0}}.
    return.


{function, concat, 1, 21}.
  {label,20}.
    {line,[{location,"lists.erl",42}]}.
    {func_info,{atom,lists},{atom,concat},1}.
  {label,21}.
    {test,is_nonempty_list,{f,25},[{x,0}]}.
    {get_list,{x,0},{x,1},{x,2}}.
    {test,is_atom,{f,22},[{x,1}]}.
    {allocate,1,3}.
    {move,{x,2},{y,0}}.
    {move,{x,1},{x,0}}.
    {line,[{location,"lists.erl",43}]}.
    {call_ext,1,{extfunc,erlang,atom_to_list,1}}.
    {move,{y,0},{x,1}}.
    {move,{x,0},{y,0}}.
    {move,{x,1},{x,0}}.
    {line,[{location,"lists.erl",43}]}.
    {call,1,{f,21}}.
    {move,{x,0},{x,1}}.
    {move,{y,0},{x,0}}.
    {call_last,2,{f,18},1}.
  {label,22}.
    {test,is_integer,{f,23},[{x,1}]}.
    {allocate,1,3}.
    {move,{x,2},{y,0}}.
    {move,{x,1},{x,0}}.
    {line,[{location,"lists.erl",45}]}.
    {call_ext,1,{extfunc,erlang,integer_to_list,1}}.
    {move,{y,0},{x,1}}.
    {move,{x,0},{y,0}}.
    {move,{x,1},{x,0}}.
    {line,[{location,"lists.erl",45}]}.
    {call,1,{f,21}}.
    {move,{x,0},{x,1}}.
    {move,{y,0},{x,0}}.
    {call_last,2,{f,18},1}.
  {label,23}.
    {test,is_float,{f,24},[{x,1}]}.
    {allocate,1,3}.
    {move,{x,2},{y,0}}.
    {move,{x,1},{x,0}}.
    {line,[{location,"lists.erl",47}]}.
    {call_ext,1,{extfunc,erlang,float_to_list,1}}.
    {move,{y,0},{x,1}}.
    {move,{x,0},{y,0}}.
    {move,{x,1},{x,0}}.
    {line,[{location,"lists.erl",47}]}.
    {call,1,{f,21}}.
    {move,{x,0},{x,1}}.
    {move,{y,0},{x,0}}.
    {call_last,2,{f,18},1}.
  {label,24}.
    {test,is_list,{f,20},[{x,1}]}.
    {allocate,1,3}.
    {move,{x,1},{y,0}}.
    {move,{x,2},{x,0}}.
    {line,[{location,"lists.erl",49}]}.
    {call,1,{f,21}}.
    {move,{x,0},{x,1}}.
    {move,{y,0},{x,0}}.
    {call_last,2,{f,18},1}.
  {label,25}.
    {test,is_nil,{f,20},[{x,0}]}.
    return.


{function, delete, 2, 27}.
  {label,26}.
    {line,[{location,"lists.erl",53}]}.
    {func_info,{atom,lists},{atom,delete},2}.
  {label,27}.
    {test,is_nonempty_list,{f,29},[{x,1}]}.
    {get_list,{x,1},{x,2},{x,1}}.
    {test,is_eq_exact,{f,28},[{x,2},{x,0}]}.
    {move,{x,1},{x,0}}.
    return.
  {label,28}.
    {allocate,1,3}.
    {move,{x,2},{y,0}}.
    {line,[{location,"lists.erl",56}]}.
    {call,2,{f,27}}.
    {test_heap,2,1}.
    {put_list,{y,0},{x,0},{x,0}}.
    {deallocate,1}.
    return.
  {label,29}.
    {test,is_nil,{f,26},[{x,1}]}.
    {move,nil,{x,0}}.
    return.


{function, droplast, 1, 31}.
  {label,30}.
    {line,[{location,"lists.erl",60}]}.
    {func_info,{atom,lists},{atom,droplast},1}.
  {label,31}.
    {test,is_nonempty_list,{f,30},[{x,0}]}.
    {get_list,{x,0},{x,1},{x,0}}.
    {test,is_nil,{f,32},[{x,0}]}.
    return.
  {label,32}.
    {allocate,1,2}.
    {move,{x,1},{y,0}}.
    {line,[{location,"lists.erl",63}]}.
    {call,1,{f,31}}.
    {'%',{type_info,{x,0},list}}.
    {test_heap,2,1}.
    {put_list,{y,0},{x,0},{x,0}}.
    {deallocate,1}.
    return.


{function, dropwhile, 2, 34}.
  {label,33}.
    {line,[{location,"lists.erl",65}]}.
    {func_info,{atom,lists},{atom,dropwhile},2}.
  {label,34}.
    {test,is_nonempty_list,{f,36},[{x,1}]}.
    {allocate,3,2}.
    {move,{x,1},{y,1}}.
    {move,{x,0},{y,2}}.
    {get_list,{x,1},{x,0},{y,0}}.
    {move,{y,2},{x,1}}.
    {line,[{location,"lists.erl",66}]}.
    {call_fun,1}.
    {test,is_eq_exact,{f,35},[{x,0},{atom,true}]}.
    {move,{y,0},{x,1}}.
    {move,{y,2},{x,0}}.
    {call_last,2,{f,34},3}.
  {label,35}.
    {move,{y,1},{x,0}}.
    {deallocate,3}.
    return.
  {label,36}.
    {test,is_nil,{f,33},[{x,1}]}.
    {move,nil,{x,0}}.
    return.


{function, duplicate, 2, 38}.
  {label,37}.
    {line,[{location,"lists.erl",75}]}.
    {func_info,{atom,lists},{atom,duplicate},2}.
  {label,38}.
    {test,is_eq_exact,{f,39},[{x,0},{integer,0}]}.
    {move,nil,{x,0}}.
    return.
  {label,39}.
    {line,[{location,"lists.erl",78}]}.
    {gc_bif,'-',{f,0},2,[{x,0},{integer,1}],{x,0}}.
    {allocate,1,2}.
    {move,{x,1},{y,0}}.
    {line,[{location,"lists.erl",78}]}.
    {call,2,{f,38}}.
    {'%',{type_info,{x,0},list}}.
    {test_heap,2,1}.
    {put_list,{y,0},{x,0},{x,0}}.
    {deallocate,1}.
    return.


{function, filter, 2, 41}.
  {label,40}.
    {line,[{location,"lists.erl",80}]}.
    {func_info,{atom,lists},{atom,filter},2}.
  {label,41}.
    {test,is_nonempty_list,{f,43},[{x,1}]}.
    {allocate,3,2}.
    {move,{x,0},{y,2}}.
    {get_list,{x,1},{y,1},{y,0}}.
    {move,{y,2},{x,1}}.
    {move,{y,1},{x,0}}.
    {line,[{location,"lists.erl",81}]}.
    {call_fun,1}.
    {test,is_eq_exact,{f,42},[{x,0},{atom,true}]}.
    {move,{y,0},{x,1}}.
    {move,{y,2},{x,0}}.
    {kill,{y,2}}.
    {trim,1,2}.
    {line,[{location,"lists.erl",83}]}.
    {call,2,{f,41}}.
    {'%',{type_info,{x,0},list}}.
    {test_heap,2,1}.
    {put_list,{y,0},{x,0},{x,0}}.
    {deallocate,2}.
    return.
  {label,42}.
    {move,{y,0},{x,1}}.
    {move,{y,2},{x,0}}.
    {call_last,2,{f,41},3}.
  {label,43}.
    {test,is_nil,{f,40},[{x,1}]}.
    {move,nil,{x,0}}.
    return.


{function, map, 2, 45}.
  {label,44}.
    {line,[{location,"lists.erl",90}]}.
    {func_info,{atom,lists},{atom,map},2}.
  {label,45}.
    {test,is_nonempty_list,{f,46},[{x,1}]}.
    {allocate,2,2}.
    {move,{x,0},{y,1}}.
    {get_list,{x,1},{x,0},{y,0}}.
    {move,{y,1},{x,1}}.
    {line,[{location,"lists.erl",91}]}.
    {call_fun,1}.
    {move,{y,0},{x,2}}.
    {move,{y,1},{x,1}}.
    {move,{x,0},{y,1}}.
    {move,{x,1},{x,0}}.
    {move,{x,2},{x,1}}.
    {trim,1,1}.
    {line,[{location,"lists.erl",91}]}.
    {call,2,{f,45}}.
    {'%',{type_info,{x,0},list}}.
    {test_heap,2,1}.
    {put_list,{y,0},{x,0},{x,0}}.
    {deallocate,1}.
    return.
  {label,46}.
    {test,is_nil,{f,44},[{x,1}]}.
    {move,nil,{x,0}}.
    return.


{function, reverse, 1, 48}.
  {label,47}.
    {line,[{location,"lists.erl",95}]}.
    {func_info,{atom,lists},{atom,reverse},1}.
  {label,48}.
    {move,nil,{x,1}}.
    {call_only,2,{f,50}}.


{function, reverse, 2, 50}.
  {label,49}.
    {line,[{location,"lists.erl",98}]}.
    {func_info,{atom,lists},{atom,reverse},2}.
  {label,50}.
    {test,is_nonempty_list,{f,51},[{x,0}]}.
    {test_heap,2,2}.
    {get_list,{x,0},{x,2},{x,0}}.
    {put_list,{x,2},{x,1},{x,1}}.
    {call_only,2,{f,50}}.
  {label,51}.
    {test,is_nil,{f,49},[{x,0}]}.
    {move,{x,1},{x,0}}.
    return.


{function, zip, 2, 53}.
  {label,52}.
    {line,[{location,"lists.erl",103}]}.
    {func_info,{atom,lists},{atom,zip},2}.
  {label,53}.
    {test,is_nonempty_list,{f,54},[{x,0}]}.
    {get_list,{x,0},{x,2},{x,3}}.
    {test,is_nonempty_list,{f,52},[{x,1}]}.
    {allocate,2,4}.
    {move,{x,2},{y,1}}.
    {get_list,{x,1},{y,0},{x,1}}.
    {move,{x,3},{x,0}}.
    {line,[{location,"lists.erl",104}]}.
    {call,2,{f,53}}.
    {'%',{type_info,{x,0},list}}.
    {test_heap,5,1}.
    {put_tuple2,{x,1},{list,[{y,1},{y,0}]}}.
    {put_list,{x,1},{x,0},{x,0}}.
    {deallocate,2}.
    return.
  {label,54}.
    {test,is_nil,{f,52},[{x,0}]}.
    {test,is_nil,{f,52},[{x,1}]}.
    {move,nil,{x,0}}.
    return.


{function, module_info, 0, 56}.
  {label,55}.
    {line,[]}.
    {func_info,{atom,lists},{atom,module_info},0}.
  {label,56}.
    {move,{atom,lists},{x,0}}.
    {line,[]}.
    {call_ext_only,1,{extfunc,erlang,get_module_info,1}}.


{function, module_info, 1, 58}.
  {label,57}.
    {line,[]}.
    {func_info,{atom,lists},{atom,module_info},1}.
  {label,58}.
    {move,{x,0},{x,1}}.
    {move,{atom,lists},{x,0}}.
    {line,[]}.
    {call_ext_only,2,{extfunc,erlang,get_module_info,2}}.
