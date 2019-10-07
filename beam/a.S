{module, a}.  %% version = 0

{exports, [{all,1},
           {any,1},
           {call,1},
           {funs,1},
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

{labels, 42}.


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
    {make_fun2,{f,39},0,0,0}.
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
    {allocate_heap,3,5,1}.
    {init,{y,0}}.
    {move,{x,0},{y,2}}.
    {put_tuple2,{y,1},{list,[{atom,a},{atom,b},{atom,c},{x,0}]}}.
    {move,{y,1},{x,1}}.
    {move,{atom,x},{x,2}}.
    {move,{integer,1},{x,0}}.
    {line,[{location,"a.erl",28}]}.
    {call_ext,3,{extfunc,erlang,setelement,3}}.
    {move,{x,0},{y,0}}.
    {move,{atom,b},{x,1}}.
    {line,[{location,"a.erl",30}]}.
    {call,2,{f,17}}.
    {'%',{type_info,{x,0},
                    {tuple,4,
                           #{{integer,1} => {atom,x},
                             {integer,2} => {atom,b},
                             {integer,3} => {atom,b}}}}}.
    {test_heap,5,1}.
    {put_tuple2,{x,0},{list,[{y,2},{y,1},{y,0},{x,0}]}}.
    {deallocate,3}.
    return.


{function, tuple1, 2, 17}.
  {label,16}.
    {line,[{location,"a.erl",33}]}.
    {func_info,{atom,a},{atom,tuple1},2}.
  {label,17}.
    {'%',{type_info,{x,0},
                    {tuple,4,
                           #{{integer,1} => {atom,x},
                             {integer,2} => {atom,b},
                             {integer,3} => {atom,c}}}}}.
    {'%',{type_info,{x,1},{atom,b}}}.
    {move,{x,0},{x,1}}.
    {move,{atom,b},{x,2}}.
    {move,{integer,3},{x,0}}.
    {line,[{location,"a.erl",34}]}.
    {call_ext_only,3,{extfunc,erlang,setelement,3}}.


{function, map, 1, 19}.
  {label,18}.
    {line,[{location,"a.erl",36}]}.
    {func_info,{atom,a},{atom,map},1}.
  {label,19}.
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


{function, funs, 1, 21}.
  {label,20}.
    {line,[{location,"a.erl",39}]}.
    {func_info,{atom,a},{atom,funs},1}.
  {label,21}.
    {allocate,1,1}.
    {move,{x,0},{y,0}}.
    {make_fun2,{f,37},0,0,0}.
    {move,{y,0},{x,1}}.
    {line,[{location,"a.erl",41}]}.
    {call_ext_last,2,{extfunc,lists,map,2},1}.


{function, all, 1, 23}.
  {label,22}.
    {line,[{location,"a.erl",43}]}.
    {func_info,{atom,a},{atom,all},1}.
  {label,23}.
    {allocate,1,1}.
    {move,{x,0},{y,0}}.
    {make_fun2,{f,34},0,0,0}.
    {move,{y,0},{x,1}}.
    {line,[{location,"a.erl",44}]}.
    {call_ext_last,2,{extfunc,lists,all,2},1}.


{function, any, 1, 25}.
  {label,24}.
    {line,[{location,"a.erl",48}]}.
    {func_info,{atom,a},{atom,any},1}.
  {label,25}.
    {allocate,1,1}.
    {move,{x,0},{y,0}}.
    {make_fun2,{f,31},0,0,0}.
    {move,{y,0},{x,1}}.
    {line,[{location,"a.erl",49}]}.
    {call_ext_last,2,{extfunc,lists,any,2},1}.


{function, module_info, 0, 27}.
  {label,26}.
    {line,[]}.
    {func_info,{atom,a},{atom,module_info},0}.
  {label,27}.
    {move,{atom,a},{x,0}}.
    {line,[]}.
    {call_ext_only,1,{extfunc,erlang,get_module_info,1}}.


{function, module_info, 1, 29}.
  {label,28}.
    {line,[]}.
    {func_info,{atom,a},{atom,module_info},1}.
  {label,29}.
    {move,{x,0},{x,1}}.
    {move,{atom,a},{x,0}}.
    {line,[]}.
    {call_ext_only,2,{extfunc,erlang,get_module_info,2}}.


{function, '-any/1-fun-0-', 1, 31}.
  {label,30}.
    {line,[{location,"a.erl",49}]}.
    {func_info,{atom,a},{atom,'-any/1-fun-0-'},1}.
  {label,31}.
    {test,is_eq_exact,{f,32},[{x,0},{atom,a}]}.
    {move,{atom,true},{x,0}}.
    return.
  {label,32}.
    {move,{atom,false},{x,0}}.
    return.


{function, '-all/1-fun-0-', 1, 34}.
  {label,33}.
    {line,[{location,"a.erl",44}]}.
    {func_info,{atom,a},{atom,'-all/1-fun-0-'},1}.
  {label,34}.
    {test,is_eq_exact,{f,35},[{x,0},{atom,a}]}.
    {move,{atom,true},{x,0}}.
    return.
  {label,35}.
    {move,{atom,false},{x,0}}.
    return.


{function, '-funs/1-fun-0-', 1, 37}.
  {label,36}.
    {line,[{location,"a.erl",40}]}.
    {func_info,{atom,a},{atom,'-funs/1-fun-0-'},1}.
  {label,37}.
    {line,[{location,"a.erl",40}]}.
    {gc_bif,'+',{f,0},1,[{x,0},{integer,1}],{x,0}}.
    return.


{function, '-sending/0-fun-0-', 0, 39}.
  {label,38}.
    {line,[{location,"a.erl",23}]}.
    {func_info,{atom,a},{atom,'-sending/0-fun-0-'},0}.
  {label,39}.
    {allocate,0,0}.
  {label,40}.
    {loop_rec,{f,41},{x,0}}.
    remove_message.
    {deallocate,0}.
    return.
  {label,41}.
    {wait,{f,40}}.
