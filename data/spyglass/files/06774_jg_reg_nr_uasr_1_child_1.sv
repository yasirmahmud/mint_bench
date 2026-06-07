module test_reg_unassigned_read_1 (
  input wire clk,
  input wire rst_n,
  output reg out_val
);

  reg my_unassigned_reg; // Declared, now assigned during reset

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      out_val <= 1'b0;
      my_unassigned_reg <= 1'b0; // FIX: Assign a value to my_unassigned_reg during reset
    end else begin
      out_val <= my_unassigned_reg; // my_unassigned_reg will now hold 0 after reset
    end
  end

endmodule
