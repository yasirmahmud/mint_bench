module fsm_no_exit_ex2(input clk, input rst, input start_i);
 parameter STATE_IDLE = 2'b00, STATE_RUN = 2'b01, STATE_TRAP = 2'b10;
 reg [1:0] current_state;
 always @(posedge clk or posedge rst) begin if (rst) begin current_state <= STATE_IDLE;
 end else begin case (current_state) STATE_IDLE: begin if (start_i) current_state <= STATE_RUN;
 else current_state <= STATE_IDLE;
 end STATE_RUN: begin current_state <= STATE_TRAP;
 end STATE_TRAP: begin current_state <= STATE_TRAP;
 end default: current_state <= STATE_IDLE;
 endcase end end endmodule
