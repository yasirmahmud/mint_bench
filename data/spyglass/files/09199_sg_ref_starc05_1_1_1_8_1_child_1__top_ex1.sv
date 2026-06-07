module top_ex1 (input clk);
 wire unused_b;
 sub_mod instance_name_violates (.a(clk), .b(unused_b));
 endmodule
