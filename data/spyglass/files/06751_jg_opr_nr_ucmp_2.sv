module unequal_cmp_2;
  logic [7:0] data_in;
  logic flag;

  initial begin
    data_in = 8'hFF;
    flag = (data_in !== 4'hF); // LHS is 8 bits, RHS is 4 bits
    $display("Flag 1: %b", flag);

    data_in = 8'h0F;
    flag = (data_in !== 4'hF); // LHS is 8 bits, RHS is 4 bits
    $display("Flag 2: %b", flag);
  end
endmodule
