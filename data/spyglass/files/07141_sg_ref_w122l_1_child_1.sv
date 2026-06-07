module latch_w122l_ex1 (input enable, input data, output out);
 reg q;
 always @(enable or data) begin // Added data to sensitivity list to resolve W122
  if (enable) begin
   q <= data;
  end else begin
   q <= q; // Explicitly holds the value when enable is low to resolve InferLatch
  end
 end
 assign out = q;
endmodule
