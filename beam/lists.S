{module, lists}.  %% version = 0

{exports, [{all,2},
           {any,2},
           {append,1},
           {append,2},
           {concat,1},
           {delete,2},
           {droplast,1},
           {dropwhile,2},
           {duplicate,2},
           {filter,2},
           {filtermap,2},
           {flatlength,1},
           {flatmap,2},
           {flatten,1},
           {flatten,2},
           {foldl,3},
           {foldr,3},
           {map,2},
           {module_info,0},
           {module_info,1},
           {reverse,1},
           {reverse,2},
           {zip,2}]}.

{attributes, []}.

{labels, 89}.


{function, all, 2, 2}.
  {label,1}.
    {line,[{location,"lists.erl",27}]}.
    {func_info,{atom,lists},{atom,all},2}.
  {label,2}.
    {test,is_nonempty_list,{f,5},[{x,1}]}.
    {allocate,2,2}.
    {move,{x,0},{y,1}}.
    {get_list,{x,1},{x,0},{y,0}}.
    {move,{y,1},{x,1}}.
    {line,[{location,"lists.erl",28}]}.
    {call_fun,1}.
    {select_val,{x,0},{f,6},{list,[{atom,true},{f,4},{atom,false},{f,3}]}}.
  {label,3}.
    {deallocate,2}.
    return.
  {label,4}.
    {move,{y,0},{x,1}}.
    {move,{y,1},{x,0}}.
    {call_last,2,{f,2},2}.
  {label,5}.
    {test,is_nil,{f,1},[{x,1}]}.
    {move,{atom,true},{x,0}}.
    return.
  {label,6}.
    {test_heap,3,1}.
    {put_tuple2,{x,0},{list,[{atom,badarg},{x,0}]}}.
    {line,[{location,"lists.erl",28}]}.
    {call_ext,1,{extfunc,erlang,error,1}}.


{function, any, 2, 8}.
  {label,7}.
    {line,[{location,"lists.erl",32}]}.
    {func_info,{atom,lists},{atom,any},2}.
  {label,8}.
    {test,is_nonempty_list,{f,11},[{x,1}]}.
    {allocate,2,2}.
    {move,{x,0},{y,1}}.
    {get_list,{x,1},{x,0},{y,0}}.
    {move,{y,1},{x,1}}.
    {line,[{location,"lists.erl",33}]}.
    {call_fun,1}.
    {select_val,{x,0},{f,12},{list,[{atom,false},{f,10},{atom,true},{f,9}]}}.
  {label,9}.
    {deallocate,2}.
    return.
  {label,10}.
    {move,{y,0},{x,1}}.
    {move,{y,1},{x,0}}.
    {call_last,2,{f,8},2}.
  {label,11}.
    {test,is_nil,{f,7},[{x,1}]}.
    {move,{atom,false},{x,0}}.
    return.
  {label,12}.
    {test_heap,3,1}.
    {put_tuple2,{x,0},{list,[{atom,badarg},{x,0}]}}.
    {line,[{location,"lists.erl",33}]}.
    {call_ext,1,{extfunc,erlang,error,1}}.


{function, append, 1, 14}.
  {label,13}.
    {line,[{location,"lists.erl",37}]}.
    {func_info,{atom,lists},{atom,append},1}.
  {label,14}.
    {move,nil,{x,1}}.
    {call_only,2,{f,16}}.


{function, append11, 2, 16}.
  {label,15}.
    {line,[{location,"lists.erl",40}]}.
    {func_info,{atom,lists},{atom,append11},2}.
  {label,16}.
    {test,is_nonempty_list,{f,18},[{x,0}]}.
    {get_list,{x,0},{x,2},{x,3}}.
    {test,is_nonempty_list,{f,17},[{x,2}]}.
    {test_heap,4,4}.
    {get_list,{x,2},{x,0},{x,2}}.
    {put_list,{x,2},{x,3},{x,2}}.
    {put_list,{x,0},{x,1},{x,1}}.
    {move,{x,2},{x,0}}.
    {call_only,2,{f,16}}.
  {label,17}.
    {test,is_nil,{f,15},[{x,2}]}.
    {move,{x,3},{x,0}}.
    {call_only,2,{f,16}}.
  {label,18}.
    {test,is_nil,{f,15},[{x,0}]}.
    {move,{x,1},{x,0}}.
    {call_only,1,{f,72}}.


{function, append, 2, 20}.
  {label,19}.
    {line,[{location,"lists.erl",47}]}.
    {func_info,{atom,lists},{atom,append},2}.
  {label,20}.
    {allocate,1,2}.
    {move,{x,1},{y,0}}.
    {line,[{location,"lists.erl",48}]}.
    {call,1,{f,72}}.
    {move,{y,0},{x,1}}.
    {call_last,2,{f,22},1}.


{function, append21, 2, 22}.
  {label,21}.
    {line,[{location,"lists.erl",50}]}.
    {func_info,{atom,lists},{atom,append21},2}.
  {label,22}.
    {test,is_nonempty_list,{f,23},[{x,0}]}.
    {test_heap,2,2}.
    {get_list,{x,0},{x,2},{x,0}}.
    {put_list,{x,2},{x,1},{x,1}}.
    {call_only,2,{f,22}}.
  {label,23}.
    {test,is_nil,{f,21},[{x,0}]}.
    {move,{x,1},{x,0}}.
    return.


{function, concat, 1, 25}.
  {label,24}.
    {line,[{location,"lists.erl",55}]}.
    {func_info,{atom,lists},{atom,concat},1}.
  {label,25}.
    {test,is_nonempty_list,{f,29},[{x,0}]}.
    {get_list,{x,0},{x,1},{x,2}}.
    {test,is_atom,{f,26},[{x,1}]}.
    {allocate,1,3}.
    {move,{x,2},{y,0}}.
    {move,{x,1},{x,0}}.
    {line,[{location,"lists.erl",56}]}.
    {call_ext,1,{extfunc,erlang,atom_to_list,1}}.
    {move,{y,0},{x,1}}.
    {move,{x,0},{y,0}}.
    {move,{x,1},{x,0}}.
    {line,[{location,"lists.erl",56}]}.
    {call,1,{f,25}}.
    {move,{x,0},{x,1}}.
    {move,{y,0},{x,0}}.
    {call_last,2,{f,20},1}.
  {label,26}.
    {test,is_integer,{f,27},[{x,1}]}.
    {allocate,1,3}.
    {move,{x,2},{y,0}}.
    {move,{x,1},{x,0}}.
    {line,[{location,"lists.erl",58}]}.
    {call_ext,1,{extfunc,erlang,integer_to_list,1}}.
    {move,{y,0},{x,1}}.
    {move,{x,0},{y,0}}.
    {move,{x,1},{x,0}}.
    {line,[{location,"lists.erl",58}]}.
    {call,1,{f,25}}.
    {move,{x,0},{x,1}}.
    {move,{y,0},{x,0}}.
    {call_last,2,{f,20},1}.
  {label,27}.
    {test,is_float,{f,28},[{x,1}]}.
    {allocate,1,3}.
    {move,{x,2},{y,0}}.
    {move,{x,1},{x,0}}.
    {line,[{location,"lists.erl",60}]}.
    {call_ext,1,{extfunc,erlang,float_to_list,1}}.
    {move,{y,0},{x,1}}.
    {move,{x,0},{y,0}}.
    {move,{x,1},{x,0}}.
    {line,[{location,"lists.erl",60}]}.
    {call,1,{f,25}}.
    {move,{x,0},{x,1}}.
    {move,{y,0},{x,0}}.
    {call_last,2,{f,20},1}.
  {label,28}.
    {test,is_list,{f,24},[{x,1}]}.
    {allocate,1,3}.
    {move,{x,1},{y,0}}.
    {move,{x,2},{x,0}}.
    {line,[{location,"lists.erl",62}]}.
    {call,1,{f,25}}.
    {move,{x,0},{x,1}}.
    {move,{y,0},{x,0}}.
    {call_last,2,{f,20},1}.
  {label,29}.
    {test,is_nil,{f,24},[{x,0}]}.
    return.


{function, delete, 2, 31}.
  {label,30}.
    {line,[{location,"lists.erl",66}]}.
    {func_info,{atom,lists},{atom,delete},2}.
  {label,31}.
    {test,is_nonempty_list,{f,33},[{x,1}]}.
    {get_list,{x,1},{x,2},{x,1}}.
    {test,is_eq_exact,{f,32},[{x,2},{x,0}]}.
    {move,{x,1},{x,0}}.
    return.
  {label,32}.
    {allocate,1,3}.
    {move,{x,2},{y,0}}.
    {line,[{location,"lists.erl",69}]}.
    {call,2,{f,31}}.
    {test_heap,2,1}.
    {put_list,{y,0},{x,0},{x,0}}.
    {deallocate,1}.
    return.
  {label,33}.
    {test,is_nil,{f,30},[{x,1}]}.
    {move,nil,{x,0}}.
    return.


{function, droplast, 1, 35}.
  {label,34}.
    {line,[{location,"lists.erl",73}]}.
    {func_info,{atom,lists},{atom,droplast},1}.
  {label,35}.
    {test,is_nonempty_list,{f,34},[{x,0}]}.
    {get_list,{x,0},{x,1},{x,0}}.
    {test,is_nil,{f,36},[{x,0}]}.
    return.
  {label,36}.
    {allocate,1,2}.
    {move,{x,1},{y,0}}.
    {line,[{location,"lists.erl",76}]}.
    {call,1,{f,35}}.
    {'%',{type_info,{x,0},list}}.
    {test_heap,2,1}.
    {put_list,{y,0},{x,0},{x,0}}.
    {deallocate,1}.
    return.


{function, dropwhile, 2, 38}.
  {label,37}.
    {line,[{location,"lists.erl",78}]}.
    {func_info,{atom,lists},{atom,dropwhile},2}.
  {label,38}.
    {test,is_nonempty_list,{f,40},[{x,1}]}.
    {allocate,3,2}.
    {move,{x,1},{y,1}}.
    {move,{x,0},{y,2}}.
    {get_list,{x,1},{x,0},{y,0}}.
    {move,{y,2},{x,1}}.
    {line,[{location,"lists.erl",79}]}.
    {call_fun,1}.
    {test,is_eq_exact,{f,39},[{x,0},{atom,true}]}.
    {move,{y,0},{x,1}}.
    {move,{y,2},{x,0}}.
    {call_last,2,{f,38},3}.
  {label,39}.
    {move,{y,1},{x,0}}.
    {deallocate,3}.
    return.
  {label,40}.
    {test,is_nil,{f,37},[{x,1}]}.
    {move,nil,{x,0}}.
    return.


{function, duplicate, 2, 42}.
  {label,41}.
    {line,[{location,"lists.erl",88}]}.
    {func_info,{atom,lists},{atom,duplicate},2}.
  {label,42}.
    {test,is_eq_exact,{f,43},[{x,0},{integer,0}]}.
    {move,nil,{x,0}}.
    return.
  {label,43}.
    {line,[{location,"lists.erl",91}]}.
    {gc_bif,'-',{f,0},2,[{x,0},{integer,1}],{x,0}}.
    {allocate,1,2}.
    {move,{x,1},{y,0}}.
    {line,[{location,"lists.erl",91}]}.
    {call,2,{f,42}}.
    {'%',{type_info,{x,0},list}}.
    {test_heap,2,1}.
    {put_list,{y,0},{x,0},{x,0}}.
    {deallocate,1}.
    return.


{function, filter, 2, 45}.
  {label,44}.
    {line,[{location,"lists.erl",93}]}.
    {func_info,{atom,lists},{atom,filter},2}.
  {label,45}.
    {test,is_nonempty_list,{f,47},[{x,1}]}.
    {allocate,3,2}.
    {move,{x,0},{y,2}}.
    {get_list,{x,1},{y,1},{y,0}}.
    {move,{y,2},{x,1}}.
    {move,{y,1},{x,0}}.
    {line,[{location,"lists.erl",94}]}.
    {call_fun,1}.
    {test,is_eq_exact,{f,46},[{x,0},{atom,true}]}.
    {move,{y,0},{x,1}}.
    {move,{y,2},{x,0}}.
    {kill,{y,2}}.
    {trim,1,2}.
    {line,[{location,"lists.erl",96}]}.
    {call,2,{f,45}}.
    {'%',{type_info,{x,0},list}}.
    {test_heap,2,1}.
    {put_list,{y,0},{x,0},{x,0}}.
    {deallocate,2}.
    return.
  {label,46}.
    {move,{y,0},{x,1}}.
    {move,{y,2},{x,0}}.
    {call_last,2,{f,45},3}.
  {label,47}.
    {test,is_nil,{f,44},[{x,1}]}.
    {move,nil,{x,0}}.
    return.


{function, filtermap, 2, 49}.
  {label,48}.
    {line,[{location,"lists.erl",103}]}.
    {func_info,{atom,lists},{atom,filtermap},2}.
  {label,49}.
    {allocate,1,2}.
    {move,{x,1},{y,0}}.
    {make_fun2,{f,84},0,0,1}.
    {move,{y,0},{x,2}}.
    {move,nil,{x,1}}.
    {call_last,3,{f,66},1}.


{function, flatlength, 1, 51}.
  {label,50}.
    {line,[{location,"lists.erl",112}]}.
    {func_info,{atom,lists},{atom,flatlength},1}.
  {label,51}.
    {allocate,0,1}.
    {line,[{location,"lists.erl",113}]}.
    {call,1,{f,55}}.
    {line,[{location,"lists.erl",113}]}.
    {gc_bif,length,{f,0},1,[{x,0}],{x,0}}.
    {deallocate,0}.
    return.


{function, flatmap, 2, 53}.
  {label,52}.
    {line,[{location,"lists.erl",115}]}.
    {func_info,{atom,lists},{atom,flatmap},2}.
  {label,53}.
    {allocate,0,2}.
    {line,[{location,"lists.erl",116}]}.
    {call,2,{f,69}}.
    {'%',{type_info,{x,0},list}}.
    {call_last,1,{f,14},0}.


{function, flatten, 1, 55}.
  {label,54}.
    {line,[{location,"lists.erl",118}]}.
    {func_info,{atom,lists},{atom,flatten},1}.
  {label,55}.
    {test,is_list,{f,54},[{x,0}]}.
    {move,nil,{x,1}}.
    {call_only,2,{f,59}}.


{function, flatten, 2, 57}.
  {label,56}.
    {line,[{location,"lists.erl",121}]}.
    {func_info,{atom,lists},{atom,flatten},2}.
  {label,57}.
    {test,is_list,{f,56},[{x,0}]}.
    {test,is_list,{f,56},[{x,1}]}.
    {call_only,2,{f,59}}.


{function, do_flatten, 2, 59}.
  {label,58}.
    {line,[{location,"lists.erl",124}]}.
    {func_info,{atom,lists},{atom,do_flatten},2}.
  {label,59}.
    {test,is_nonempty_list,{f,61},[{x,0}]}.
    {get_list,{x,0},{x,2},{x,0}}.
    {test,is_list,{f,60},[{x,2}]}.
    {allocate,1,3}.
    {move,{x,2},{y,0}}.
    {line,[{location,"lists.erl",125}]}.
    {call,2,{f,59}}.
    {move,{x,0},{x,1}}.
    {move,{y,0},{x,0}}.
    {call_last,2,{f,59},1}.
  {label,60}.
    {allocate,1,3}.
    {move,{x,2},{y,0}}.
    {line,[{location,"lists.erl",127}]}.
    {call,2,{f,59}}.
    {test_heap,2,1}.
    {put_list,{y,0},{x,0},{x,0}}.
    {deallocate,1}.
    return.
  {label,61}.
    {test,is_nil,{f,58},[{x,0}]}.
    {move,{x,1},{x,0}}.
    return.


{function, foldl, 3, 63}.
  {label,62}.
    {line,[{location,"lists.erl",132}]}.
    {func_info,{atom,lists},{atom,foldl},3}.
  {label,63}.
    {test,is_nonempty_list,{f,64},[{x,2}]}.
    {allocate,2,3}.
    {move,{x,0},{y,1}}.
    {get_list,{x,2},{x,0},{y,0}}.
    {move,{y,1},{x,2}}.
    {line,[{location,"lists.erl",133}]}.
    {call_fun,2}.
    {move,{x,0},{x,1}}.
    {move,{y,0},{x,2}}.
    {move,{y,1},{x,0}}.
    {call_last,3,{f,63},2}.
  {label,64}.
    {test,is_nil,{f,62},[{x,2}]}.
    {move,{x,1},{x,0}}.
    return.


{function, foldr, 3, 66}.
  {label,65}.
    {line,[{location,"lists.erl",137}]}.
    {func_info,{atom,lists},{atom,foldr},3}.
  {label,66}.
    {test,is_nonempty_list,{f,67},[{x,2}]}.
    {allocate,2,3}.
    {move,{x,0},{y,1}}.
    {get_list,{x,2},{y,0},{x,2}}.
    {line,[{location,"lists.erl",138}]}.
    {call,3,{f,66}}.
    {move,{x,0},{x,1}}.
    {move,{y,1},{x,2}}.
    {move,{y,0},{x,0}}.
    {line,[{location,"lists.erl",138}]}.
    {call_fun,2}.
    {deallocate,2}.
    return.
  {label,67}.
    {test,is_nil,{f,65},[{x,2}]}.
    {move,{x,1},{x,0}}.
    return.


{function, map, 2, 69}.
  {label,68}.
    {line,[{location,"lists.erl",142}]}.
    {func_info,{atom,lists},{atom,map},2}.
  {label,69}.
    {test,is_nonempty_list,{f,70},[{x,1}]}.
    {allocate,2,2}.
    {move,{x,0},{y,1}}.
    {get_list,{x,1},{x,0},{y,0}}.
    {move,{y,1},{x,1}}.
    {line,[{location,"lists.erl",143}]}.
    {call_fun,1}.
    {move,{y,0},{x,2}}.
    {move,{y,1},{x,1}}.
    {move,{x,0},{y,1}}.
    {move,{x,1},{x,0}}.
    {move,{x,2},{x,1}}.
    {trim,1,1}.
    {line,[{location,"lists.erl",143}]}.
    {call,2,{f,69}}.
    {'%',{type_info,{x,0},list}}.
    {test_heap,2,1}.
    {put_list,{y,0},{x,0},{x,0}}.
    {deallocate,1}.
    return.
  {label,70}.
    {test,is_nil,{f,68},[{x,1}]}.
    {move,nil,{x,0}}.
    return.


{function, reverse, 1, 72}.
  {label,71}.
    {line,[{location,"lists.erl",147}]}.
    {func_info,{atom,lists},{atom,reverse},1}.
  {label,72}.
    {move,nil,{x,1}}.
    {call_only,2,{f,74}}.


{function, reverse, 2, 74}.
  {label,73}.
    {line,[{location,"lists.erl",150}]}.
    {func_info,{atom,lists},{atom,reverse},2}.
  {label,74}.
    {test,is_nonempty_list,{f,75},[{x,0}]}.
    {test_heap,2,2}.
    {get_list,{x,0},{x,2},{x,0}}.
    {put_list,{x,2},{x,1},{x,1}}.
    {call_only,2,{f,74}}.
  {label,75}.
    {test,is_nil,{f,73},[{x,0}]}.
    {move,{x,1},{x,0}}.
    return.


{function, zip, 2, 77}.
  {label,76}.
    {line,[{location,"lists.erl",155}]}.
    {func_info,{atom,lists},{atom,zip},2}.
  {label,77}.
    {test,is_nonempty_list,{f,78},[{x,0}]}.
    {get_list,{x,0},{x,2},{x,3}}.
    {test,is_nonempty_list,{f,76},[{x,1}]}.
    {allocate,2,4}.
    {move,{x,2},{y,1}}.
    {get_list,{x,1},{y,0},{x,1}}.
    {move,{x,3},{x,0}}.
    {line,[{location,"lists.erl",156}]}.
    {call,2,{f,77}}.
    {'%',{type_info,{x,0},list}}.
    {test_heap,5,1}.
    {put_tuple2,{x,1},{list,[{y,1},{y,0}]}}.
    {put_list,{x,1},{x,0},{x,0}}.
    {deallocate,2}.
    return.
  {label,78}.
    {test,is_nil,{f,76},[{x,0}]}.
    {test,is_nil,{f,76},[{x,1}]}.
    {move,nil,{x,0}}.
    return.


{function, module_info, 0, 80}.
  {label,79}.
    {line,[]}.
    {func_info,{atom,lists},{atom,module_info},0}.
  {label,80}.
    {move,{atom,lists},{x,0}}.
    {line,[]}.
    {call_ext_only,1,{extfunc,erlang,get_module_info,1}}.


{function, module_info, 1, 82}.
  {label,81}.
    {line,[]}.
    {func_info,{atom,lists},{atom,module_info},1}.
  {label,82}.
    {move,{x,0},{x,1}}.
    {move,{atom,lists},{x,0}}.
    {line,[]}.
    {call_ext_only,2,{extfunc,erlang,get_module_info,2}}.


{function, '-filtermap/2-fun-0-', 3, 84}.
  {label,83}.
    {line,[{location,"lists.erl",104}]}.
    {func_info,{atom,lists},{atom,'-filtermap/2-fun-0-'},3}.
  {label,84}.
    {allocate,2,3}.
    {move,{x,0},{y,0}}.
    {move,{x,1},{y,1}}.
    {move,{x,2},{x,1}}.
    {line,[{location,"lists.erl",105}]}.
    {call_fun,1}.
    {test,is_tuple,{f,85},[{x,0}]}.
    {test,is_tagged_tuple,{f,88},[{x,0},2,{atom,true}]}.
    {test_heap,2,1}.
    {get_tuple_element,{x,0},1,{x,0}}.
    {put_list,{x,0},{y,1},{x,0}}.
    {deallocate,2}.
    return.
  {label,85}.
    {select_val,{x,0},{f,88},{list,[{atom,true},{f,87},{atom,false},{f,86}]}}.
  {label,86}.
    {move,{y,1},{x,0}}.
    {deallocate,2}.
    return.
  {label,87}.
    {test_heap,2,0}.
    {put_list,{y,0},{y,1},{x,0}}.
    {deallocate,2}.
    return.
  {label,88}.
    {line,[{location,"lists.erl",105}]}.
    {case_end,{x,0}}.
