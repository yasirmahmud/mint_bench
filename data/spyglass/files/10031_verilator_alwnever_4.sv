module example_4;
  reg flag;
  always @* begin
    flag = 1'b1;
    #10; // This will not cause execution
  end
endmodule
