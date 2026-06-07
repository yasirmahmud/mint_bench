module child_module (
  input wire clk,
  output reg out_signal
);
  // Simple combinational logic to ensure ports are used
  always @(posedge clk) begin
    out_signal <= ~out_signal;
  end
endmodule
