module multiple_nba_2 (
  input clk,
  input rst_n,
  input sel,
  input data_in1,
  input data_in2,
  output logic result
);

always_ff @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
    result <= 1'b0;
  end else begin
    if (sel) begin
      result <= data_in1;
    end
    result <= data_in2;
  end
end

endmodule
