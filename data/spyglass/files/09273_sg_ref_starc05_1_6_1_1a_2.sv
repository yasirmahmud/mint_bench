module large_block_ex2 (input wire [40000:0] in1, input wire [40000:0] in2, output wire [40000:0] out);
 genvar i;
 generate for (i = 0; i <= 40000; i = i + 1) begin : gate_inst assign out[i] = in1[i] & in2[i];
 end endgenerate endmodule
