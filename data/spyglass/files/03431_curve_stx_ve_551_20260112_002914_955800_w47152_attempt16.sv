module (
  input data_i,
  input enable_i,
  output reg result_o
);

  always @(*) begin
    if (enable_i) begin
      result_o = data_i;
    end else begin
      result_o = 1'b0;
    end
  end

endmodule
