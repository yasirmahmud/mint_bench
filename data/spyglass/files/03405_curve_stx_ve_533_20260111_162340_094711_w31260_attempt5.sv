module curve_stx_ve_533_20260111_162340_094711_w31260_attempt5 (
  input wire clk,
  input wire rst_n,
  input wire [7:0] data_in,
  output reg [7:0] data_out
);

  // Helper parameters to build a more complex expression, similar to context examples.
  parameter P_INPUT_WIDTH = 8;
  parameter P_COEFF_LENGTH = 32;
  parameter P_DECIMATION_FACTOR = 4;

  // This parameter declaration uses an undefined macro 'DIV' within an expression.
  // This is designed to trigger exactly one STX_VE_533 violation.
  // The error will occur because `DIV` is not defined by Verilog-2001.
  parameter P_OUTPUT_WIDTH = P_INPUT_WIDTH + $clog2(P_COEFF_LENGTH) + `DIV(P_COEFF_LENGTH, P_DECIMATION_FACTOR);

  // Minimal logic to use ports and avoid other warnings/rules.
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_out <= 8'h00;
    end else begin
      data_out <= data_in;
    end
  end

endmodule
