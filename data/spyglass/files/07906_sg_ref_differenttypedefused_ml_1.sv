module different_typedef_ex1;
 typedef reg [7:0] my_byte_t;
 typedef reg [7:0] another_byte_t;
 my_byte_t data1;
 another_byte_t data2;
 reg [7:0] result;
 initial begin data1 = 8'hAA;
 data2 = 8'h55;
 result = data1 + data2;
 end endmodule
