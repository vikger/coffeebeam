{module, a}.  %% version = 0

{exports, [{all,1},
           {any,1},
           {bignum,0},
           {call,1},
           {funs,1},
           {list,0},
           {map,1},
           {module_info,0},
           {module_info,1},
           {newproc,1},
           {sending,0},
           {sendrecv,0},
           {test,1},
           {tuple,1}]}.

{attributes, []}.

{labels, 50}.


{function, call, 1, 2}.
  {label,1}.
    {line,[{location,"a.erl",5}]}.
    {func_info,{atom,a},{atom,call},1}.
  {label,2}.
    {allocate,0,0}.
    {line,[{location,"a.erl",6}]}.
    {call_ext,0,{extfunc,b,call,0}}.
    {call_last,1,{f,4},0}.


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
    {move,{literal,[a,1]},{x,0}}.
    return.


{function, sending, 0, 10}.
  {label,9}.
    {line,[{location,"a.erl",17}]}.
    {func_info,{atom,a},{atom,sending},0}.
  {label,10}.
    {allocate,0,0}.
    {make_fun2,{f,47},0,0,0}.
    {line,[{location,"a.erl",18}]}.
    {call_ext,1,{extfunc,erlang,spawn,1}}.
    {move,{atom,message},{x,1}}.
    {line,[{location,"a.erl",19}]}.
    send.
    {deallocate,0}.
    return.


{function, sendrecv, 0, 12}.
  {label,11}.
    {line,[{location,"a.erl",21}]}.
    {func_info,{atom,a},{atom,sendrecv},0}.
  {label,12}.
    {allocate,0,0}.
    {make_fun2,{f,42},0,0,0}.
    {line,[{location,"a.erl",22}]}.
    {call_ext,1,{extfunc,erlang,spawn,1}}.
    {test_heap,3,1}.
    {bif,self,{f,0},[],{x,1}}.
    {put_tuple2,{x,1},{list,[{x,1},{atom,message1}]}}.
    {line,[{location,"a.erl",23}]}.
    send.
  {label,13}.
    {loop_rec,{f,14},{x,0}}.
    remove_message.
    {deallocate,0}.
    return.
  {label,14}.
    {wait,{f,13}}.


{function, tuple, 1, 16}.
  {label,15}.
    {line,[{location,"a.erl",29}]}.
    {func_info,{atom,a},{atom,tuple},1}.
  {label,16}.
    {allocate_heap,3,5,1}.
    {init,{y,0}}.
    {move,{x,0},{y,2}}.
    {put_tuple2,{y,1},{list,[{atom,a},{atom,b},{atom,c},{x,0}]}}.
    {move,{y,1},{x,1}}.
    {move,{atom,x},{x,2}}.
    {move,{integer,1},{x,0}}.
    {line,[{location,"a.erl",31}]}.
    {call_ext,3,{extfunc,erlang,setelement,3}}.
    {move,{x,0},{y,0}}.
    {move,{atom,b},{x,1}}.
    {line,[{location,"a.erl",33}]}.
    {call,2,{f,18}}.
    {'%',{type_info,{x,0},
                    {tuple,4,
                           #{{integer,1} => {atom,x},
                             {integer,2} => {atom,b},
                             {integer,3} => {atom,b}}}}}.
    {test_heap,5,1}.
    {put_tuple2,{x,0},{list,[{y,2},{y,1},{y,0},{x,0}]}}.
    {deallocate,3}.
    return.


{function, tuple1, 2, 18}.
  {label,17}.
    {line,[{location,"a.erl",36}]}.
    {func_info,{atom,a},{atom,tuple1},2}.
  {label,18}.
    {'%',{type_info,{x,0},
                    {tuple,4,
                           #{{integer,1} => {atom,x},
                             {integer,2} => {atom,b},
                             {integer,3} => {atom,c}}}}}.
    {'%',{type_info,{x,1},{atom,b}}}.
    {move,{x,0},{x,1}}.
    {move,{atom,b},{x,2}}.
    {move,{integer,3},{x,0}}.
    {line,[{location,"a.erl",37}]}.
    {call_ext_only,3,{extfunc,erlang,setelement,3}}.


{function, map, 1, 20}.
  {label,19}.
    {line,[{location,"a.erl",39}]}.
    {func_info,{atom,a},{atom,map},1}.
  {label,20}.
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


{function, funs, 1, 22}.
  {label,21}.
    {line,[{location,"a.erl",42}]}.
    {func_info,{atom,a},{atom,funs},1}.
  {label,22}.
    {allocate,1,1}.
    {move,{x,0},{y,0}}.
    {make_fun2,{f,40},0,0,0}.
    {move,{y,0},{x,1}}.
    {line,[{location,"a.erl",44}]}.
    {call_ext_last,2,{extfunc,lists,map,2},1}.


{function, all, 1, 24}.
  {label,23}.
    {line,[{location,"a.erl",46}]}.
    {func_info,{atom,a},{atom,all},1}.
  {label,24}.
    {allocate,1,1}.
    {move,{x,0},{y,0}}.
    {make_fun2,{f,37},0,0,0}.
    {move,{y,0},{x,1}}.
    {line,[{location,"a.erl",47}]}.
    {call_ext_last,2,{extfunc,lists,all,2},1}.


{function, any, 1, 26}.
  {label,25}.
    {line,[{location,"a.erl",51}]}.
    {func_info,{atom,a},{atom,any},1}.
  {label,26}.
    {allocate,1,1}.
    {move,{x,0},{y,0}}.
    {make_fun2,{f,34},0,0,0}.
    {move,{y,0},{x,1}}.
    {line,[{location,"a.erl",52}]}.
    {call_ext_last,2,{extfunc,lists,any,2},1}.


{function, bignum, 0, 28}.
  {label,27}.
    {line,[{location,"a.erl",57}]}.
    {func_info,{atom,a},{atom,bignum},0}.
  {label,28}.
    {move,{integer,12345678910111213141516},{x,0}}.
    return.


{function, module_info, 0, 30}.
  {label,29}.
    {line,[]}.
    {func_info,{atom,a},{atom,module_info},0}.
  {label,30}.
    {move,{atom,a},{x,0}}.
    {line,[]}.
    {call_ext_only,1,{extfunc,erlang,get_module_info,1}}.


{function, module_info, 1, 32}.
  {label,31}.
    {line,[]}.
    {func_info,{atom,a},{atom,module_info},1}.
  {label,32}.
    {move,{x,0},{x,1}}.
    {move,{atom,a},{x,0}}.
    {line,[]}.
    {call_ext_only,2,{extfunc,erlang,get_module_info,2}}.


{function, '-any/1-fun-0-', 1, 34}.
  {label,33}.
    {line,[{location,"a.erl",52}]}.
    {func_info,{atom,a},{atom,'-any/1-fun-0-'},1}.
  {label,34}.
    {test,is_eq_exact,{f,35},[{x,0},{atom,a}]}.
    {move,{atom,true},{x,0}}.
    return.
  {label,35}.
    {move,{atom,false},{x,0}}.
    return.


{function, '-all/1-fun-0-', 1, 37}.
  {label,36}.
    {line,[{location,"a.erl",47}]}.
    {func_info,{atom,a},{atom,'-all/1-fun-0-'},1}.
  {label,37}.
    {test,is_eq_exact,{f,38},[{x,0},{atom,a}]}.
    {move,{atom,true},{x,0}}.
    return.
  {label,38}.
    {move,{atom,false},{x,0}}.
    return.


{function, '-funs/1-fun-0-', 1, 40}.
  {label,39}.
    {line,[{location,"a.erl",43}]}.
    {func_info,{atom,a},{atom,'-funs/1-fun-0-'},1}.
  {label,40}.
    {line,[{location,"a.erl",43}]}.
    {gc_bif,'+',{f,0},1,[{x,0},{integer,1}],{x,0}}.
    return.


{function, '-sendrecv/0-fun-0-', 0, 42}.
  {label,41}.
    {line,[{location,"a.erl",22}]}.
    {func_info,{atom,a},{atom,'-sendrecv/0-fun-0-'},0}.
  {label,42}.
    {allocate,0,0}.
  {label,43}.
    {loop_rec,{f,45},{x,0}}.
    {test,is_tuple,{f,44},[{x,0}]}.
    {test,test_arity,{f,44},[{x,0},2]}.
    {get_tuple_element,{x,0},1,{x,1}}.
    {test,is_eq_exact,{f,44},[{x,1},{atom,message1}]}.
    remove_message.
    {get_tuple_element,{x,0},0,{x,0}}.
    {move,{atom,message2},{x,1}}.
    {line,[{location,"a.erl",22}]}.
    send.
    {deallocate,0}.
    return.
  {label,44}.
    {loop_rec_end,{f,43}}.
  {label,45}.
    {wait,{f,43}}.


{function, '-sending/0-fun-0-', 0, 47}.
  {label,46}.
    {line,[{location,"a.erl",18}]}.
    {func_info,{atom,a},{atom,'-sending/0-fun-0-'},0}.
  {label,47}.
    {allocate,0,0}.
  {label,48}.
    {loop_rec,{f,49},{x,0}}.
    remove_message.
    {deallocate,0}.
    return.
  {label,49}.
    {wait,{f,48}}.
