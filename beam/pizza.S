{module, pizza}.  %% version = 0

{exports, [{module_info,0},{module_info,1},{order,1},{start,0}]}.

{attributes, []}.

{labels, 38}.


{function, start, 0, 2}.
  {label,1}.
    {line,[{location,"pizza.erl",4}]}.
    {func_info,{atom,pizza},{atom,start},0}.
  {label,2}.
    {allocate,0,0}.
    {make_fun2,{f,37},0,0,0}.
    {line,[{location,"pizza.erl",5}]}.
    {call_ext,1,{extfunc,erlang,spawn,1}}.
    {move,{x,0},{x,1}}.
    {move,{atom,restaurant},{x,0}}.
    {line,[{location,"pizza.erl",5}]}.
    {call_ext_last,2,{extfunc,erlang,register,2},0}.


{function, restaurant, 0, 4}.
  {label,3}.
    {line,[{location,"pizza.erl",7}]}.
    {func_info,{atom,pizza},{atom,restaurant},0}.
  {label,4}.
    {allocate,0,0}.
    {make_fun2,{f,35},0,0,0}.
    {line,[{location,"pizza.erl",8}]}.
    {call_ext,1,{extfunc,erlang,spawn,1}}.
    {call_last,1,{f,6},0}.


{function, restaurant_loop, 1, 6}.
  {label,5}.
    {line,[{location,"pizza.erl",11}]}.
    {func_info,{atom,pizza},{atom,restaurant_loop},1}.
  {label,6}.
    {allocate,1,1}.
    {move,{x,0},{y,0}}.
  {label,7}.
    {loop_rec,{f,11},{x,0}}.
    {test,is_tuple,{f,10},[{x,0}]}.
    {test,test_arity,{f,10},[{x,0},3]}.
    {get_tuple_element,{x,0},0,{x,1}}.
    {get_tuple_element,{x,0},1,{x,2}}.
    {get_tuple_element,{x,0},2,{x,3}}.
    {select_val,{x,1},{f,10},{list,[{atom,ready},{f,9},{atom,order},{f,8}]}}.
  {label,8}.
    {test_heap,4,4}.
    {move,{x,2},{x,1}}.
    {move,{x,3},{x,0}}.
    remove_message.
    {put_tuple2,{x,1},{list,[{atom,prepare},{x,1},{x,0}]}}.
    {move,{y,0},{x,0}}.
    {line,[{location,"pizza.erl",14}]}.
    send.
    {move,{y,0},{x,0}}.
    {call_last,1,{f,6},1}.
  {label,9}.
    {move,{x,2},{x,0}}.
    {move,{x,3},{x,1}}.
    remove_message.
    {line,[{location,"pizza.erl",17}]}.
    send.
    {move,{y,0},{x,0}}.
    {call_last,1,{f,6},1}.
  {label,10}.
    {test_heap,2,1}.
    remove_message.
    {put_list,{x,0},nil,{x,1}}.
    {move,{literal,"receive ~p"},{x,0}}.
    {line,[{location,"pizza.erl",20}]}.
    {call_ext,2,{extfunc,io,format,2}}.
    {move,{y,0},{x,0}}.
    {call_last,1,{f,6},1}.
  {label,11}.
    {wait,{f,7}}.


{function, preparation, 0, 13}.
  {label,12}.
    {line,[{location,"pizza.erl",24}]}.
    {func_info,{atom,pizza},{atom,preparation},0}.
  {label,13}.
    {allocate,0,0}.
    {make_fun2,{f,33},0,0,0}.
    {line,[{location,"pizza.erl",25}]}.
    {call_ext,1,{extfunc,erlang,spawn,1}}.
    {call_last,1,{f,15},0}.


{function, preparation, 1, 15}.
  {label,14}.
    {line,[{location,"pizza.erl",28}]}.
    {func_info,{atom,pizza},{atom,preparation},1}.
  {label,15}.
    {allocate,1,1}.
    {move,{x,0},{y,0}}.
  {label,16}.
    {loop_rec,{f,18},{x,0}}.
    {test,is_tagged_tuple,{f,17},[{x,0},3,{atom,prepare}]}.
    {test_heap,4,1}.
    {get_tuple_element,{x,0},1,{x,1}}.
    {get_tuple_element,{x,0},2,{x,0}}.
    remove_message.
    {put_tuple2,{x,1},{list,[{atom,cook},{x,1},{x,0}]}}.
    {move,{y,0},{x,0}}.
    {line,[{location,"pizza.erl",31}]}.
    send.
    {move,{y,0},{x,0}}.
    {call_last,1,{f,15},1}.
  {label,17}.
    {loop_rec_end,{f,16}}.
  {label,18}.
    {wait,{f,16}}.


{function, cook, 0, 20}.
  {label,19}.
    {line,[{location,"pizza.erl",35}]}.
    {func_info,{atom,pizza},{atom,cook},0}.
  {label,20}.
    {allocate,0,0}.
  {label,21}.
    {loop_rec,{f,23},{x,0}}.
    {test,is_tagged_tuple,{f,22},[{x,0},3,{atom,cook}]}.
    {test_heap,4,1}.
    {get_tuple_element,{x,0},1,{x,1}}.
    {get_tuple_element,{x,0},2,{x,0}}.
    remove_message.
    {put_tuple2,{x,1},{list,[{atom,ready},{x,1},{x,0}]}}.
    {move,{atom,restaurant},{x,0}}.
    {line,[{location,"pizza.erl",38}]}.
    send.
    {call_last,0,{f,20},0}.
  {label,22}.
    {loop_rec_end,{f,21}}.
  {label,23}.
    {wait,{f,21}}.


{function, order, 1, 25}.
  {label,24}.
    {line,[{location,"pizza.erl",42}]}.
    {func_info,{atom,pizza},{atom,order},1}.
  {label,25}.
    {allocate_heap,0,4,1}.
    {bif,self,{f,0},[],{x,1}}.
    {put_tuple2,{x,1},{list,[{atom,order},{x,1},{x,0}]}}.
    {move,{atom,restaurant},{x,0}}.
    {line,[{location,"pizza.erl",43}]}.
    send.
  {label,26}.
    {loop_rec,{f,27},{x,0}}.
    remove_message.
    {deallocate,0}.
    return.
  {label,27}.
    {wait,{f,26}}.


{function, module_info, 0, 29}.
  {label,28}.
    {line,[]}.
    {func_info,{atom,pizza},{atom,module_info},0}.
  {label,29}.
    {move,{atom,pizza},{x,0}}.
    {line,[]}.
    {call_ext_only,1,{extfunc,erlang,get_module_info,1}}.


{function, module_info, 1, 31}.
  {label,30}.
    {line,[]}.
    {func_info,{atom,pizza},{atom,module_info},1}.
  {label,31}.
    {move,{x,0},{x,1}}.
    {move,{atom,pizza},{x,0}}.
    {line,[]}.
    {call_ext_only,2,{extfunc,erlang,get_module_info,2}}.


{function, '-preparation/0-fun-0-', 0, 33}.
  {label,32}.
    {line,[{location,"pizza.erl",25}]}.
    {func_info,{atom,pizza},{atom,'-preparation/0-fun-0-'},0}.
  {label,33}.
    {call_only,0,{f,20}}.


{function, '-restaurant/0-fun-0-', 0, 35}.
  {label,34}.
    {line,[{location,"pizza.erl",8}]}.
    {func_info,{atom,pizza},{atom,'-restaurant/0-fun-0-'},0}.
  {label,35}.
    {call_only,0,{f,13}}.


{function, '-start/0-fun-0-', 0, 37}.
  {label,36}.
    {line,[{location,"pizza.erl",5}]}.
    {func_info,{atom,pizza},{atom,'-start/0-fun-0-'},0}.
  {label,37}.
    {call_only,0,{f,4}}.
