module unused_input_port_ex1 (input wire unused_in, input wire a, output reg z);
 always @(*) begin z = a;
 end endmodule
