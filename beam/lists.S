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
           {seq,2},
           {zip,2}]}.

{attributes, []}.

{labels, 89}.


{function, all, 2, 2}.
  {label,1}.
    {line,[{location,"lists.erl",28}]}.
    {func_info,{atom,lists},{atom,all},2}.
  {label,2}.
    {test,is_nonempty_list,{f,5},[{x,1}]}.
    {allocate,2,2}.
    {move,{x,0},{y,1}}.
    {get_list,{x,1},{x,0},{y,0}}.
    {move,{y,1},{x,1}}.
    {line,[{location,"lists.erl",29}]}.
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
    {line,[{location,"lists.erl",29}]}.
    {call_ext,1,{extfunc,erlang,error,1}}.


{function, any, 2, 8}.
  {label,7}.
    {line,[{location,"lists.erl",33}]}.
    {func_info,{atom,lists},{atom,any},2}.
  {label,8}.
    {test,is_nonempty_list,{f,11},[{x,1}]}.
    {allocate,2,2}.
    {move,{x,0},{y,1}}.
    {get_list,{x,1},{x,0},{y,0}}.
    {move,{y,1},{x,1}}.
    {line,[{location,"lists.erl",34}]}.
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
    {line,[{location,"lists.erl",34}]}.
    {call_ext,1,{extfunc,erlang,error,1}}.


{function, append, 1, 14}.
  {label,13}.
    {line,[{location,"lists.erl",38}]}.
    {func_info,{atom,lists},{atom,append},1}.
  {label,14}.
    {move,nil,{x,1}}.
    {call_only,2,{f,16}}.


{function, append11, 2, 16}.
  {label,15}.
    {line,[{location,"lists.erl",41}]}.
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
    {call_only,1,{f,69}}.


{function, append, 2, 20}.
  {label,19}.
    {line,[{location,"lists.erl",48}]}.
    {func_info,{atom,lists},{atom,append},2}.
  {label,20}.
    {line,[{location,"lists.erl",49}]}.
    {call_ext_only,2,{extfunc,erlang,'++',2}}.


{function, concat, 1, 22}.
  {label,21}.
    {line,[{location,"lists.erl",51}]}.
    {func_info,{atom,lists},{atom,concat},1}.
  {label,22}.
    {test,is_nonempty_list,{f,26},[{x,0}]}.
    {get_list,{x,0},{x,1},{x,2}}.
    {test,is_atom,{f,23},[{x,1}]}.
    {allocate,1,3}.
    {move,{x,2},{y,0}}.
    {move,{x,1},{x,0}}.
    {line,[{location,"lists.erl",52}]}.
    {call_ext,1,{extfunc,erlang,atom_to_list,1}}.
    {move,{y,0},{x,1}}.
    {move,{x,0},{y,0}}.
    {move,{x,1},{x,0}}.
    {line,[{location,"lists.erl",52}]}.
    {call,1,{f,22}}.
    {move,{x,0},{x,1}}.
    {move,{y,0},{x,0}}.
    {call_last,2,{f,20},1}.
  {label,23}.
    {test,is_integer,{f,24},[{x,1}]}.
    {allocate,1,3}.
    {move,{x,2},{y,0}}.
    {move,{x,1},{x,0}}.
    {line,[{location,"lists.erl",54}]}.
    {call_ext,1,{extfunc,erlang,integer_to_list,1}}.
    {move,{y,0},{x,1}}.
    {move,{x,0},{y,0}}.
    {move,{x,1},{x,0}}.
    {line,[{location,"lists.erl",54}]}.
    {call,1,{f,22}}.
    {move,{x,0},{x,1}}.
    {move,{y,0},{x,0}}.
    {call_last,2,{f,20},1}.
  {label,24}.
    {test,is_float,{f,25},[{x,1}]}.
    {allocate,1,3}.
    {move,{x,2},{y,0}}.
    {move,{x,1},{x,0}}.
    {line,[{location,"lists.erl",56}]}.
    {call_ext,1,{extfunc,erlang,float_to_list,1}}.
    {move,{y,0},{x,1}}.
    {move,{x,0},{y,0}}.
    {move,{x,1},{x,0}}.
    {line,[{location,"lists.erl",56}]}.
    {call,1,{f,22}}.
    {move,{x,0},{x,1}}.
    {move,{y,0},{x,0}}.
    {call_last,2,{f,20},1}.
  {label,25}.
    {test,is_list,{f,21},[{x,1}]}.
    {allocate,1,3}.
    {move,{x,1},{y,0}}.
    {move,{x,2},{x,0}}.
    {line,[{location,"lists.erl",58}]}.
    {call,1,{f,22}}.
    {move,{x,0},{x,1}}.
    {move,{y,0},{x,0}}.
    {call_last,2,{f,20},1}.
  {label,26}.
    {test,is_nil,{f,21},[{x,0}]}.
    return.


{function, delete, 2, 28}.
  {label,27}.
    {line,[{location,"lists.erl",62}]}.
    {func_info,{atom,lists},{atom,delete},2}.
  {label,28}.
    {test,is_nonempty_list,{f,30},[{x,1}]}.
    {get_list,{x,1},{x,2},{x,1}}.
    {test,is_eq_exact,{f,29},[{x,2},{x,0}]}.
    {move,{x,1},{x,0}}.
    return.
  {label,29}.
    {allocate,1,3}.
    {move,{x,2},{y,0}}.
    {line,[{location,"lists.erl",65}]}.
    {call,2,{f,28}}.
    {test_heap,2,1}.
    {put_list,{y,0},{x,0},{x,0}}.
    {deallocate,1}.
    return.
  {label,30}.
    {test,is_nil,{f,27},[{x,1}]}.
    {move,nil,{x,0}}.
    return.


{function, droplast, 1, 32}.
  {label,31}.
    {line,[{location,"lists.erl",69}]}.
    {func_info,{atom,lists},{atom,droplast},1}.
  {label,32}.
    {test,is_nonempty_list,{f,31},[{x,0}]}.
    {get_list,{x,0},{x,1},{x,0}}.
    {test,is_nil,{f,33},[{x,0}]}.
    return.
  {label,33}.
    {allocate,1,2}.
    {move,{x,1},{y,0}}.
    {line,[{location,"lists.erl",72}]}.
    {call,1,{f,32}}.
    {'%',{type_info,{x,0},list}}.
    {test_heap,2,1}.
    {put_list,{y,0},{x,0},{x,0}}.
    {deallocate,1}.
    return.


{function, dropwhile, 2, 35}.
  {label,34}.
    {line,[{location,"lists.erl",74}]}.
    {func_info,{atom,lists},{atom,dropwhile},2}.
  {label,35}.
    {test,is_nonempty_list,{f,37},[{x,1}]}.
    {allocate,3,2}.
    {move,{x,1},{y,1}}.
    {move,{x,0},{y,2}}.
    {get_list,{x,1},{x,0},{y,0}}.
    {move,{y,2},{x,1}}.
    {line,[{location,"lists.erl",75}]}.
    {call_fun,1}.
    {test,is_eq_exact,{f,36},[{x,0},{atom,true}]}.
    {move,{y,0},{x,1}}.
    {move,{y,2},{x,0}}.
    {call_last,2,{f,35},3}.
  {label,36}.
    {move,{y,1},{x,0}}.
    {deallocate,3}.
    return.
  {label,37}.
    {test,is_nil,{f,34},[{x,1}]}.
    {move,nil,{x,0}}.
    return.


{function, duplicate, 2, 39}.
  {label,38}.
    {line,[{location,"lists.erl",84}]}.
    {func_info,{atom,lists},{atom,duplicate},2}.
  {label,39}.
    {test,is_eq_exact,{f,40},[{x,0},{integer,0}]}.
    {move,nil,{x,0}}.
    return.
  {label,40}.
    {line,[{location,"lists.erl",87}]}.
    {gc_bif,'-',{f,0},2,[{x,0},{integer,1}],{x,0}}.
    {allocate,1,2}.
    {move,{x,1},{y,0}}.
    {line,[{location,"lists.erl",87}]}.
    {call,2,{f,39}}.
    {'%',{type_info,{x,0},list}}.
    {test_heap,2,1}.
    {put_list,{y,0},{x,0},{x,0}}.
    {deallocate,1}.
    return.


{function, filter, 2, 42}.
  {label,41}.
    {line,[{location,"lists.erl",89}]}.
    {func_info,{atom,lists},{atom,filter},2}.
  {label,42}.
    {test,is_nonempty_list,{f,44},[{x,1}]}.
    {allocate,3,2}.
    {move,{x,0},{y,2}}.
    {get_list,{x,1},{y,1},{y,0}}.
    {move,{y,2},{x,1}}.
    {move,{y,1},{x,0}}.
    {line,[{location,"lists.erl",90}]}.
    {call_fun,1}.
    {test,is_eq_exact,{f,43},[{x,0},{atom,true}]}.
    {move,{y,0},{x,1}}.
    {move,{y,2},{x,0}}.
    {kill,{y,2}}.
    {trim,1,2}.
    {line,[{location,"lists.erl",92}]}.
    {call,2,{f,42}}.
    {'%',{type_info,{x,0},list}}.
    {test_heap,2,1}.
    {put_list,{y,0},{x,0},{x,0}}.
    {deallocate,2}.
    return.
  {label,43}.
    {move,{y,0},{x,1}}.
    {move,{y,2},{x,0}}.
    {call_last,2,{f,42},3}.
  {label,44}.
    {test,is_nil,{f,41},[{x,1}]}.
    {move,nil,{x,0}}.
    return.


{function, filtermap, 2, 46}.
  {label,45}.
    {line,[{location,"lists.erl",99}]}.
    {func_info,{atom,lists},{atom,filtermap},2}.
  {label,46}.
    {allocate,1,2}.
    {move,{x,1},{y,0}}.
    {make_fun2,{f,84},0,0,1}.
    {move,{y,0},{x,2}}.
    {move,nil,{x,1}}.
    {call_last,3,{f,63},1}.


{function, flatlength, 1, 48}.
  {label,47}.
    {line,[{location,"lists.erl",108}]}.
    {func_info,{atom,lists},{atom,flatlength},1}.
  {label,48}.
    {allocate,0,1}.
    {line,[{location,"lists.erl",109}]}.
    {call,1,{f,52}}.
    {line,[{location,"lists.erl",109}]}.
    {gc_bif,length,{f,0},1,[{x,0}],{x,0}}.
    {deallocate,0}.
    return.


{function, flatmap, 2, 50}.
  {label,49}.
    {line,[{location,"lists.erl",111}]}.
    {func_info,{atom,lists},{atom,flatmap},2}.
  {label,50}.
    {allocate,0,2}.
    {line,[{location,"lists.erl",112}]}.
    {call,2,{f,66}}.
    {'%',{type_info,{x,0},list}}.
    {call_last,1,{f,14},0}.


{function, flatten, 1, 52}.
  {label,51}.
    {line,[{location,"lists.erl",114}]}.
    {func_info,{atom,lists},{atom,flatten},1}.
  {label,52}.
    {test,is_list,{f,51},[{x,0}]}.
    {move,nil,{x,1}}.
    {call_only,2,{f,56}}.


{function, flatten, 2, 54}.
  {label,53}.
    {line,[{location,"lists.erl",117}]}.
    {func_info,{atom,lists},{atom,flatten},2}.
  {label,54}.
    {test,is_list,{f,53},[{x,0}]}.
    {test,is_list,{f,53},[{x,1}]}.
    {call_only,2,{f,56}}.


{function, do_flatten, 2, 56}.
  {label,55}.
    {line,[{location,"lists.erl",120}]}.
    {func_info,{atom,lists},{atom,do_flatten},2}.
  {label,56}.
    {test,is_nonempty_list,{f,58},[{x,0}]}.
    {get_list,{x,0},{x,2},{x,0}}.
    {test,is_list,{f,57},[{x,2}]}.
    {allocate,1,3}.
    {move,{x,2},{y,0}}.
    {line,[{location,"lists.erl",121}]}.
    {call,2,{f,56}}.
    {move,{x,0},{x,1}}.
    {move,{y,0},{x,0}}.
    {call_last,2,{f,56},1}.
  {label,57}.
    {allocate,1,3}.
    {move,{x,2},{y,0}}.
    {line,[{location,"lists.erl",123}]}.
    {call,2,{f,56}}.
    {test_heap,2,1}.
    {put_list,{y,0},{x,0},{x,0}}.
    {deallocate,1}.
    return.
  {label,58}.
    {test,is_nil,{f,55},[{x,0}]}.
    {move,{x,1},{x,0}}.
    return.


{function, foldl, 3, 60}.
  {label,59}.
    {line,[{location,"lists.erl",128}]}.
    {func_info,{atom,lists},{atom,foldl},3}.
  {label,60}.
    {test,is_nonempty_list,{f,61},[{x,2}]}.
    {allocate,2,3}.
    {move,{x,0},{y,1}}.
    {get_list,{x,2},{x,0},{y,0}}.
    {move,{y,1},{x,2}}.
    {line,[{location,"lists.erl",129}]}.
    {call_fun,2}.
    {move,{x,0},{x,1}}.
    {move,{y,0},{x,2}}.
    {move,{y,1},{x,0}}.
    {call_last,3,{f,60},2}.
  {label,61}.
    {test,is_nil,{f,59},[{x,2}]}.
    {move,{x,1},{x,0}}.
    return.


{function, foldr, 3, 63}.
  {label,62}.
    {line,[{location,"lists.erl",133}]}.
    {func_info,{atom,lists},{atom,foldr},3}.
  {label,63}.
    {test,is_nonempty_list,{f,64},[{x,2}]}.
    {allocate,2,3}.
    {move,{x,0},{y,1}}.
    {get_list,{x,2},{y,0},{x,2}}.
    {line,[{location,"lists.erl",134}]}.
    {call,3,{f,63}}.
    {move,{x,0},{x,1}}.
    {move,{y,1},{x,2}}.
    {move,{y,0},{x,0}}.
    {line,[{location,"lists.erl",134}]}.
    {call_fun,2}.
    {deallocate,2}.
    return.
  {label,64}.
    {test,is_nil,{f,62},[{x,2}]}.
    {move,{x,1},{x,0}}.
    return.


{function, map, 2, 66}.
  {label,65}.
    {line,[{location,"lists.erl",138}]}.
    {func_info,{atom,lists},{atom,map},2}.
  {label,66}.
    {test,is_nonempty_list,{f,67},[{x,1}]}.
    {allocate,2,2}.
    {move,{x,0},{y,1}}.
    {get_list,{x,1},{x,0},{y,0}}.
    {move,{y,1},{x,1}}.
    {line,[{location,"lists.erl",139}]}.
    {call_fun,1}.
    {move,{y,0},{x,2}}.
    {move,{y,1},{x,1}}.
    {move,{x,0},{y,1}}.
    {move,{x,1},{x,0}}.
    {move,{x,2},{x,1}}.
    {trim,1,1}.
    {line,[{location,"lists.erl",139}]}.
    {call,2,{f,66}}.
    {'%',{type_info,{x,0},list}}.
    {test_heap,2,1}.
    {put_list,{y,0},{x,0},{x,0}}.
    {deallocate,1}.
    return.
  {label,67}.
    {test,is_nil,{f,65},[{x,1}]}.
    {move,nil,{x,0}}.
    return.


{function, reverse, 1, 69}.
  {label,68}.
    {line,[{location,"lists.erl",145}]}.
    {func_info,{atom,lists},{atom,reverse},1}.
  {label,69}.
    {move,nil,{x,1}}.
    {call_only,2,{f,71}}.


{function, reverse, 2, 71}.
  {label,70}.
    {line,[{location,"lists.erl",148}]}.
    {func_info,{atom,lists},{atom,reverse},2}.
  {label,71}.
    {test,is_nonempty_list,{f,72},[{x,0}]}.
    {test_heap,2,2}.
    {get_list,{x,0},{x,2},{x,0}}.
    {put_list,{x,2},{x,1},{x,1}}.
    {call_only,2,{f,71}}.
  {label,72}.
    {test,is_nil,{f,70},[{x,0}]}.
    {move,{x,1},{x,0}}.
    return.


{function, seq, 2, 74}.
  {label,73}.
    {line,[{location,"lists.erl",153}]}.
    {func_info,{atom,lists},{atom,seq},2}.
  {label,74}.
    {test,is_eq_exact,{f,75},[{x,1},{x,0}]}.
    {test_heap,2,1}.
    {put_list,{x,0},nil,{x,0}}.
    return.
  {label,75}.
    {line,[{location,"lists.erl",156}]}.
    {gc_bif,'+',{f,0},2,[{x,0},{integer,1}],{x,2}}.
    {allocate,1,3}.
    {move,{x,0},{y,0}}.
    {move,{x,2},{x,0}}.
    {line,[{location,"lists.erl",156}]}.
    {call,2,{f,74}}.
    {'%',{type_info,{x,0},cons}}.
    {test_heap,2,1}.
    {put_list,{y,0},{x,0},{x,0}}.
    {deallocate,1}.
    return.


{function, zip, 2, 77}.
  {label,76}.
    {line,[{location,"lists.erl",158}]}.
    {func_info,{atom,lists},{atom,zip},2}.
  {label,77}.
    {test,is_nonempty_list,{f,78},[{x,0}]}.
    {get_list,{x,0},{x,2},{x,3}}.
    {test,is_nonempty_list,{f,76},[{x,1}]}.
    {allocate,2,4}.
    {move,{x,2},{y,1}}.
    {get_list,{x,1},{y,0},{x,1}}.
    {move,{x,3},{x,0}}.
    {line,[{location,"lists.erl",159}]}.
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
    {line,[{location,"lists.erl",100}]}.
    {func_info,{atom,lists},{atom,'-filtermap/2-fun-0-'},3}.
  {label,84}.
    {allocate,2,3}.
    {move,{x,0},{y,0}}.
    {move,{x,1},{y,1}}.
    {move,{x,2},{x,1}}.
    {line,[{location,"lists.erl",101}]}.
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
    {line,[{location,"lists.erl",101}]}.
    {case_end,{x,0}}.
