module curve_stx_ve_462_20260111_034555_attempt4 (
  input wire clk,
  input wire rst,
  input wire [7:0] in_a,
  input wire [7:0] in_b,
  input wire [7:0] in_c,
  output wire dummy_out // Included to ensure all inputs/internal signals are used
);

  // Declare an unpacked array of three 8-bit registers
  reg [7:0] data_storage [0:2];

  // Assign a dummy output to avoid unused signal warnings for clk, rst, and data_storage
  assign dummy_out = data_storage[0][0];

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      // Reset each element of the unpacked array individually
      data_storage[0] <= 8'h00;
      data_storage[1] <= 8'h00;
      data_storage[2] <= 8'h00;
    end else begin
      // STX_VE_462 Violation:
      // An illegal assignment is attempted here. A packed concatenation
      // ({in_a, in_b, in_c} creating a single 24-bit packed vector) is
      // directly assigned to 'data_storage', which is an unpacked array
      // of three 8-bit registers. Verilog-2001 does not permit this direct
      // assignment from a packed value to an unpacked array without an
      // assignment pattern (SystemVerilog feature).
      data_storage <= {in_a, in_b, in_c}; // FATAL: STX_VE_462 triggers here
    end
  end

endmodule
