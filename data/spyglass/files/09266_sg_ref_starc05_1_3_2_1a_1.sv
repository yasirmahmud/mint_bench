module gated_reset_ex1 (CLK, RESET, IN1, IN2, OUT);
 input CLK, RESET, IN1, IN2;
 output OUT;
 reg OUT;
 wire intRST;
 assign intRST = RESET & IN2;
 always @(posedge CLK or negedge intRST) begin if (!intRST) OUT = 1'b0;
 else OUT = IN1;
 end endmodule
