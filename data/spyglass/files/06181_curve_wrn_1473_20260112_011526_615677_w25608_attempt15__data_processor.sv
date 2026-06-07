// This submodule contains basic logic to prevent unused signal warnings, but crucially has no parameters.
module data_processor (
  input wire clk_i,
  input wire rst_n_i,
  input wire data_i,
  output wire data_o
);
  // No parameters are declared in this module.

  reg data_reg;
  always @(posedge clk_i or negedge rst_n_i) begin
    if (!rst_n_i) begin
      data_reg <= 1'b0;
    end else begin
      data_reg <= data_i;
    end
  end

  assign data_o = data_reg;

endmodule
