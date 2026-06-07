`define SOME_FLAG

module curve_stx_ve_502_20260110_120122_attempt3 (
  input clk,
  input rst_n,
  output reg out_valid,
  output reg [7:0] out_data
);

  // Example of a valid preprocessor block
  `ifdef SOME_FLAG
    wire internal_signal = 1'b1; // This line exists if SOME_FLAG is defined
  `else
    wire internal_signal = 1'b0; // This line exists if SOME_FLAG is not defined
  `endif

  // This `endif is unmatched and should trigger STX_VE_502
  `endif

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      out_valid <= 1'b0;
      out_data <= 8'h00;
    end else begin
      out_valid <= internal_signal;
      out_data <= {7'b0, internal_signal};
    end
  end

endmodule
