{module, cmod}.  %% version = 0

{exports, [{case_clause,1},
           {fadd,1},
           {fadd,2},
           {if_clause,1},
           {is_f,1},
           {is_f_helper,0},
           {module_info,0},
           {module_info,1}]}.

{attributes, []}.

{labels, 22}.


{function, case_clause, 1, 2}.
  {label,1}.
    {line,[{location,"cmod.erl",4}]}.
    {func_info,{atom,cmod},{atom,case_clause},1}.
  {label,2}.
    {test,is_eq_exact,{f,3},[{x,0},{atom,a}]}.
    {move,{atom,ok},{x,0}}.
    return.
  {label,3}.
    {line,[{location,"cmod.erl",5}]}.
    {case_end,{x,0}}.


{function, if_clause, 1, 5}.
  {label,4}.
    {line,[{location,"cmod.erl",10}]}.
    {func_info,{atom,cmod},{atom,if_clause},1}.
  {label,5}.
    {test,is_eq_exact,{f,6},[{x,0},{integer,1}]}.
    {move,{atom,ok},{x,0}}.
    return.
  {label,6}.
    {line,[{location,"cmod.erl",11}]}.
    if_end.


{function, is_f, 1, 8}.
  {label,7}.
    {line,[{location,"cmod.erl",16}]}.
    {func_info,{atom,cmod},{atom,is_f},1}.
  {label,8}.
    {test,is_function,{f,9},[{x,0}]}.
    {move,{atom,function},{x,0}}.
    return.
  {label,9}.
    {move,{atom,not_function},{x,0}}.
    return.


{function, fadd, 1, 11}.
  {label,10}.
    {line,[{location,"cmod.erl",21}]}.
    {func_info,{atom,cmod},{atom,fadd},1}.
  {label,11}.
    fclearerror.
    {fconv,{x,0},{fr,0}}.
    {fmove,{float,1.0},{fr,1}}.
    {line,[{location,"cmod.erl",22}]}.
    {bif,fadd,{f,0},[{fr,0},{fr,1}],{fr,0}}.
    {fcheckerror,{f,0}}.
    {test_heap,{alloc,[{words,0},{floats,1}]},0}.
    {fmove,{fr,0},{x,0}}.
    return.


{function, fadd, 2, 13}.
  {label,12}.
    {line,[{location,"cmod.erl",24}]}.
    {func_info,{atom,cmod},{atom,fadd},2}.
  {label,13}.
    {line,[{location,"cmod.erl",25}]}.
    {gc_bif,'+',{f,0},2,[{x,0},{x,1}],{x,0}}.
    return.


{function, is_f_helper, 0, 15}.
  {label,14}.
    {line,[{location,"cmod.erl",27}]}.
    {func_info,{atom,cmod},{atom,is_f_helper},0}.
  {label,15}.
    {make_fun2,{f,21},0,0,0}.
    {call_only,1,{f,8}}.


{function, module_info, 0, 17}.
  {label,16}.
    {line,[]}.
    {func_info,{atom,cmod},{atom,module_info},0}.
  {label,17}.
    {move,{atom,cmod},{x,0}}.
    {line,[]}.
    {call_ext_only,1,{extfunc,erlang,get_module_info,1}}.


{function, module_info, 1, 19}.
  {label,18}.
    {line,[]}.
    {func_info,{atom,cmod},{atom,module_info},1}.
  {label,19}.
    {move,{x,0},{x,1}}.
    {move,{atom,cmod},{x,0}}.
    {line,[]}.
    {call_ext_only,2,{extfunc,erlang,get_module_info,2}}.


{function, '-is_f_helper/0-fun-0-', 0, 21}.
  {label,20}.
    {line,[{location,"cmod.erl",28}]}.
    {func_info,{atom,cmod},{atom,'-is_f_helper/0-fun-0-'},0}.
  {label,21}.
    {move,{atom,ok},{x,0}}.
    return.
