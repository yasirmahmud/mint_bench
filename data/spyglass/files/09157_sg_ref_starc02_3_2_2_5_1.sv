`define MY_MACRO_A 1 `define MY_MACRO_B `MY_MACRO_A module nested_macro_ex1;
 reg [7:0] value;
 initial begin value = `MY_MACRO_B;
 end endmodule
