module detect_non_static_case_labels_ex2(input [1:0] sel, input [1:0] val1, input [1:0] val2, output reg [1:0] out);
 always @(*) begin case (sel) 2'b00: out = 2'b00;
 val1: out = 2'b01;
 2'b10: out = 2'b10;
 default: out = 2'b11;
 endcase end endmodule
