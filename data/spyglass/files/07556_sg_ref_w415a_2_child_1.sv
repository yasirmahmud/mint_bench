module W415a_example_ex2 (input clk, input in1, input in2, output reg out_sig);
  always @(posedge clk) begin
    out_sig <= in2;
  end
endmodule
