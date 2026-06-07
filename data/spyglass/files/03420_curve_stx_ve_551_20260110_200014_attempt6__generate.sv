module generate (
  input clk,
  input rst,
  output reg out_signal
);

  // Minimal logic to avoid unused signals
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      out_signal <= 1'b0;
    end else begin
      out_signal <= ~out_signal;
    end
  end

endmodule
