module my_module_ex1 (CLK, IN, OUT);
 input CLK, IN;
 output OUT;
 reg OUT;
 reg reset;
 always @ (posedge CLK) reset = IN;
 always @ (posedge CLK or posedge reset) if (reset) OUT = 1'b0;
 else OUT = ~IN;
 endmodule
