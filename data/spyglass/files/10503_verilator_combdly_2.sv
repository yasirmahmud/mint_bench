module example_02 (input clk, input rst, input [1:0] sel, input [7:0] data_in, output logic [7:0] data_out);
  always_comb begin
    data_out <= data_in;
  end
endmodule
