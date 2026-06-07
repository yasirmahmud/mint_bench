module (
  input clk_i,
  input rst_ni,
  output reg data_o
);

  always @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
      data_o <= 1'b0;
    end else begin
      data_o <= clk_i; // Simple assignment to use an input
    end
  end

endmodule
