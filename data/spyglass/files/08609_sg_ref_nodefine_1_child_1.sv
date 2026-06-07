`define MY_MACRO 5
module NoDefine_ex1();
 wire a;
 assign a = `MY_MACRO;
 endmodule
