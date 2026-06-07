module curve_stx_ve_605_attempt13 (
  input clk,
  input reset,
  output reg [7:0] data_out
);

  localparam LP_CONFIG_VALUE = 8'd100; // Define a localparam

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      data_out <= 8'h0;
      // STX_VE_605 violation: Attempt to assign a new value to a localparam
      // within a procedural block (always). Localparams are static constants
      // and cannot be modified after elaboration.
      LP_CONFIG_VALUE = 8'd50; // This should trigger STX_VE_605
    end else begin
      data_out <= data_out + 1;
    end
  end

endmodule
