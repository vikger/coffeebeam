{module, lists}.  %% version = 0

{exports, [{all,2},
           {any,2},
           {append,1},
           {append,2},
           {concat,1},
           {delete,2},
           {droplast,1},
           {dropwhile,2},
           {module_info,0},
           {module_info,1}]}.

{attributes, []}.

{labels, 41}.


{function, all, 2, 2}.
  {label,1}.
    {line,[{location,"lists.erl",14}]}.
    {func_info,{atom,lists},{atom,all},2}.
  {label,2}.
    {test,is_nonempty_list,{f,5},[{x,1}]}.
    {allocate,2,2}.
    {move,{x,0},{y,1}}.
    {get_list,{x,1},{x,0},{y,0}}.
    {move,{y,1},{x,1}}.
    {line,[{location,"lists.erl",15}]}.
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
    {line,[{location,"lists.erl",15}]}.
    {call_ext,1,{extfunc,erlang,error,1}}.


{function, any, 2, 8}.
  {label,7}.
    {line,[{location,"lists.erl",19}]}.
    {func_info,{atom,lists},{atom,any},2}.
  {label,8}.
    {test,is_nonempty_list,{f,11},[{x,1}]}.
    {allocate,2,2}.
    {move,{x,0},{y,1}}.
    {get_list,{x,1},{x,0},{y,0}}.
    {move,{y,1},{x,1}}.
    {line,[{location,"lists.erl",20}]}.
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
    {line,[{location,"lists.erl",20}]}.
    {call_ext,1,{extfunc,erlang,error,1}}.


{function, append, 1, 14}.
  {label,13}.
    {line,[{location,"lists.erl",24}]}.
    {func_info,{atom,lists},{atom,append},1}.
  {label,14}.
    {test,is_nonempty_list,{f,16},[{x,0}]}.
    {get_list,{x,0},{x,1},{x,2}}.
    {test,is_nonempty_list,{f,15},[{x,1}]}.
    {allocate_heap,1,2,3}.
    {get_list,{x,1},{y,0},{x,0}}.
    {put_list,{x,0},{x,2},{x,0}}.
    {line,[{location,"lists.erl",25}]}.
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
    {line,[{location,"lists.erl",31}]}.
    {func_info,{atom,lists},{atom,append},2}.
  {label,18}.
    {test,is_nonempty_list,{f,19},[{x,0}]}.
    {allocate,1,2}.
    {get_list,{x,0},{y,0},{x,0}}.
    {line,[{location,"lists.erl",32}]}.
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
    {line,[{location,"lists.erl",36}]}.
    {func_info,{atom,lists},{atom,concat},1}.
  {label,21}.
    {test,is_nonempty_list,{f,25},[{x,0}]}.
    {get_list,{x,0},{x,1},{x,2}}.
    {test,is_atom,{f,22},[{x,1}]}.
    {allocate,1,3}.
    {move,{x,2},{y,0}}.
    {move,{x,1},{x,0}}.
    {line,[{location,"lists.erl",37}]}.
    {call_ext,1,{extfunc,erlang,atom_to_list,1}}.
    {move,{y,0},{x,1}}.
    {move,{x,0},{y,0}}.
    {move,{x,1},{x,0}}.
    {line,[{location,"lists.erl",37}]}.
    {call,1,{f,21}}.
    {test_heap,2,1}.
    {put_list,{y,0},{x,0},{x,0}}.
    {deallocate,1}.
    return.
  {label,22}.
    {test,is_integer,{f,23},[{x,1}]}.
    {allocate,1,3}.
    {move,{x,2},{y,0}}.
    {move,{x,1},{x,0}}.
    {line,[{location,"lists.erl",39}]}.
    {call_ext,1,{extfunc,erlang,integer_to_list,1}}.
    {move,{y,0},{x,1}}.
    {move,{x,0},{y,0}}.
    {move,{x,1},{x,0}}.
    {line,[{location,"lists.erl",39}]}.
    {call,1,{f,21}}.
    {test_heap,2,1}.
    {put_list,{y,0},{x,0},{x,0}}.
    {deallocate,1}.
    return.
  {label,23}.
    {test,is_float,{f,24},[{x,1}]}.
    {allocate,1,3}.
    {move,{x,2},{y,0}}.
    {move,{x,1},{x,0}}.
    {line,[{location,"lists.erl",41}]}.
    {call_ext,1,{extfunc,erlang,float_to_list,1}}.
    {move,{y,0},{x,1}}.
    {move,{x,0},{y,0}}.
    {move,{x,1},{x,0}}.
    {line,[{location,"lists.erl",41}]}.
    {call,1,{f,21}}.
    {test_heap,2,1}.
    {put_list,{y,0},{x,0},{x,0}}.
    {deallocate,1}.
    return.
  {label,24}.
    {test,is_list,{f,20},[{x,1}]}.
    {allocate,1,3}.
    {move,{x,1},{y,0}}.
    {move,{x,2},{x,0}}.
    {line,[{location,"lists.erl",43}]}.
    {call,1,{f,21}}.
    {move,{x,0},{x,1}}.
    {move,{y,0},{x,0}}.
    {call_last,2,{f,18},1}.
  {label,25}.
    {test,is_nil,{f,20},[{x,0}]}.
    return.


{function, delete, 2, 27}.
  {label,26}.
    {line,[{location,"lists.erl",47}]}.
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
    {line,[{location,"lists.erl",50}]}.
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
    {line,[{location,"lists.erl",54}]}.
    {func_info,{atom,lists},{atom,droplast},1}.
  {label,31}.
    {test,is_nonempty_list,{f,30},[{x,0}]}.
    {get_list,{x,0},{x,1},{x,0}}.
    {test,is_nil,{f,32},[{x,0}]}.
    return.
  {label,32}.
    {allocate,1,2}.
    {move,{x,1},{y,0}}.
    {line,[{location,"lists.erl",57}]}.
    {call,1,{f,31}}.
    {'%',{type_info,{x,0},list}}.
    {test_heap,2,1}.
    {put_list,{y,0},{x,0},{x,0}}.
    {deallocate,1}.
    return.


{function, dropwhile, 2, 34}.
  {label,33}.
    {line,[{location,"lists.erl",59}]}.
    {func_info,{atom,lists},{atom,dropwhile},2}.
  {label,34}.
    {test,is_nonempty_list,{f,36},[{x,1}]}.
    {allocate,3,2}.
    {move,{x,1},{y,1}}.
    {move,{x,0},{y,2}}.
    {get_list,{x,1},{x,0},{y,0}}.
    {move,{y,2},{x,1}}.
    {line,[{location,"lists.erl",60}]}.
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


{function, module_info, 0, 38}.
  {label,37}.
    {line,[]}.
    {func_info,{atom,lists},{atom,module_info},0}.
  {label,38}.
    {move,{atom,lists},{x,0}}.
    {line,[]}.
    {call_ext_only,1,{extfunc,erlang,get_module_info,1}}.


{function, module_info, 1, 40}.
  {label,39}.
    {line,[]}.
    {func_info,{atom,lists},{atom,module_info},1}.
  {label,40}.
    {move,{x,0},{x,1}}.
    {move,{atom,lists},{x,0}}.
    {line,[]}.
    {call_ext_only,2,{extfunc,erlang,get_module_info,2}}.
