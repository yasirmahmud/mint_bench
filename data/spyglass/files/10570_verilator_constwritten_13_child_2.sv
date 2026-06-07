module const_write_13;
  input logic clk;
  output logic [0:0] my_bit;
  
  always_ff @(posedge clk) begin
    my_bit <= 1'b1;
  end
endmodule
