{module, lists}.  %% version = 0

{exports, [{all,2},{append,1},{append,2},{module_info,0},{module_info,1}]}.

{attributes, []}.

{labels, 18}.


{function, all, 2, 2}.
  {label,1}.
    {line,[{location,"lists.erl",9}]}.
    {func_info,{atom,lists},{atom,all},2}.
  {label,2}.
    {test,is_nonempty_list,{f,5},[{x,1}]}.
    {allocate,2,2}.
    {move,{x,0},{y,1}}.
    {get_list,{x,1},{x,0},{y,0}}.
    {move,{y,1},{x,1}}.
    {line,[{location,"lists.erl",12}]}.
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
    {line,[{location,"lists.erl",12}]}.
    {case_end,{x,0}}.


{function, append, 1, 8}.
  {label,7}.
    {line,[{location,"lists.erl",19}]}.
    {func_info,{atom,lists},{atom,append},1}.
  {label,8}.
    {test,is_nonempty_list,{f,10},[{x,0}]}.
    {get_list,{x,0},{x,1},{x,2}}.
    {test,is_nonempty_list,{f,9},[{x,1}]}.
    {allocate_heap,1,2,3}.
    {get_list,{x,1},{y,0},{x,0}}.
    {put_list,{x,0},{x,2},{x,0}}.
    {line,[{location,"lists.erl",20}]}.
    {call,1,{f,8}}.
    {'%',{type_info,{x,0},list}}.
    {test_heap,2,1}.
    {put_list,{y,0},{x,0},{x,0}}.
    {deallocate,1}.
    return.
  {label,9}.
    {test,is_nil,{f,7},[{x,1}]}.
    {move,{x,2},{x,0}}.
    {call_only,1,{f,8}}.
  {label,10}.
    {test,is_nil,{f,7},[{x,0}]}.
    return.


{function, append, 2, 12}.
  {label,11}.
    {line,[{location,"lists.erl",26}]}.
    {func_info,{atom,lists},{atom,append},2}.
  {label,12}.
    {test,is_nonempty_list,{f,13},[{x,0}]}.
    {allocate,1,2}.
    {get_list,{x,0},{y,0},{x,0}}.
    {line,[{location,"lists.erl",27}]}.
    {call,2,{f,12}}.
    {test_heap,2,1}.
    {put_list,{y,0},{x,0},{x,0}}.
    {deallocate,1}.
    return.
  {label,13}.
    {test,is_nil,{f,11},[{x,0}]}.
    {move,{x,1},{x,0}}.
    return.


{function, module_info, 0, 15}.
  {label,14}.
    {line,[]}.
    {func_info,{atom,lists},{atom,module_info},0}.
  {label,15}.
    {move,{atom,lists},{x,0}}.
    {line,[]}.
    {call_ext_only,1,{extfunc,erlang,get_module_info,1}}.


{function, module_info, 1, 17}.
  {label,16}.
    {line,[]}.
    {func_info,{atom,lists},{atom,module_info},1}.
  {label,17}.
    {move,{x,0},{x,1}}.
    {move,{atom,lists},{x,0}}.
    {line,[]}.
    {call_ext_only,2,{extfunc,erlang,get_module_info,2}}.
