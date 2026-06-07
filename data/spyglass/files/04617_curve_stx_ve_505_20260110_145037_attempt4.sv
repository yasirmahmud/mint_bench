module curve_stx_ve_505_20260110_145037_attempt4 (
  input wire clk,
  input wire reset_n,
  output reg out_reg
);

  // This module demonstrates two STX_VE_505 violations.
  // STX_VE_505: Compiler Directive (`end_keywords) can only be specified outside a design element.

  // First occurrence: `end_keywords within an always block.
  always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
      out_reg <= 1'b0;
    end else begin
      out_reg <= ~out_reg;
      // Expected to trigger STX_VE_505 (1st occurrence)
      `end_keywords 
    end
  end

  // Second occurrence: `end_keywords within a task.
  task my_test_task;
    input wire [7:0] data_in;
    reg [7:0] internal_reg;
    begin
      internal_reg = data_in + 1;
      // Expected to trigger STX_VE_505 (2nd occurrence)
      `end_keywords 
    end
  endtask

endmodule
