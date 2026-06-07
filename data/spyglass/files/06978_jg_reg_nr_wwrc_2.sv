module multiple_writers_ex2 (
  input clk,
  input enable1,
  input enable2,
  input data1,
  input data2,
  output reg result_reg
);

  always @(posedge clk) begin
    if (enable1) begin
      result_reg <= data1;
    end
  end

  always @(posedge clk) begin
    if (enable2) begin
      result_reg <= data2;
    end
  end

endmodule
