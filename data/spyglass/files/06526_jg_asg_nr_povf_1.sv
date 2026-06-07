module overflow_const_assign;
  reg [3:0] data_out;

  always @(*) begin
    data_out = 8'd200; // RHS (200) requires more than 4 bits, LHS is 4 bits.
  end
endmodule
