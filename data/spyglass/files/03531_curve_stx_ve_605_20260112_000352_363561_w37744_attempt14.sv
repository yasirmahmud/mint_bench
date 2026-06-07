module curve_stx_ve_605_20260112_000352_363561_w37744_attempt14 (
  input [7:0] in_data,
  output reg [7:0] out_data
);

  parameter DATA_OFFSET = 8'd5; // Define a parameter

  always @* begin
    // STX_VE_605 violation: Illegal attempt to assign a new value
    // to a parameter (DATA_OFFSET) within a combinational procedural block (always @*).
    // Parameters are static constants and cannot be modified after elaboration/during simulation.
    DATA_OFFSET = in_data; // This should trigger STX_VE_605
    out_data = in_data + DATA_OFFSET; // Use DATA_OFFSET for completeness
  end

endmodule
