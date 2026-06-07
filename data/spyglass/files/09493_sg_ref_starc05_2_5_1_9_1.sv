module STARC05_2_5_1_9_ex1 (input sel, input data_in, output tri out_tri);
 assign out_tri = sel ? 1'bz : data_in;
 always @(*) begin casez (out_tri) 1'b0: ;
 default: ;
 endcase end endmodule
