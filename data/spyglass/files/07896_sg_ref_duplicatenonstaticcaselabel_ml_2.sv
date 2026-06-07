module duplicate_non_static_case_label_ex2(input in1, input in2, output reg out);
 wire a = 1'b1;
 always @(*) begin unique case ({in1, in2}) inside 2'b11 : out = 1'b0;
 2'b01 : out = 1'b0;
 a : out = 1'b0;
 endcase end endmodule
