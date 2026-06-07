module starc05_2_10_1_4a_ex1(input [2:0] in_data, output reg out_flag);
  // The original comparison 'in_data == 3'bxxx' would always evaluate to false
  // in synthesizable logic, as 'x' values are treated as unknown and comparisons
  // with them typically result in false. To preserve the synthesized behavior
  // (where out_flag would always be 1'b0) and resolve the STARC05-2.10.1.4a/b
  // and SYNTH_5034 violations, we explicitly set out_flag to 1'b0.
  always @(*) begin
    out_flag = 1'b0;
  end
endmodule
