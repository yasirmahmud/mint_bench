module latch_w336l_ex2 (input enable, input data, output out);
 reg q;
 always @(enable or data) begin if (enable) q = data;
 end assign out = q;
 endmodule
