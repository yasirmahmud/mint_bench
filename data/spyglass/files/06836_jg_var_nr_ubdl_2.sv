module var_nr_ubdl_ex2 (
  input clk,
  input reset,
  input data_in,
  output reg data_out
);

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      data_out <= 1'b0;
    end else begin
      data_out <= next_data;
    end
  end

  reg next_data;

endmodule
