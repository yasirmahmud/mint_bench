module curve_stx_ve_775_20260110_151647_attempt4 (
  input wire clk,
  input wire rst_n,
  input wire [7:0] data_in,
  output reg [7:0] data_out
);

  // A proper synchronous block to use all inputs/outputs.
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_out <= 8'h00;
    end else begin
      data_out <= data_in;
    end
  end

  // STX_VE_775: Initial statement not allowed in this scope.
  // In Verilog-2001, 'initial' blocks are explicitly forbidden inside 'specify' blocks.
  // This placement should trigger the first STX_VE_775 violation.
  specify
    (data_in => data_out) = (10, 10); // Valid specify path delay statement
    initial begin // First occurrence of STX_VE_775
      $display("STX_VE_775 Violation 1: Initial block inside specify block.");
    end
  endspecify

  // To achieve a total count of 2 violations, a second 'initial' block is placed
  // inside another 'specify' block, which is also disallowed.
  specify
    (clk => data_out) = (5, 5); // Valid specify path delay statement
    initial begin // Second occurrence of STX_VE_775
      $display("STX_VE_775 Violation 2: Another initial block inside specify block.");
    end
  endspecify

endmodule
