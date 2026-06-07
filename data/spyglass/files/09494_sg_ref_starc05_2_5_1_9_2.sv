module star_ex2 (input en, input in_data, output wire data_out, output reg out_reg);
 assign data_out = en ? in_data : 1'bz;
 always @(*) begin casez (data_out) 1'b0: out_reg = 1'b0;
 1'b1: out_reg = 1'b1;
 default: out_reg = 1'bx;
 endcase end endmodule
