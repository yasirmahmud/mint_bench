module fsm_sep_ex2(input clk, input reset, output reg out_reg);
 reg state_reg, next_state;
 parameter S0 = 1'b0, S1 = 1'b1;
 always @(posedge clk or posedge reset) begin if (reset) begin state_reg <= S0;
 out_reg = 1'b0;
 end else begin state_reg <= next_state;
 case(state_reg) S0: begin out_reg = 1'b1;
 next_state = S1;
 end S1: begin out_reg = 1'b0;
 next_state = S0;
 end default: begin out_reg = 1'b0;
 next_state = S0;
 end endcase end end endmodule
