{module, b}.  %% version = 0

{exports, [{call,0},{module_info,0},{module_info,1}]}.

{attributes, []}.

{labels, 7}.


{function, call, 0, 2}.
  {label,1}.
    {line,[{location,"b.erl",5}]}.
    {func_info,{atom,b},{atom,call},0}.
  {label,2}.
    {move,{atom,ok},{x,0}}.
    return.


{function, module_info, 0, 4}.
  {label,3}.
    {line,[]}.
    {func_info,{atom,b},{atom,module_info},0}.
  {label,4}.
    {move,{atom,b},{x,0}}.
    {line,[]}.
    {call_ext_only,1,{extfunc,erlang,get_module_info,1}}.


{function, module_info, 1, 6}.
  {label,5}.
    {line,[]}.
    {func_info,{atom,b},{atom,module_info},1}.
  {label,6}.
    {move,{x,0},{x,1}}.
    {move,{atom,b},{x,0}}.
    {line,[]}.
    {call_ext_only,2,{extfunc,erlang,get_module_info,2}}.
