module my_module_2 (
  input clk,
  input rst_n,
  output data_out
);

  input rst_n; // 'rst_n' is declared before 'clk' here, but 'clk' was before 'rst_n' in the port list
  input clk;
  output data_out;

  reg data_reg;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_reg <= 1'b0;
    end else begin
      data_reg <= ~data_reg;
    end
  end

  assign data_out = data_reg;

endmodule
