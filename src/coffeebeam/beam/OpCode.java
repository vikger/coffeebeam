package coffeebeam.beam;

public class OpCode {
    private static int[] arities =
    {-1,
     1, 3, 0, 2, 3, 2, 2, 3, 2, 4,
     5, 2, 3, 2, 3, 2, 1, 1, 0, 0,
     0, 0, 2, 1, 1, 2, 4, 4, 4, 4,
     4, 4, 4, 4, 4, 4, 4, 3, 3, 3,
     3, 3, 3, 3, 2, 2, 2, 2, 2, 2,
     2, 2, 2, 2, 2, 2, 2, 3, 3, 3,
     1, 2, 1, 2, 3, 3, 3, 3, 3, 2,
     1, 1, 0, 1, 1, 3, 2, 2, 2, 5,
     5, 5, 4, 2, 1, 1, 2, 2, 5, 5,
     5, 2, 1, 0, 1, 2, 2, 4, 4, 4,
     4, 3, 1, 2, 1, 1, 1, 2, 6, 3,
     5, 1, 2, 2, 3, 5, 7, 7, 7, 5,
     3, 2, 2, 5, 6, 2, 2, 2, 2, 1,
     3, 4, 0, 8, 6, 2, 6, 5, 4, 5,
     4, 5, 4, 3, 3, 3, 3, 3, 0, 1,
     1, 7, 1, 5, 5, 2, 3, 3, 4, 0,
     0, 2, 2, 2, 3, 4, 3, 2};
    private static String[] names =
    {"",
     "label", "func_info", "int_code_end", "call", "call_last",
     "call_only", "call_ext", "call_ext_last", "bif0", "bif1",
     "bif2", "allocate", "allocate_heap", "allocate_zero", "allocate_heap_zero",
     "test_heap", "init", "deallocate", "return", "send",
     "remove_message", "timeout", "loop_rec", "loop_rec_end", "wait",
     "wait_timeout", "m_plus", "m_minus", "m_times", "m_div",
     "int_div", "int_rem", "int_band", "int_bor", "int_bxor",
     "int_bsl", "int_bsr", "int_bnot", "is_lt", "is_ge",
     "is_eq", "is_ne", "is_eq_exact", "is_ne_exact", "is_integer",
     "is_float", "is_number", "is_atom", "is_pid", "is_reference",
     "is_port", "is_nil", "is_binary", "is_constant", "is_list",
     "is_nonempty_list", "is_tuple", "test_arity", "select_val", "select_tuple_arity",
     "jump", "catch", "catch_end", "move", "get_list",
     "get_tuple_element", "set_tuple_element", "put_string", "put_list", "put_tuple",
     "put", "badmatch", "if_end", "case_end", "call_fun",
     "make_fun", "is_function", "call_ext_only", "bs_start_match", "bs_get_integer",
     "bs_get_float", "bs_get_binary", "bs_skip_bits", "bs_test_tail", "bs_save",
     "bs_restore", "bs_init", "bs_final", "bs_put_integer", "bs_put_binary",
     "bs_put_float", "bs_put_string", "bs_need_buf", "fclearerror", "fcheckerror",
     "fmove", "fconv", "fadd", "fsub", "fmul",
     "fdiv", "fnegate", "make_fun2", "try", "try_end",
     "try_case", "try_case_end", "raise", "bs_init2", "bs_bits_to_bytes",
     "bs_add", "apply", "apply_last", "is_boolean", "is_function2",
     "bs_smart_match2", "bs_get_integer2", "bs_get_float2", "bs_get_binary2", "bs_skip_bits2",
     "bs_test_tail2", "bs_save2", "bs_restore2", "gc_bif1", "gc_bif2",
     "bs_final2", "bis_bits_to_bytes2", "put_literal", "is_bitstr", "bs_context_to_binary",
     "bs_test_unit", "bs_match_string", "bs_init_writable", "bs_append", "bs_private_append",
     "trim", "bs_init_bits", "bs_get_utf8", "bs_skip_utf8", "bs_get_utf16",
     "bs_skip_utf16", "bs_get_utf32", "bs_skip_utf32", "bs_utf8_size", "bs_put_utf8",
     "bs_utf16_size", "bs_put_utf16", "bs_put_utf32", "on_load", "recv_mark",
     "recv_set", "gc_bif3", "line", "put_map_assoc", "put_map_exact",
     "is_map", "has_map_fields", "get_map_elements", "is_tagged_tuple", "build_stacktrace",
     "raw_raise", "get_hd", "get_tl", "put_tuple2", "bs_get_tail",
     "bs_start_match3", "bs_get_position", "bs_set_position"};
    public static int arity(int opcode) {
        return arities[opcode];
    }
    public static String name(int opcode) {
        return names[opcode];
    }
}
