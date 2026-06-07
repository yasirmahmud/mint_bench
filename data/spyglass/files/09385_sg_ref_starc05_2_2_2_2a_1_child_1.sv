module starc05_2_2_2_2a_ex1 (input a, input b, input c, output reg out);
  wire unused_c = c;

  always @(a or b) begin
    out = a & b;
  end
endmodule
