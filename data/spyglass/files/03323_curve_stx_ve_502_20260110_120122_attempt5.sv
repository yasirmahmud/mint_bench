module curve_stx_ve_502_20260110_120122_attempt5 (
  input clk,
  input rst_n,
  input in_data,
  output reg out_valid,
  output reg [7:0] out_data
);

// This `endif is unmatched and should trigger STX_VE_502
`endif

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      out_valid <= 1'b0;
      out_data <= 8'h00;
    end else begin
      out_valid <= in_data;
      out_data <= {7'b0, in_data};
    end
  end

endmodule
