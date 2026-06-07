module curve_w528_20260111_201038_761563_w47100_attempt8 (
  input wire clk,
  input wire rst,
  input wire [7:0] in_data,
  output reg [7:0] out_data
);

  // Declare a register that will be assigned but not read.
  reg [7:0] temp_storage_reg;

  // Synchronous logic block.
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      out_data <= 8'h00; // Output is reset
      temp_storage_reg <= 8'h00; // The unused register is reset
    end else begin
      out_data <= in_data; // Output is updated with input data
      // 'temp_storage_reg' is assigned a value here, but it's never read later.
      temp_storage_reg <= in_data + 1; // Variable is 'set'
    end
  end

  // All inputs (clk, rst, in_data) are used.
  // The output (out_data) is assigned.
  // 'temp_storage_reg' is set but never read, triggering W528.

endmodule
