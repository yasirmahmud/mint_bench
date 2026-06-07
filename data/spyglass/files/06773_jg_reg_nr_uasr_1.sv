module test_reg_unassigned_read_1 (
  input wire clk,
  input wire rst_n,
  output reg out_val
);

  reg my_unassigned_reg; // Declared but never assigned

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      out_val <= 1'b0;
    end else begin
      out_val <= my_unassigned_reg; // Read here, but never assigned
    end
  end

endmodule
