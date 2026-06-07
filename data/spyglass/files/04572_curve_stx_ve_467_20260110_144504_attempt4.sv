module curve_stx_ve_467_20260110_144504_attempt4 (
  input wire clk,
  input wire rst_n,
  input wire [15:0] data_in_a,
  input wire [15:0] data_in_b,
  output reg [7:0] result_out_a_0,
  output reg [7:0] result_out_a_1,
  output reg [7:0] result_out_b_0,
  output reg [7:0] result_out_b_1
);

  // Declare unpacked arrays of 8-bit registers, 2 elements each
  reg [7:0] my_unpacked_array_a [0:1];
  reg [7:0] my_unpacked_array_b [0:1];

  // Declare packed registers (16-bit vectors)
  reg [15:0] my_packed_register_a;
  reg [15:0] my_packed_register_b;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      my_unpacked_array_a[0] <= 8'h00;
      my_unpacked_array_a[1] <= 8'h00;
      my_unpacked_array_b[0] <= 8'h00;
      my_unpacked_array_b[1] <= 8'h00;
      my_packed_register_a <= 16'h0000;
      my_packed_register_b <= 16'h0000;
    end else begin
      // Assign input data to packed registers for usage
      my_packed_register_a <= data_in_a;
      my_packed_register_b <= data_in_b;

      // STX_VE_467 violation 1: Attempt to assign a packed register (my_packed_register_a)
      // to an unpacked array (my_unpacked_array_a). Verilog LRM states that assignment
      // to an array can only be made when both the left and right sides are arrays of the same type.
      // A packed vector is not considered an array of the same type as an unpacked array of 8-bit elements.
      my_unpacked_array_a <= my_packed_register_a;

      // STX_VE_467 violation 2: Another instance of assigning a packed register (my_packed_register_b)
      // to an unpacked array (my_unpacked_array_b), representing non-equivalent data types.
      my_unpacked_array_b <= my_packed_register_b;
    end
  end

  // Drive the outputs to ensure unpacked array elements are used and avoid unused signal warnings
  assign result_out_a_0 = my_unpacked_array_a[0];
  assign result_out_a_1 = my_unpacked_array_a[1];
  assign result_out_b_0 = my_unpacked_array_b[0];
  assign result_out_b_1 = my_unpacked_array_b[1];

endmodule
