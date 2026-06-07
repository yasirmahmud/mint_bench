module fsm_no_default_ex2 (input clk, input rst_n, input start_i);
 parameter IDLE = 1'b0;
 parameter S1 = 1'b1;
 reg current_state;
 reg next_state;
 always @(posedge clk or negedge rst_n) begin if (!rst_n) current_state <= IDLE;
 else current_state <= next_state;
 end always @(*) begin next_state = current_state;
 case (current_state) IDLE: begin if (start_i) next_state = S1;
 else next_state = IDLE;
 end S1: begin next_state = IDLE;
 end endcase endmodule
