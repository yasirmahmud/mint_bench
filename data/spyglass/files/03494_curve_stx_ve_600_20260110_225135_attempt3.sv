module curve_stx_ve_600_20260110_225135_attempt3 (
    input clk,
    input reset_n,
    output [7:0] out_data
);

  // Declare a parameter. This is the first declaration of the name "DATA_COUNT".
  parameter DATA_COUNT = 8;

  // Re-declare the same name "DATA_COUNT" as a register.
  // This re-declaration, where the name conflicts with the previously declared parameter,
  // will trigger the STX_VE_600 violation.
  reg [DATA_COUNT-1:0] DATA_COUNT; // This line is expected to cause the violation.

  // Simple logic to use all ports and the re-declared 'DATA_COUNT' (as a reg)
  always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
      DATA_COUNT <= 'h0; // Initialize the reg DATA_COUNT
      out_data   <= 'h0;
    end else begin
      DATA_COUNT <= DATA_COUNT + 1; // Increment the reg DATA_COUNT
      out_data   <= DATA_COUNT;     // Output the value of the reg DATA_COUNT
    end
  end

endmodule
