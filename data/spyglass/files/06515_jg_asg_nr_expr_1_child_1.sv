module asg_nr_expr_example_1 (
  input wire clk,
  input wire rst_n,
  input wire data_in,
  output reg data_out
);

reg temp_reg;

always @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
    data_out <= 1'b0;
    temp_reg <= 1'b0;
  end else begin
    // Violation: Assignment (temp_reg = data_in) in the if expression
    // Fixed: Changed '=' to '==' to resolve the syntax error and implement comparison.
    if (temp_reg == data_in) begin
      data_out <= 1'b1;
    end else begin
      data_out <= 1'b0;
    end
  end
end

endmodule
