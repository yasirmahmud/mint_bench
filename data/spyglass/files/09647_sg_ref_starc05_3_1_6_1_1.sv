module starc05_3_1_6_1_ex1;
 parameter P_WIDTH = 8;
 localparam L_ENABLE = 1;
 wire [P_WIDTH-1:0] data_in;
 wire [P_WIDTH-1:0] data_out;
 assign data_in = 'h0;
 generate if (L_ENABLE) begin assign data_out = data_in;
 end else begin assign data_out = {P_WIDTH{1'b0}};
 end endgenerate endmodule
