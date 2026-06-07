module curve_stx_ve_467_20260110_144504_attempt1 (
  input wire clk,
  input wire rst_n,
  input wire [7:0] data_in,
  output reg out_scalar
);

  // Declare an unpacked array of 8-bit registers
  reg [7:0] my_array [0:1];

  // Declare a single-bit scalar register
  reg scalar_reg;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      scalar_reg <= 1'b0;
      my_array[0] <= 8'h00;
      my_array[1] <= 8'h00;
    end else begin
      my_array[0] <= data_in;
      my_array[1] <= data_in + 1'b1;

      // STX_VE_467 violation: Assigning an unpacked array (my_array)
      // to a scalar register (scalar_reg). These are non-equivalent data types.
      scalar_reg <= my_array; // Violation point
    end
  end

  // Drive the output to ensure scalar_reg is used
  assign out_scalar = scalar_reg;

endmodule
