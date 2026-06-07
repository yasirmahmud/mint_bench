module (
  input clk_i,
  input rst_n_i,
  input data_in,
  output reg data_out
);

  always @(posedge clk_i or negedge rst_n_i) begin
    if (!rst_n_i) begin
      data_out <= 1'b0;
    end else begin
      data_out <= ~data_in; 
    end
  end

endmodule
