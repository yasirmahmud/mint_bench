module curve_w289_20260110_205726_attempt1 (
  input wire clk,
  input wire rst_n,
  input real  in_real_value,
  output reg  out_flag
);

  real my_real_var;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      my_real_var <= 0.0;
    end else begin
      my_real_var <= in_real_value;
    end
  end

  always_comb begin
    out_flag = 1'b0;
    // W289: A real_var operand: 'my_real_var' should not be used with logical comparison operator '=='
    if (my_real_var == 10.5) begin
      out_flag = 1'b1;
    end
  end

endmodule
