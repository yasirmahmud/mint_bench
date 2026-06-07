interface my_if;
 logic a;
 endinterface module my_module_ex2;
 my_if if_arr[4];
 virtual my_if v_if_slice[2];
 initial begin v_if_slice = if_arr[1 +: 2];
 end endmodule
