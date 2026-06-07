module different_typedef_ex1 (
    output wire [7:0] result_o
);
 typedef wire [7:0] my_byte_t;
 typedef wire [7:0] another_byte_t;

 my_byte_t data1;
 another_byte_t data2;

 assign data1 = 8'hAA;
 assign data2 = 8'h55;
 assign result_o = data1 + data2;

endmodule
