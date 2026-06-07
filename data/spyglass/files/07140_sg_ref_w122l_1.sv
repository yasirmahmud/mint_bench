module latch_w122l_ex1 (input enable, input data, output out);
 reg q;
 always @(enable) begin if (enable) q <= data;
 end assign out = q;
 endmodule
