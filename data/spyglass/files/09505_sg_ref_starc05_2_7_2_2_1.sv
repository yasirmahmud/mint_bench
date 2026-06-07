module star_c05_2_7_2_2_ex1 (input [0:0] sel, input data_in, output reg data_out);
 always @(*) begin case (sel) 2'b10: data_out = data_in;
 default: data_out = 1'b0;
 endcase end endmodule
