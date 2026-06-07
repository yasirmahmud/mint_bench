module fsm_star_ex1(input clk, input reset, output reg [1:0] out);
 parameter S0=2'b00, S1=2'b01;
 reg [1:0] cs, ns;
 always @(posedge clk or posedge reset) begin if(reset) cs <= S0;
 else cs <= ns;
 case(cs) S0: begin out=2'b00;
 ns=S1;
 end S1: begin out=2'b11;
 ns=S0;
 end default: begin out=2'b00;
 ns=S0;
 end endcase end endmodule
