{module, lists}.  %% version = 0

{exports, [{all,2},{module_info,0},{module_info,1}]}.

{attributes, []}.

{labels, 11}.


{function, all, 2, 2}.
  {label,1}.
    {line,[{location,"lists.erl",7}]}.
    {func_info,{atom,lists},{atom,all},2}.
  {label,2}.
    {test,is_nonempty_list,{f,5},[{x,1}]}.
    {allocate,2,2}.
    {move,{x,0},{y,1}}.
    {get_list,{x,1},{x,0},{y,0}}.
    {move,{y,1},{x,1}}.
    {line,[{location,"lists.erl",10}]}.
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
    {line,[{location,"lists.erl",10}]}.
    {case_end,{x,0}}.


{function, module_info, 0, 8}.
  {label,7}.
    {line,[]}.
    {func_info,{atom,lists},{atom,module_info},0}.
  {label,8}.
    {move,{atom,lists},{x,0}}.
    {line,[]}.
    {call_ext_only,1,{extfunc,erlang,get_module_info,1}}.


{function, module_info, 1, 10}.
  {label,9}.
    {line,[]}.
    {func_info,{atom,lists},{atom,module_info},1}.
  {label,10}.
    {move,{x,0},{x,1}}.
    {move,{atom,lists},{x,0}}.
    {line,[]}.
    {call_ext_only,2,{extfunc,erlang,get_module_info,2}}.
