module fsm_mixed_ex1 (input clk, input rst_n, input in_sig, output reg out_fsm);
 parameter S0=1'b0, S1=1'b1;
 reg current_state, next_state;
 always @(posedge clk or negedge rst_n) begin if (!rst_n) current_state <= S0;
 else current_state <= next_state;
 end always @(*) begin next_state = current_state;
 case (current_state) S0: if (in_sig) next_state = S1;
 S1: if (!in_sig) next_state = S0;
 endcase end always @(*) out_fsm = current_state;
 reg non_fsm_reg;
 always @(posedge clk) begin if (!rst_n) non_fsm_reg <= 1'b0;
 else non_fsm_reg <= in_sig;
 end endmodule
