module multi_dim_param_ex2 (input clk);
 parameter [7:0][3:0] MY_PARAM = 0;
 wire dummy_wire;
 assign dummy_wire = clk;
 endmodule
