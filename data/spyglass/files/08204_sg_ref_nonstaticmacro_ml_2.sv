`define MY_NON_STATIC_MACRO $time module NonStaticMacro_ex2;
 initial begin $display("Macro value: %0d", `MY_NON_STATIC_MACRO);
 end endmodule
