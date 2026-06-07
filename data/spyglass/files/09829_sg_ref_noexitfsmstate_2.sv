module no_exit_fsm_ex2 (input clk, input rst);
 parameter IDLE = 1'b0, STUCK_STATE = 1'b1;
 reg state;
 always @(posedge clk or posedge rst) begin if (rst) begin state <= IDLE;
 end else begin case (state) IDLE: state <= STUCK_STATE;
 endcase end end endmodule
