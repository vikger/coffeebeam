{module, a}.  %% version = 0

{exports, [{call,1},
           {list,0},
           {module_info,0},
           {module_info,1},
           {newproc,1},
           {test,1}]}.

{attributes, []}.

{labels, 13}.


{function, call, 1, 2}.
  {label,1}.
    {line,[{location,"a.erl",5}]}.
    {func_info,{atom,a},{atom,call},1}.
  {label,2}.
    {line,[{location,"a.erl",6}]}.
    {call_ext_only,0,{extfunc,b,call,0}}.


{function, test, 1, 4}.
  {label,3}.
    {line,[{location,"a.erl",8}]}.
    {func_info,{atom,a},{atom,test},1}.
  {label,4}.
    {test,is_eq_exact,{f,3},[{x,0},{atom,a}]}.
    {move,{atom,ok},{x,0}}.
    return.


{function, newproc, 1, 6}.
  {label,5}.
    {line,[{location,"a.erl",11}]}.
    {func_info,{atom,a},{atom,newproc},1}.
  {label,6}.
    {test_heap,6,1}.
    {put_list,{x,0},nil,{x,0}}.
    {put_list,{x,0},nil,{x,0}}.
    {put_list,{literal,"~p"},{x,0},{x,2}}.
    {move,{atom,format},{x,1}}.
    {move,{atom,io},{x,0}}.
    {line,[{location,"a.erl",12}]}.
    {call_ext_only,3,{extfunc,erlang,spawn,3}}.


{function, list, 0, 8}.
  {label,7}.
    {line,[{location,"a.erl",14}]}.
    {func_info,{atom,a},{atom,list},0}.
  {label,8}.
    {move,{literal,[a,1,"s"]},{x,0}}.
    return.


{function, module_info, 0, 10}.
  {label,9}.
    {line,[]}.
    {func_info,{atom,a},{atom,module_info},0}.
  {label,10}.
    {move,{atom,a},{x,0}}.
    {line,[]}.
    {call_ext_only,1,{extfunc,erlang,get_module_info,1}}.


{function, module_info, 1, 12}.
  {label,11}.
    {line,[]}.
    {func_info,{atom,a},{atom,module_info},1}.
  {label,12}.
    {move,{x,0},{x,1}}.
    {move,{atom,a},{x,0}}.
    {line,[]}.
    {call_ext_only,2,{extfunc,erlang,get_module_info,2}}.
