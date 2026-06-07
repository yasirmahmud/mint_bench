module my_module_ex2();
 reg [1:0] x = 2'b01;
 initial begin unique if (x == 2'b10) $display("Condition met");
 end endmodule
