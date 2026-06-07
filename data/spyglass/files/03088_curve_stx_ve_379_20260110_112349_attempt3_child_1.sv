module curve_stx_ve_379_20260110_112349_attempt3 (
  input wire clk,
  output reg [7:0] output_val
);

  // Declare an array with 4 elements, indexed from 0 to 3.
  reg [7:0] data_storage [0:3];

  always @(posedge clk) begin
    // STX_VE_379: Incomplete array literal.
    // The array 'data_storage' has 4 elements (indices 0, 1, 2, 3).
    // The literal provides explicit initial values only for elements 0 and 1.
    // Elements 2 and 3 are not explicitly initialized by this literal,
    // leading to the STX_VE_379 violation.
    // FIX: Added 'default: 8'h00' to explicitly initialize remaining array elements
    // and resolve the STX_VE_379 violation while maintaining functional behavior.
    data_storage <= '{0: 8'hAA, 1: 8'hBB, default: 8'h00};

    // Dummy usage to avoid unused variable warnings and ensure path analysis
    output_val <= data_storage[0];
  end

endmodule
