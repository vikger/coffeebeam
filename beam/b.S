{module, b}.  %% version = 0

{exports, [{applies,4},
           {atomnames,3},
           {bin,1},
           {bin1,1},
           {bin2,1},
           {bin3,2},
           {bin4,3},
           {call,0},
           {client_call,1},
           {errors,0},
           {module_info,0},
           {module_info,1},
           {no_bif,0},
           {old_catch,1},
           {recv_catch,1},
           {ref,0},
           {throw,0},
           {try_catch,0}]}.

{attributes, []}.

{labels, 47}.


{function, call, 0, 2}.
  {label,1}.
    {line,[{location,"b.erl",6}]}.
    {func_info,{atom,b},{atom,call},0}.
  {label,2}.
    {move,{atom,ok},{x,0}}.
    return.


{function, recv_catch, 1, 4}.
  {label,3}.
    {line,[{location,"b.erl",9}]}.
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
    {line,[{location,"b.erl",15}]}.
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
    {line,[{location,"b.erl",22}]}.
    {func_info,{atom,b},{atom,old_catch},1}.
  {label,10}.
    {allocate,1,1}.
    {'catch',{y,0},{f,11}}.
    {line,[{location,"b.erl",23}]}.
    {gc_bif,'-',{f,0},1,[{integer,3},{x,0}],{x,0}}.
  {label,11}.
    {catch_end,{y,0}}.
    {deallocate,1}.
    return.


{function, try_catch, 0, 13}.
  {label,12}.
    {line,[{location,"b.erl",25}]}.
    {func_info,{atom,b},{atom,try_catch},0}.
  {label,13}.
    {allocate,1,0}.
    {'try',{y,0},{f,14}}.
    {line,[{location,"b.erl",27}]}.
    {call_ext,0,{extfunc,erlang,unknown_function,0}}.
    {try_end,{y,0}}.
    {deallocate,1}.
    return.
  {label,14}.
    {try_case,{y,0}}.
    {test_heap,3,2}.
    {put_tuple2,{x,0},{list,[{x,0},{x,1}]}}.
    {deallocate,1}.
    return.


{function, throw, 0, 16}.
  {label,15}.
    {line,[{location,"b.erl",33}]}.
    {func_info,{atom,b},{atom,throw},0}.
  {label,16}.
    {move,{atom,strange},{x,0}}.
    {line,[{location,"b.erl",34}]}.
    {call_ext,1,{extfunc,erlang,throw,1}}.


{function, bin, 1, 18}.
  {label,17}.
    {line,[{location,"b.erl",36}]}.
    {func_info,{atom,b},{atom,bin},1}.
  {label,18}.
    {line,[{location,"b.erl",37}]}.
    {bs_init2,{f,0},4,0,1,{field_flags,[]},{x,1}}.
    {bs_put_integer,{f,0},{integer,8},1,{field_flags,[unsigned,big]},{x,0}}.
    {bs_put_string,3,{string,<<"def">>}}.
    {move,{x,1},{x,0}}.
    return.


{function, bin1, 1, 20}.
  {label,19}.
    {line,[{location,"b.erl",39}]}.
    {func_info,{atom,b},{atom,bin1},1}.
  {label,20}.
    {line,[{location,"b.erl",40}]}.
    {bs_init2,{f,0},5,0,1,{field_flags,[]},{x,1}}.
    {bs_put_string,4,{string,<<"0123">>}}.
    {bs_put_integer,{f,0},{integer,8},1,{field_flags,[unsigned,big]},{x,0}}.
    {move,{x,1},{x,0}}.
    return.


{function, bin2, 1, 22}.
  {label,21}.
    {line,[{location,"b.erl",42}]}.
    {func_info,{atom,b},{atom,bin2},1}.
  {label,22}.
    {'%',{type_info,{x,0},match_context}}.
    {test,bs_start_match3,{f,21},1,[{x,0}],{x,1}}.
    {bs_get_position,{x,1},{x,0},2}.
    {test,bs_get_integer2,
          {f,23},
          2,
          [{x,1},
           {integer,1},
           1,
           {field_flags,[{anno,[42,{file,"b.erl"}]},unsigned,big]}],
          {x,2}}.
    {test,bs_get_integer2,
          {f,23},
          3,
          [{x,1},
           {integer,2},
           1,
           {field_flags,[{anno,[42,{file,"b.erl"}]},unsigned,big]}],
          {x,3}}.
    {test,bs_get_integer2,
          {f,23},
          4,
          [{x,1},
           {integer,5},
           1,
           {field_flags,[{anno,[42,{file,"b.erl"}]},unsigned,big]}],
          {x,4}}.
    {test,bs_test_unit,{f,23},[{x,1},8]}.
    {allocate,3,5}.
    {move,{x,4},{y,0}}.
    {move,{x,3},{y,1}}.
    {move,{x,2},{y,2}}.
    {move,{x,1},{x,0}}.
    {line,[{location,"b.erl",43}]}.
    {call,1,{f,22}}.
    {'%',{type_info,{x,0},list}}.
    {test_heap,6,1}.
    {put_tuple2,{x,1},{list,[{y,2},{y,1},{y,0}]}}.
    {put_list,{x,1},{x,0},{x,0}}.
    {deallocate,3}.
    return.
  {label,23}.
    {bs_set_position,{x,1},{x,0}}.
    {test,bs_test_tail2,{f,24},[{x,1},0]}.
    {move,nil,{x,0}}.
    return.
  {label,24}.
    {bs_get_tail,{x,1},{x,0},2}.
    {jump,{f,21}}.


{function, bin3, 2, 26}.
  {label,25}.
    {line,[{location,"b.erl",47}]}.
    {func_info,{atom,b},{atom,bin3},2}.
  {label,26}.
    {line,[{location,"b.erl",48}]}.
    {gc_bif,bit_size,{f,0},2,[{x,1}],{x,2}}.
    {line,[{location,"b.erl",48}]}.
    {bs_append,{f,0},{x,2},0,3,8,{x,0},{field_flags,[]},{x,0}}.
    {bs_put_binary,{f,0},{atom,all},8,{field_flags,[unsigned,big]},{x,1}}.
    return.


{function, bin4, 3, 28}.
  {label,27}.
    {line,[{location,"b.erl",50}]}.
    {func_info,{atom,b},{atom,bin4},3}.
  {label,28}.
    {line,[{location,"b.erl",51}]}.
    {gc_bif,byte_size,{f,0},3,[{x,2}],{x,3}}.
    {bs_add,{f,0},[{x,3},{integer,2},1],{x,3}}.
    {line,[{location,"b.erl",51}]}.
    {bs_init2,{f,0},{x,3},0,4,{field_flags,[]},{x,3}}.
    {bs_put_integer,{f,0},{integer,2},1,{field_flags,[unsigned,big]},{x,0}}.
    {bs_put_integer,{f,0},{integer,14},1,{field_flags,[unsigned,big]},{x,1}}.
    {bs_put_binary,{f,0},{atom,all},8,{field_flags,[unsigned,big]},{x,2}}.
    {move,{x,3},{x,0}}.
    return.


{function, applies, 4, 30}.
  {label,29}.
    {line,[{location,"b.erl",53}]}.
    {func_info,{atom,b},{atom,applies},4}.
  {label,30}.
    {allocate,3,4}.
    {move,{x,3},{y,0}}.
    {move,{x,1},{y,1}}.
    {move,{x,0},{y,2}}.
    {move,{y,2},{x,1}}.
    {move,{x,2},{x,0}}.
    {move,{y,1},{x,2}}.
    {line,[{location,"b.erl",54}]}.
    {apply,1}.
    {move,{y,1},{x,2}}.
    {move,{y,2},{x,1}}.
    {move,{y,0},{x,0}}.
    {line,[{location,"b.erl",55}]}.
    {apply_last,1,3}.


{function, atomnames, 3, 32}.
  {label,31}.
    {line,[{location,"b.erl",57}]}.
    {func_info,{atom,b},{atom,atomnames},3}.
  {label,32}.
    {test_heap,4,3}.
    {put_tuple2,{x,0},{list,[{x,0},{x,1},{x,2}]}}.
    return.


{function, client_call, 1, 34}.
  {label,33}.
    {line,[{location,"b.erl",60}]}.
    {func_info,{atom,b},{atom,client_call},1}.
  {label,34}.
    {line,[{location,"b.erl",61}]}.
    {call_ext_only,1,{extfunc,beamclient,call,1}}.


{function, no_bif, 0, 36}.
  {label,35}.
    {line,[{location,"b.erl",63}]}.
    {func_info,{atom,b},{atom,no_bif},0}.
  {label,36}.
    {line,[{location,"b.erl",64}]}.
    {call_ext_only,0,{extfunc,erlang,invalidbif,0}}.


{function, ref, 0, 38}.
  {label,37}.
    {line,[{location,"b.erl",66}]}.
    {func_info,{atom,b},{atom,ref},0}.
  {label,38}.
    {call_ext_only,0,{extfunc,erlang,make_ref,0}}.


{function, errors, 0, 40}.
  {label,39}.
    {line,[{location,"b.erl",69}]}.
    {func_info,{atom,b},{atom,errors},0}.
  {label,40}.
    {allocate_zero,2,0}.
    {'try',{y,1},{f,41}}.
    {move,{atom,exitreason},{x,0}}.
    {line,[{location,"b.erl",71}]}.
    {call_ext,1,{extfunc,erlang,exit,1}}.
  {label,41}.
    {try_case,{y,1}}.
    {test_heap,3,2}.
    {put_tuple2,{x,0},{list,[{x,0},{x,1}]}}.
    {move,{x,0},{y,0}}.
    {'try',{y,1},{f,42}}.
    {move,{atom,throwreason},{x,0}}.
    {line,[{location,"b.erl",77}]}.
    {call_ext,1,{extfunc,erlang,throw,1}}.
  {label,42}.
    {try_case,{y,1}}.
    {test_heap,6,2}.
    {put_tuple2,{x,0},{list,[{x,0},{x,1}]}}.
    {put_tuple2,{x,0},{list,[{y,0},{x,0}]}}.
    {deallocate,2}.
    return.


{function, module_info, 0, 44}.
  {label,43}.
    {line,[]}.
    {func_info,{atom,b},{atom,module_info},0}.
  {label,44}.
    {move,{atom,b},{x,0}}.
    {line,[]}.
    {call_ext_only,1,{extfunc,erlang,get_module_info,1}}.


{function, module_info, 1, 46}.
  {label,45}.
    {line,[]}.
    {func_info,{atom,b},{atom,module_info},1}.
  {label,46}.
    {move,{x,0},{x,1}}.
    {move,{atom,b},{x,0}}.
    {line,[]}.
    {call_ext_only,2,{extfunc,erlang,get_module_info,2}}.
