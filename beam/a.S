{module, a}.  %% version = 0

{exports, [{call,1},
           {list,0},
           {listlength,1},
           {map,1},
           {module_info,0},
           {module_info,1},
           {newproc,1},
           {sending,0},
           {test,1},
           {tuple,1}]}.

{attributes, []}.

{labels, 26}.


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


{function, listlength, 1, 10}.
  {label,9}.
    {line,[{location,"a.erl",17}]}.
    {func_info,{atom,a},{atom,listlength},1}.
  {label,10}.
    {test,is_nonempty_list,{f,11},[{x,0}]}.
    {allocate,0,1}.
    {get_tl,{x,0},{x,0}}.
    {line,[{location,"a.erl",18}]}.
    {call,1,{f,10}}.
    {'%',{type_info,{x,0},number}}.
    {line,[{location,"a.erl",18}]}.
    {gc_bif,'+',{f,0},1,[{x,0},{integer,1}],{x,0}}.
    {deallocate,0}.
    return.
  {label,11}.
    {test,is_nil,{f,9},[{x,0}]}.
    {move,{integer,0},{x,0}}.
    return.


{function, sending, 0, 13}.
  {label,12}.
    {line,[{location,"a.erl",22}]}.
    {func_info,{atom,a},{atom,sending},0}.
  {label,13}.
    {allocate,0,0}.
    {make_fun2,{f,23},0,0,0}.
    {line,[{location,"a.erl",23}]}.
    {call_ext,1,{extfunc,erlang,spawn,1}}.
    {move,{atom,message},{x,1}}.
    {line,[{location,"a.erl",24}]}.
    send.
    {deallocate,0}.
    return.


{function, tuple, 1, 15}.
  {label,14}.
    {line,[{location,"a.erl",26}]}.
    {func_info,{atom,a},{atom,tuple},1}.
  {label,15}.
    {allocate_heap,0,5,1}.
    {put_tuple2,{x,1},{list,[{atom,a},{atom,b},{atom,c},{x,0}]}}.
    {move,{atom,x},{x,2}}.
    {move,{integer,1},{x,0}}.
    {line,[{location,"a.erl",28}]}.
    {call_ext,3,{extfunc,erlang,setelement,3}}.
    {move,{atom,x},{x,0}}.
    {deallocate,0}.
    return.


{function, map, 1, 17}.
  {label,16}.
    {line,[{location,"a.erl",31}]}.
    {func_info,{atom,a},{atom,map},1}.
  {label,17}.
    {put_map_assoc,{f,0},{literal,#{}},{x,0},1,{list,[{x,0},{x,0}]}}.
    {put_map_assoc,{f,0},
                   {x,0},
                   {x,0},
                   1,
                   {list,[{atom,a},
                          {integer,1},
                          {atom,c},
                          {integer,3},
                          {atom,b},
                          {integer,2}]}}.
    return.


{function, module_info, 0, 19}.
  {label,18}.
    {line,[]}.
    {func_info,{atom,a},{atom,module_info},0}.
  {label,19}.
    {move,{atom,a},{x,0}}.
    {line,[]}.
    {call_ext_only,1,{extfunc,erlang,get_module_info,1}}.


{function, module_info, 1, 21}.
  {label,20}.
    {line,[]}.
    {func_info,{atom,a},{atom,module_info},1}.
  {label,21}.
    {move,{x,0},{x,1}}.
    {move,{atom,a},{x,0}}.
    {line,[]}.
    {call_ext_only,2,{extfunc,erlang,get_module_info,2}}.


{function, '-sending/0-fun-0-', 0, 23}.
  {label,22}.
    {line,[{location,"a.erl",23}]}.
    {func_info,{atom,a},{atom,'-sending/0-fun-0-'},0}.
  {label,23}.
    {allocate,0,0}.
  {label,24}.
    {loop_rec,{f,25},{x,0}}.
    remove_message.
    {deallocate,0}.
    return.
  {label,25}.
    {wait,{f,24}}.
