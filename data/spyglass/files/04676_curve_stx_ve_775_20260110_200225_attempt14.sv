module curve_stx_ve_775_20260110_200225_attempt14 (
  input wire clk,
  input wire rst_n,
  output reg [7:0] count1,
  output reg [7:0] count2
);

  // STX_VE_775: Initial statement not allowed in this scope
  // 'initial' blocks are top-level procedural blocks and cannot be nested
  // within other procedural blocks like 'always' blocks in Verilog-2001.
  // This placement is a direct violation of this rule.

  // Violation 1 (Expected Occurrence 1 of 2):
  // An 'initial' block illegally placed inside an 'always' block's scope.
  always @(posedge clk) begin
    if (!rst_n) begin
      count1 <= 8'b0;
    end else begin
      initial begin // This line is expected to trigger STX_VE_775
        $display("STX_VE_775: Illegal initial block 1 inside always block.");
      end
      count1 <= count1 + 1;
    end
  end

  // Violation 2 (Expected Occurrence 2 of 2):
  // Another 'initial' block illegally placed inside a separate 'always' block's scope.
  always @(posedge clk) begin
    if (!rst_n) begin
      count2 <= 8'b0;
    end else begin
      initial begin // This line is expected to trigger STX_VE_775
        $display("STX_VE_775: Illegal initial block 2 inside always block.");
      end
      count2 <= count2 + 1;
    end
  end

endmodule
