module latch_w336l_ex1(enable, data, out);
 input enable, data;
 output out;
 reg q;
 always @(enable or data) begin
  q = q; // Explicitly assign q to itself to indicate intended latch behavior
  if (enable) q = data;
 end
 assign out = q;
 endmodule
