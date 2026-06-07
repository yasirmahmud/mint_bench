module VerilogAttributeInfo_ML_ex1(input a, output b);
 wire a;
 output b;
 (* custom_attr = "value" *) assign b = a;
 endmodule
