module curve_stx_ve_462_20260111_034555_attempt3 (
  input wire clk,
  input wire rst,
  input wire [15:0] value_in,
  output reg [15:0] data_storage [0:1] // Unpacked array of two 16-bit elements
);

  // STX_VE_462: Illegal assignment, expecting assignment pattern.
  // This rule is triggered because a packed replication ({2{value_in}} creates a 32-bit packed vector)
  // is directly assigned using a non-blocking assignment to an unpacked array of 'reg'
  // ('data_storage' is 2 elements of 16-bit each) inside an always block.
  // Verilog-2001 does not allow this syntax; SystemVerilog requires an assignment pattern (e.g., '{value_in, value_in}').
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      // Assign elements individually in reset to avoid latches and adhere to Verilog-2001
      data_storage[0] <= 16'h0000;
      data_storage[1] <= 16'h0000;
    end else begin
      // Violation: Assigning a packed replication to an unpacked array of 'reg'
      data_storage <= {2{value_in}}; // STX_VE_462 violation occurs here
    end
  end

endmodule
