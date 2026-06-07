module fsm_ex1 (input clk, input rst_n, input in_s, output reg out_s);
 parameter S0=1'b0, S1=1'b1;
 reg current_state, next_state;
 always @(posedge clk or negedge rst_n) begin if (!rst_n) begin current_state <= S0;
 out_s <= 1'b0;
 end else begin current_state <= next_state;
 case (current_state) S0: begin next_state = in_s ? S1 : S0;
 out_s = in_s;
 end S1: begin next_state = in_s ? S0 : S1;
 out_s = !in_s;
 end endcase end endmodule
