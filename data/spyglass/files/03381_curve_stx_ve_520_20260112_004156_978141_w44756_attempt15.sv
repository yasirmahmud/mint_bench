module curve_stx_ve_520_20260112_004156_978141_w44756_attempt15 (
  input wire clk,
  input wire rst_n,
  output reg unused_out
);

  // STX_VE_520 occurrence #1: An unterminated string literal within a parameter declaration.
  // This declaration is expected to cause a FATAL syntax error due to the missing closing quote.
  parameter P_ERROR_STRING = "This is the first string, intentionally left unterminated in a parameter;

  // A valid parameter declaration to help the parser recover.
  parameter P_VALID_STRING = "Valid string";

  // STX_VE_520 occurrence #2: A second unterminated string literal, this time within a localparam declaration.
  // This provides a distinct context from a global parameter declaration.
  localparam LP_ERROR_STRING = "This is the second string, also missing its closing quote in a localparam;

  // A valid localparam declaration for recovery.
  localparam LP_VALID_VALUE = 8'd42;

  // Minimal sequential logic to prevent 'unused signal' warnings for module ports.
  // The parameters/localparams with unterminated strings are not directly used here
  // because their parsing would fail, but their presence is what triggers the rule.
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      unused_out <= 1'b0;
    end else begin
      // Simple assignment using valid params to avoid other linting issues.
      unused_out <= (P_VALID_STRING[0] == 1'b1) ^ (LP_VALID_VALUE[0] == 1'b0);
    end
  end

endmodule
