interface my_if;
 logic a;
endinterface

module my_module_ex2;
 virtual my_if if_arr[4]; // Added 'virtual' keyword to resolve STX_VE_1232
 virtual my_if v_if_slice[2];

 initial begin
  v_if_slice = if_arr[1 +: 2];
 end

endmodule
