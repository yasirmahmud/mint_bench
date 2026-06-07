module latch_w336l_ex2 (input enable, input data, output out);
 // spyglass disable_block W336L
 reg q;
 always @(enable or data) begin
  if (enable) q = data;
 end
 assign out = q;
 // spyglass enable_block W336L
 endmodule
