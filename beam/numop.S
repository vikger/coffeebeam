{module, numop}.  %% version = 0

{exports, [{int,2},{int2,2},{module_info,0},{module_info,1}]}.

{attributes, []}.

{labels, 9}.


{function, int, 2, 2}.
  {label,1}.
    {line,[{location,"numop.erl",5}]}.
    {func_info,{atom,numop},{atom,int},2}.
  {label,2}.
    {line,[{location,"numop.erl",6}]}.
    {gc_bif,'+',{f,0},2,[{x,0},{x,1}],{x,2}}.
    {line,[{location,"numop.erl",6}]}.
    {gc_bif,'-',{f,0},3,[{x,0},{x,1}],{x,3}}.
    {line,[{location,"numop.erl",6}]}.
    {gc_bif,'*',{f,0},4,[{x,0},{x,1}],{x,4}}.
    fclearerror.
    {fconv,{x,0},{fr,0}}.
    {fconv,{x,1},{fr,1}}.
    {line,[{location,"numop.erl",6}]}.
    {bif,fdiv,{f,0},[{fr,0},{fr,1}],{fr,0}}.
    {fcheckerror,{f,0}}.
    {test_heap,{alloc,[{words,0},{floats,1}]},5}.
    {fmove,{fr,0},{x,5}}.
    {line,[{location,"numop.erl",6}]}.
    {gc_bif,'div',{f,0},6,[{x,0},{x,1}],{x,6}}.
    {line,[{location,"numop.erl",6}]}.
    {gc_bif,'rem',{f,0},7,[{x,0},{x,1}],{x,0}}.
    {test_heap,7,7}.
    {put_tuple2,{x,0},{list,[{x,2},{x,3},{x,4},{x,5},{x,6},{x,0}]}}.
    return.


{function, int2, 2, 4}.
  {label,3}.
    {line,[{location,"numop.erl",8}]}.
    {func_info,{atom,numop},{atom,int2},2}.
  {label,4}.
    {line,[{location,"numop.erl",9}]}.
    {gc_bif,'bsl',{f,0},2,[{x,0},{x,1}],{x,2}}.
    {line,[{location,"numop.erl",9}]}.
    {gc_bif,'bsr',{f,0},3,[{x,0},{x,1}],{x,3}}.
    {line,[{location,"numop.erl",9}]}.
    {gc_bif,'band',{f,0},4,[{x,0},{x,1}],{x,4}}.
    {line,[{location,"numop.erl",9}]}.
    {gc_bif,'bor',{f,0},5,[{x,0},{x,1}],{x,5}}.
    {line,[{location,"numop.erl",9}]}.
    {gc_bif,'bxor',{f,0},6,[{x,0},{x,1}],{x,1}}.
    {line,[{location,"numop.erl",9}]}.
    {gc_bif,'bnot',{f,0},6,[{x,0}],{x,0}}.
    {test_heap,7,6}.
    {put_tuple2,{x,0},{list,[{x,2},{x,3},{x,4},{x,5},{x,1},{x,0}]}}.
    return.


{function, module_info, 0, 6}.
  {label,5}.
    {line,[]}.
    {func_info,{atom,numop},{atom,module_info},0}.
  {label,6}.
    {move,{atom,numop},{x,0}}.
    {line,[]}.
    {call_ext_only,1,{extfunc,erlang,get_module_info,1}}.


{function, module_info, 1, 8}.
  {label,7}.
    {line,[]}.
    {func_info,{atom,numop},{atom,module_info},1}.
  {label,8}.
    {move,{x,0},{x,1}}.
    {move,{atom,numop},{x,0}}.
    {line,[]}.
    {call_ext_only,2,{extfunc,erlang,get_module_info,2}}.