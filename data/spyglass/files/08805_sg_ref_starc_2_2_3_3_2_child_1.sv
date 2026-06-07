module STARC_2_2_3_3_ex2 (input clk, input d, output reg q);
  always @(posedge clk) begin
    q <= 1'b0; // The last assignment effectively determines the value of q
  end
endmodule
