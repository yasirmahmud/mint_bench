module my_module_ex2 (input clk, output [MY_PARAM-1:0] out_data);
 parameter MY_PARAM = 10;
 reg [MY_PARAM-1:0] internal_data;
 always @(posedge clk) begin internal_data <= MY_PARAM;
 end assign out_data = internal_data;
 endmodule
