module multiple_drivers_ex1(input a, input b, output out);
wire my_net;
assign my_net = a;
assign my_net = b;
assign out = my_net;
endmodule
