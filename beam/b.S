{module, b}.  %% version = 0

{exports, [{call,0},
           {module_info,0},
           {module_info,1},
           {old_catch,1},
           {recv_catch,1}]}.

{attributes, []}.

{labels, 16}.


{function, call, 0, 2}.
  {label,1}.
    {line,[{location,"b.erl",5}]}.
    {func_info,{atom,b},{atom,call},0}.
  {label,2}.
    {move,{atom,ok},{x,0}}.
    return.


{function, recv_catch, 1, 4}.
  {label,3}.
    {line,[{location,"b.erl",8}]}.
    {func_info,{atom,b},{atom,recv_catch},1}.
  {label,4}.
    {allocate_zero,2,1}.
    {move,{x,0},{y,0}}.
  {label,5}.
    {loop_rec,{f,7},{x,0}}.
    {test,is_eq_exact,{f,6},[{x,0},{y,0}]}.
    remove_message.
    {move,{y,0},{x,0}}.
    {deallocate,2}.
    return.
  {label,6}.
    {loop_rec_end,{f,5}}.
  {label,7}.
    {wait_timeout,{f,5},{integer,1000}}.
    timeout.
    {'try',{y,1},{f,8}}.
    {move,{y,0},{x,0}}.
    {kill,{y,0}}.
    {line,[{location,"b.erl",14}]}.
    {call_ext,1,{extfunc,erlang,unknown_function,1}}.
    {try_end,{y,1}}.
    {deallocate,2}.
    return.
  {label,8}.
    {try_case,{y,1}}.
    {test_heap,3,2}.
    {put_tuple2,{x,0},{list,[{x,0},{x,1}]}}.
    {deallocate,2}.
    return.


{function, old_catch, 1, 10}.
  {label,9}.
    {line,[{location,"b.erl",21}]}.
    {func_info,{atom,b},{atom,old_catch},1}.
  {label,10}.
    {allocate,1,1}.
    {'catch',{y,0},{f,11}}.
    {line,[{location,"b.erl",22}]}.
    {gc_bif,'-',{f,0},1,[{integer,3},{x,0}],{x,0}}.
  {label,11}.
    {catch_end,{y,0}}.
    {deallocate,1}.
    return.


{function, module_info, 0, 13}.
  {label,12}.
    {line,[]}.
    {func_info,{atom,b},{atom,module_info},0}.
  {label,13}.
    {move,{atom,b},{x,0}}.
    {line,[]}.
    {call_ext_only,1,{extfunc,erlang,get_module_info,1}}.


{function, module_info, 1, 15}.
  {label,14}.
    {line,[]}.
    {func_info,{atom,b},{atom,module_info},1}.
  {label,15}.
    {move,{x,0},{x,1}}.
    {move,{atom,b},{x,0}}.
    {line,[]}.
    {call_ext_only,2,{extfunc,erlang,get_module_info,2}}.
