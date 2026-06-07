module curve_stx_ve_775_20260110_151647_attempt1 (
  input wire clk,
  input wire rst,
  output reg out_reg
);

  // This always block defines a simple D-flip-flop with async reset.
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      out_reg <= 1'b0;
    end else begin
      out_reg <= clk; // Drive out_reg with clk for demonstration
      // STX_VE_775: Initial statement not allowed in this scope
      // An initial block is not permitted inside an always block.
      initial begin
        $display("This initial block is in an illegal scope and should trigger STX_VE_775.");
      end
    end
  end

endmodule
