`ifdef SPYGLASS_ANALYSIS_SKIP
module top_design (
  input clk,
  input rst_n,
  output reg out_signal
);

always @(posedge clk or negedge rst_n) begin
  if (~rst_n) begin
    out_signal <= 1'b0;
  end else begin
    out_signal <= ~out_signal;
  end
end

endmodule
