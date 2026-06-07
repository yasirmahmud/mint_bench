module trap_fsm_ex1 (clk, rst_n);
 input clk, rst_n;
 parameter S0=2'b00, S1=2'b01, S_TRAP=2'b10;
 reg [1:0] cs, ns;
 always @ (posedge clk or negedge rst_n) if (!rst_n) cs <= S0;
 else cs <= ns;
 always @ (cs) begin case (cs) S0: ns = S1;
 S1: ns = S_TRAP;
 S_TRAP: begin end default: ns = S0;
 endcase end endmodule
