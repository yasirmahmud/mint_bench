module my_module_ex1(input clk, d, output reg q);
 always @(clk, d) begin
    if (!clk) begin
      q <= d;
    end else begin
      q <= q; // Explicitly assign q to itself to represent a hold state, avoiding unintentional latch inference
    end
 end
endmodule
