module force_release_example_2 (
  input wire clk,
  input wire rst,
  output reg data_out
);

  initial begin
    #5 force data_out = 1'b0;
    #10 release data_out;
  end

endmodule
