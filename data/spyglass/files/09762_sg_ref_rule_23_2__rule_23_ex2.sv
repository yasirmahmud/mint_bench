module rule_23_ex2 (input clk, data_in, output data_out);
 wire dff_q;
 DFF_AR u_dff (.D(data_in), .CLK(clk), .ARST_N(1'b0), .Q(dff_q));
 assign data_out = dff_q;
 endmodule
