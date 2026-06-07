module my_module_ex2 (output reg out_signal);
 parameter SEL_VAL = 2'b01;
 initial begin case (SEL_VAL) 2'b00: out_signal = 1'b0;
 2'b01: out_signal = 1'b1;
 default: out_signal = 1'b0;
 endcase end endmodule
