module LatchReset_ex1 (input d, input en, input rst, output reg q);
 always @(*) begin
  if (rst) begin
   q = 1'b0;
  end else if (en) begin
   q = d;
  end else begin
   q = q; // Explicitly hold current value when not enabled and not reset
  end
 end
endmodule
