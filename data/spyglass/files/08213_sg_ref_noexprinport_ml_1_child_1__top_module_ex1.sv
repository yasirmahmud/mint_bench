module top_module_ex1 (output o_w_result);
 reg r_data;
 wire w_result;
 // Introduce an intermediate wire to avoid expression in port connection (NoExprInPort-ML)
 wire w_r_data_masked = r_data & 1'b1;
 sub_module u_inst (.i_a(w_r_data_masked), .o_b(w_result));
 // Make w_result an output to resolve 'Variable set but not read' (W528)
 assign o_w_result = w_result;
 endmodule
