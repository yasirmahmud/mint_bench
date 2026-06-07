module my_module_ex2 (input wire input_a, input wire input_b, output reg output_q);
 always @(input_a or input_b) begin output_q = input_a;
 end endmodule
