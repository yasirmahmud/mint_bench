`define MY_MACRO_FROM_INC 123

module top_ex2();
 initial begin $display("Macro value: %d", `MY_MACRO_FROM_INC);
 end 
endmodule
