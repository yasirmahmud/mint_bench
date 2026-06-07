module simple_component (
  input wire        clk_i,
  input wire        rst_n_i,
  input wire  [3:0] data_i,
  output wire [3:0] data_o
);
  reg [3:0] data_reg;

  always @(posedge clk_i or negedge rst_n_i) begin
    if (!rst_n_i) begin
      data_reg <= 4'h0;
    end else begin
      data_reg <= data_i;
    end
  end

  assign data_o = data_reg;
endmodule
