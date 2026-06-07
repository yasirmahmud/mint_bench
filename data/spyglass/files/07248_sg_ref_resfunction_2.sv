module ResFunction_ex2 (input wire a, input wire b, output reg out);
 function real my_resolution_func;
 input bit in1;
 input bit in2;
 real temp_val;
 begin temp_val = (in1 == 1'b1) ? 1.0 : 0.0;
 temp_val = temp_val + ((in2 == 1'b1) ? 0.5 : 0.0);
 my_resolution_func = temp_val;
 end endfunction always @(*) begin if (my_resolution_func(a, b) > 0.5) begin out = 1'b1;
 end else begin out = 1'b0;
 end end endmodule
