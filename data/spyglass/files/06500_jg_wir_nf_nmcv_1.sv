module top_module_1 (
  input clk,
  output reg out_val
);
  wire my_signal; // Violates: Does not end with _wire
  assign my_signal = clk;
  always @(posedge clk) begin
    out_val <= my_signal;
  end
endmodule
