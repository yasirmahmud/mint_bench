module flop_clock_constant_ex2 (input d_in, output reg q_out);
 always @(posedge 1'b0) begin q_out <= d_in;
 end endmodule
