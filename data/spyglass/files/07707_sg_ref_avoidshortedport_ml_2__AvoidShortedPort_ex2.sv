module AvoidShortedPort_ex2();
 wire common_net;
 wire result;
 my_sub_module u_inst (.in1(common_net), .in2(common_net), .out(result));
 endmodule
