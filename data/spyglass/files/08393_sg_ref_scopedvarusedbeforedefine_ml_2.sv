interface my_interface_ex2;
 reg x;
 initial x = 1'b0;
 endinterface module my_module_ex2(input clk);
 reg a;
 always @(posedge clk) begin a <= i.x;
 end my_interface_ex2 i();
 endmodule
