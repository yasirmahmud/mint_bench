typedef reg [7:0] my_byte_t;
 typedef reg [7:0] another_byte_t;
 module DifferentTypedefUsed_ex2;
 my_byte_t a;
 another_byte_t b;
 my_byte_t c;
 always @* begin c = a + b;
 end endmodule
