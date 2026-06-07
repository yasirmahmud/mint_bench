module blocking_ff_1 (
  input clk,
  input d,
  output reg q
);

  always @(posedge clk) begin
    q = d; // Blocking assignment to a flip-flop
  end

endmodule
