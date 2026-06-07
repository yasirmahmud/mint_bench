module latch_async_reset_ex2 (input d, input en, input arst, output reg q);
 always @(d or en or arst) begin 
  if (arst) begin 
    q = 1'b0;
  end else if (en) begin 
    q = d;
  end
  // When arst is low and en is low, q is not assigned.
  // This implicitly infers a latch, causing q to hold its previous value,
  // which preserves the functional behavior described by the original `q = q;`.
 end 
endmodule
