module stac_3_1_6_2_ex1 #(parameter DUMMY_PARAM = 1);
 output wire [3:0] data_out;
 generate for (genvar i = 0; i < 4; i = i + 1) begin : gen_inst assign data_out[i] = i[0];
 end endgenerate endmodule
