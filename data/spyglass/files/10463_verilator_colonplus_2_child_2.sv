module test2;
  reg [15:0] my_reg;
  initial begin
    my_reg[8 +: 8] = 8'hFF; // Correctly uses indexed part-select [start +: width]
    $display("Time %0t: my_reg[15:8] was set to %h. Full my_reg: %h", $time, my_reg[15:8], my_reg);
  end
endmodule
