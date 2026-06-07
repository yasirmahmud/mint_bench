module fsm_star_ex2 (input clk, input rst_n, output reg out_sig);
 reg [1:0] current_state;
 parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b11;
 always @(posedge clk or negedge rst_n) begin if (!rst_n) current_state <= S0;
 else begin case (current_state) S0: current_state <= S1;
 S1: current_state <= S2;
 S2: current_state <= S0;
 default: current_state <= S0;
 endcase end end always @(*) out_sig = (current_state == S2);
 endmodule
