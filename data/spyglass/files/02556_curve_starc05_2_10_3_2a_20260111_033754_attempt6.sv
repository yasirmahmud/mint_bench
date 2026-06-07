module curve_starc05_2_10_3_2a_20260111_033754_attempt6 (
  input wire clk,
  input wire rst_n,
  input wire en_bit,         // 1-bit operand for &&
  input wire [4:0] data_val, // 5-bit operand for &&
  output reg result_reg
);

  // This module aims to trigger STARC05-2.10.3.2a: Operand bit-width mismatch for operator '&&'.
  // The 'en_bit' signal has a width of 1 bit.
  // The 'data_val' signal has a width of 5 bits.
  // When used together with the logical AND ('&&') operator, this should cause a bit-width mismatch violation.

  // This example uses a sequential always block to make it distinct from previous attempts
  // which used combinational always blocks or assign statements. All signals are explicitly declared.

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      result_reg <= 1'b0; // Reset condition
    end else begin
      // STARC05-2.10.3.2a violation: 'en_bit' (1 bit) && 'data_val' (5 bits).
      // The logical AND operator is used with operands of different bit-widths.
      result_reg <= en_bit && data_val;
    end
  end

endmodule
