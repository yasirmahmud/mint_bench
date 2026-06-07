module no_exit_fsm_state_ex1 (clk, rst);
 input clk, rst;
 parameter IDLE = 2'b00, STATE_A = 2'b01, STUCK_STATE = 2'b10;
 reg [1:0] state;
 always @(posedge clk or posedge rst) begin if (rst) state <= IDLE;
 else begin case (state) IDLE: state <= STATE_A;
 STATE_A: state <= STUCK_STATE;
 endcase end end endmodule
