{module, pizza}.  %% version = 0

{exports, [{module_info,0},{module_info,1},{order,1},{start,0},{stop,0}]}.

{attributes, []}.

{labels, 45}.


{function, start, 0, 2}.
  {label,1}.
    {line,[{location,"pizza.erl",4}]}.
    {func_info,{atom,pizza},{atom,start},0}.
  {label,2}.
    {allocate,0,0}.
    {make_fun2,{f,44},0,0,0}.
    {line,[{location,"pizza.erl",5}]}.
    {call_ext,1,{extfunc,erlang,spawn,1}}.
    {move,{x,0},{x,1}}.
    {move,{atom,restaurant},{x,0}}.
    {line,[{location,"pizza.erl",5}]}.
    {call_ext_last,2,{extfunc,erlang,register,2},0}.


{function, stop, 0, 4}.
  {label,3}.
    {line,[{location,"pizza.erl",7}]}.
    {func_info,{atom,pizza},{atom,stop},0}.
  {label,4}.
    {allocate,0,0}.
    {move,{atom,stop},{x,1}}.
    {move,{atom,restaurant},{x,0}}.
    {line,[{location,"pizza.erl",8}]}.
    send.
    {move,{atom,restaurant},{x,0}}.
    {line,[{location,"pizza.erl",9}]}.
    {call_ext,1,{extfunc,erlang,unregister,1}}.
    {move,{atom,ok},{x,0}}.
    {deallocate,0}.
    return.


{function, restaurant, 0, 6}.
  {label,5}.
    {line,[{location,"pizza.erl",12}]}.
    {func_info,{atom,pizza},{atom,restaurant},0}.
  {label,6}.
    {allocate,0,0}.
    {make_fun2,{f,42},0,0,0}.
    {line,[{location,"pizza.erl",13}]}.
    {call_ext,1,{extfunc,erlang,spawn,1}}.
    {call_last,1,{f,8},0}.


{function, restaurant_loop, 1, 8}.
  {label,7}.
    {line,[{location,"pizza.erl",16}]}.
    {func_info,{atom,pizza},{atom,restaurant_loop},1}.
  {label,8}.
    {allocate,1,1}.
    {move,{x,0},{y,0}}.
  {label,9}.
    {loop_rec,{f,14},{x,0}}.
    {test,is_tuple,{f,12},[{x,0}]}.
    {test,test_arity,{f,13},[{x,0},3]}.
    {get_tuple_element,{x,0},0,{x,1}}.
    {get_tuple_element,{x,0},1,{x,2}}.
    {get_tuple_element,{x,0},2,{x,3}}.
    {select_val,{x,1},{f,13},{list,[{atom,ready},{f,11},{atom,order},{f,10}]}}.
  {label,10}.
    {test_heap,4,4}.
    {move,{x,2},{x,1}}.
    {move,{x,3},{x,0}}.
    remove_message.
    {put_tuple2,{x,1},{list,[{atom,prepare},{x,1},{x,0}]}}.
    {move,{y,0},{x,0}}.
    {line,[{location,"pizza.erl",19}]}.
    send.
    {move,{y,0},{x,0}}.
    {call_last,1,{f,8},1}.
  {label,11}.
    {test_heap,3,4}.
    {move,{x,2},{x,1}}.
    {move,{x,3},{x,0}}.
    remove_message.
    {put_tuple2,{x,0},{list,[{atom,pizza},{x,0}]}}.
    {move,{x,1},{x,2}}.
    {move,{x,0},{x,1}}.
    {move,{x,2},{x,0}}.
    {line,[{location,"pizza.erl",22}]}.
    send.
    {move,{y,0},{x,0}}.
    {call_last,1,{f,8},1}.
  {label,12}.
    {test,is_eq_exact,{f,13},[{x,0},{atom,stop}]}.
    remove_message.
    {move,{atom,stop},{x,1}}.
    {move,{y,0},{x,0}}.
    {line,[{location,"pizza.erl",25}]}.
    send.
    {deallocate,1}.
    return.
  {label,13}.
    {test_heap,2,1}.
    remove_message.
    {put_list,{x,0},nil,{x,1}}.
    {move,{literal,"receive ~p"},{x,0}}.
    {line,[{location,"pizza.erl",27}]}.
    {call_ext,2,{extfunc,io,format,2}}.
    {move,{y,0},{x,0}}.
    {call_last,1,{f,8},1}.
  {label,14}.
    {wait,{f,9}}.


{function, preparation, 0, 16}.
  {label,15}.
    {line,[{location,"pizza.erl",31}]}.
    {func_info,{atom,pizza},{atom,preparation},0}.
  {label,16}.
    {allocate,0,0}.
    {make_fun2,{f,40},0,0,0}.
    {line,[{location,"pizza.erl",32}]}.
    {call_ext,1,{extfunc,erlang,spawn,1}}.
    {call_last,1,{f,18},0}.


{function, preparation, 1, 18}.
  {label,17}.
    {line,[{location,"pizza.erl",35}]}.
    {func_info,{atom,pizza},{atom,preparation},1}.
  {label,18}.
    {allocate,1,1}.
    {move,{x,0},{y,0}}.
  {label,19}.
    {loop_rec,{f,22},{x,0}}.
    {test,is_tuple,{f,20},[{x,0}]}.
    {test,is_tagged_tuple,{f,21},[{x,0},3,{atom,prepare}]}.
    {test_heap,4,1}.
    {get_tuple_element,{x,0},1,{x,1}}.
    {get_tuple_element,{x,0},2,{x,0}}.
    remove_message.
    {put_tuple2,{x,1},{list,[{atom,cook},{x,1},{x,0}]}}.
    {move,{y,0},{x,0}}.
    {line,[{location,"pizza.erl",38}]}.
    send.
    {move,{y,0},{x,0}}.
    {call_last,1,{f,18},1}.
  {label,20}.
    {test,is_eq_exact,{f,21},[{x,0},{atom,stop}]}.
    remove_message.
    {move,{atom,stop},{x,1}}.
    {move,{y,0},{x,0}}.
    {line,[{location,"pizza.erl",41}]}.
    send.
    {deallocate,1}.
    return.
  {label,21}.
    {loop_rec_end,{f,19}}.
  {label,22}.
    {wait,{f,19}}.


{function, cook, 0, 24}.
  {label,23}.
    {line,[{location,"pizza.erl",44}]}.
    {func_info,{atom,pizza},{atom,cook},0}.
  {label,24}.
    {allocate,0,0}.
  {label,25}.
    {loop_rec,{f,28},{x,0}}.
    {test,is_tuple,{f,26},[{x,0}]}.
    {test,is_tagged_tuple,{f,27},[{x,0},3,{atom,cook}]}.
    {test_heap,4,1}.
    {get_tuple_element,{x,0},1,{x,1}}.
    {get_tuple_element,{x,0},2,{x,0}}.
    remove_message.
    {put_tuple2,{x,1},{list,[{atom,ready},{x,1},{x,0}]}}.
    {move,{atom,restaurant},{x,0}}.
    {line,[{location,"pizza.erl",47}]}.
    send.
    {call_last,0,{f,24},0}.
  {label,26}.
    {test,is_eq_exact,{f,27},[{x,0},{atom,stop}]}.
    remove_message.
    {move,{atom,ok},{x,0}}.
    {deallocate,0}.
    return.
  {label,27}.
    {loop_rec_end,{f,25}}.
  {label,28}.
    {wait,{f,25}}.


{function, order, 1, 30}.
  {label,29}.
    {line,[{location,"pizza.erl",53}]}.
    {func_info,{atom,pizza},{atom,order},1}.
  {label,30}.
    {allocate,1,1}.
    {'try',{y,0},{f,34}}.
    {test_heap,4,1}.
    {bif,self,{f,0},[],{x,1}}.
    {put_tuple2,{x,1},{list,[{atom,order},{x,1},{x,0}]}}.
    {move,{atom,restaurant},{x,0}}.
    {line,[{location,"pizza.erl",55}]}.
    send.
  {label,31}.
    {loop_rec,{f,33},{x,0}}.
    {test,is_tagged_tuple,{f,32},[{x,0},2,{atom,pizza}]}.
    {test_heap,3,1}.
    {get_tuple_element,{x,0},1,{x,0}}.
    remove_message.
    {put_tuple2,{x,0},{list,[{atom,here_you_are},{x,0}]}}.
    {try_end,{y,0}}.
    {deallocate,1}.
    return.
  {label,32}.
    {loop_rec_end,{f,31}}.
  {label,33}.
    {wait,{f,31}}.
  {label,34}.
    {try_case,{y,0}}.
    {move,{atom,sorry_closed},{x,0}}.
    {deallocate,1}.
    return.


{function, module_info, 0, 36}.
  {label,35}.
    {line,[]}.
    {func_info,{atom,pizza},{atom,module_info},0}.
  {label,36}.
    {move,{atom,pizza},{x,0}}.
    {line,[]}.
    {call_ext_only,1,{extfunc,erlang,get_module_info,1}}.


{function, module_info, 1, 38}.
  {label,37}.
    {line,[]}.
    {func_info,{atom,pizza},{atom,module_info},1}.
  {label,38}.
    {move,{x,0},{x,1}}.
    {move,{atom,pizza},{x,0}}.
    {line,[]}.
    {call_ext_only,2,{extfunc,erlang,get_module_info,2}}.


{function, '-preparation/0-fun-0-', 0, 40}.
  {label,39}.
    {line,[{location,"pizza.erl",32}]}.
    {func_info,{atom,pizza},{atom,'-preparation/0-fun-0-'},0}.
  {label,40}.
    {call_only,0,{f,24}}.


{function, '-restaurant/0-fun-0-', 0, 42}.
  {label,41}.
    {line,[{location,"pizza.erl",13}]}.
    {func_info,{atom,pizza},{atom,'-restaurant/0-fun-0-'},0}.
  {label,42}.
    {call_only,0,{f,16}}.


{function, '-start/0-fun-0-', 0, 44}.
  {label,43}.
    {line,[{location,"pizza.erl",5}]}.
    {func_info,{atom,pizza},{atom,'-start/0-fun-0-'},0}.
  {label,44}.
    {call_only,0,{f,6}}.
