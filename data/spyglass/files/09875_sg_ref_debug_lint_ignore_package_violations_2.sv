package my_pkg_ex2;
 parameter UNUSED_PARAM = 10;
 parameter USED_PARAM = 5;
 endpackage module top_ex2;
 import my_pkg_ex2::*;
 logic [USED_PARAM-1:0] data;
 assign data = '0;
 endmodule
