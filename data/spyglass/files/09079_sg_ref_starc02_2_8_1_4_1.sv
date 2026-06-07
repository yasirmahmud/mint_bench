module missing_default_ex1(input [1:0] sel, input in_data, output reg out_data);
 always @(*) begin case (sel) 2'b00: out_data = in_data;
 2'b01: out_data = ~in_data;
 endcase end endmodule
