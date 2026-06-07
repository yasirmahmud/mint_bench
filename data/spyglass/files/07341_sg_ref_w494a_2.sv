module unused_input_port_ex2 (input wire unused_in, input wire used_in, output reg out_reg);
 always @(*) begin out_reg = used_in;
 end endmodule
