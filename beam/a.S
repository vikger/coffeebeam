{module, a}.  %% version = 0

{exports, [{all,1},
           {any,1},
           {call,1},
           {funs,1},
           {list,0},
           {map,1},
           {module_info,0},
           {module_info,1},
           {newproc,1},
           {sending,0},
           {test,1},
           {tuple,1}]}.

{attributes, []}.

{labels, 39}.


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
    {make_fun2,{f,36},0,0,0}.
    {line,[{location,"a.erl",18}]}.
    {call_ext,1,{extfunc,erlang,spawn,1}}.
    {move,{atom,message},{x,1}}.
    {line,[{location,"a.erl",19}]}.
    send.
    {deallocate,0}.
    return.


{function, tuple, 1, 12}.
  {label,11}.
    {line,[{location,"a.erl",21}]}.
    {func_info,{atom,a},{atom,tuple},1}.
  {label,12}.
    {allocate_heap,3,5,1}.
    {init,{y,0}}.
    {move,{x,0},{y,2}}.
    {put_tuple2,{y,1},{list,[{atom,a},{atom,b},{atom,c},{x,0}]}}.
    {move,{y,1},{x,1}}.
    {move,{atom,x},{x,2}}.
    {move,{integer,1},{x,0}}.
    {line,[{location,"a.erl",23}]}.
    {call_ext,3,{extfunc,erlang,setelement,3}}.
    {move,{x,0},{y,0}}.
    {move,{atom,b},{x,1}}.
    {line,[{location,"a.erl",25}]}.
    {call,2,{f,14}}.
    {'%',{type_info,{x,0},
                    {tuple,4,
                           #{{integer,1} => {atom,x},
                             {integer,2} => {atom,b},
                             {integer,3} => {atom,b}}}}}.
    {test_heap,5,1}.
    {put_tuple2,{x,0},{list,[{y,2},{y,1},{y,0},{x,0}]}}.
    {deallocate,3}.
    return.


{function, tuple1, 2, 14}.
  {label,13}.
    {line,[{location,"a.erl",28}]}.
    {func_info,{atom,a},{atom,tuple1},2}.
  {label,14}.
    {'%',{type_info,{x,0},
                    {tuple,4,
                           #{{integer,1} => {atom,x},
                             {integer,2} => {atom,b},
                             {integer,3} => {atom,c}}}}}.
    {'%',{type_info,{x,1},{atom,b}}}.
    {move,{x,0},{x,1}}.
    {move,{atom,b},{x,2}}.
    {move,{integer,3},{x,0}}.
    {line,[{location,"a.erl",29}]}.
    {call_ext_only,3,{extfunc,erlang,setelement,3}}.


{function, map, 1, 16}.
  {label,15}.
    {line,[{location,"a.erl",31}]}.
    {func_info,{atom,a},{atom,map},1}.
  {label,16}.
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


{function, funs, 1, 18}.
  {label,17}.
    {line,[{location,"a.erl",34}]}.
    {func_info,{atom,a},{atom,funs},1}.
  {label,18}.
    {allocate,1,1}.
    {move,{x,0},{y,0}}.
    {make_fun2,{f,34},0,0,0}.
    {move,{y,0},{x,1}}.
    {line,[{location,"a.erl",36}]}.
    {call_ext_last,2,{extfunc,lists,map,2},1}.


{function, all, 1, 20}.
  {label,19}.
    {line,[{location,"a.erl",38}]}.
    {func_info,{atom,a},{atom,all},1}.
  {label,20}.
    {allocate,1,1}.
    {move,{x,0},{y,0}}.
    {make_fun2,{f,31},0,0,0}.
    {move,{y,0},{x,1}}.
    {line,[{location,"a.erl",39}]}.
    {call_ext_last,2,{extfunc,lists,all,2},1}.


{function, any, 1, 22}.
  {label,21}.
    {line,[{location,"a.erl",43}]}.
    {func_info,{atom,a},{atom,any},1}.
  {label,22}.
    {allocate,1,1}.
    {move,{x,0},{y,0}}.
    {make_fun2,{f,28},0,0,0}.
    {move,{y,0},{x,1}}.
    {line,[{location,"a.erl",44}]}.
    {call_ext_last,2,{extfunc,lists,any,2},1}.


{function, module_info, 0, 24}.
  {label,23}.
    {line,[]}.
    {func_info,{atom,a},{atom,module_info},0}.
  {label,24}.
    {move,{atom,a},{x,0}}.
    {line,[]}.
    {call_ext_only,1,{extfunc,erlang,get_module_info,1}}.


{function, module_info, 1, 26}.
  {label,25}.
    {line,[]}.
    {func_info,{atom,a},{atom,module_info},1}.
  {label,26}.
    {move,{x,0},{x,1}}.
    {move,{atom,a},{x,0}}.
    {line,[]}.
    {call_ext_only,2,{extfunc,erlang,get_module_info,2}}.


{function, '-any/1-fun-0-', 1, 28}.
  {label,27}.
    {line,[{location,"a.erl",44}]}.
    {func_info,{atom,a},{atom,'-any/1-fun-0-'},1}.
  {label,28}.
    {test,is_eq_exact,{f,29},[{x,0},{atom,a}]}.
    {move,{atom,true},{x,0}}.
    return.
  {label,29}.
    {move,{atom,false},{x,0}}.
    return.


{function, '-all/1-fun-0-', 1, 31}.
  {label,30}.
    {line,[{location,"a.erl",39}]}.
    {func_info,{atom,a},{atom,'-all/1-fun-0-'},1}.
  {label,31}.
    {test,is_eq_exact,{f,32},[{x,0},{atom,a}]}.
    {move,{atom,true},{x,0}}.
    return.
  {label,32}.
    {move,{atom,false},{x,0}}.
    return.


{function, '-funs/1-fun-0-', 1, 34}.
  {label,33}.
    {line,[{location,"a.erl",35}]}.
    {func_info,{atom,a},{atom,'-funs/1-fun-0-'},1}.
  {label,34}.
    {line,[{location,"a.erl",35}]}.
    {gc_bif,'+',{f,0},1,[{x,0},{integer,1}],{x,0}}.
    return.


{function, '-sending/0-fun-0-', 0, 36}.
  {label,35}.
    {line,[{location,"a.erl",18}]}.
    {func_info,{atom,a},{atom,'-sending/0-fun-0-'},0}.
  {label,36}.
    {allocate,0,0}.
  {label,37}.
    {loop_rec,{f,38},{x,0}}.
    remove_message.
    {deallocate,0}.
    return.
  {label,38}.
    {wait,{f,37}}.
