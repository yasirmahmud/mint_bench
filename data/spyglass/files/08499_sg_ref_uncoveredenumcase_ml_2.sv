module uncovered_enum_case_ex2;
 typedef enum {STATE_IDLE, STATE_RUN, STATE_DONE} state_t;
 reg [0:0] output_reg;
 state_t current_state;
 initial current_state = STATE_IDLE;
 always @(*) begin case (current_state) STATE_IDLE: output_reg = 1'b0;
 STATE_DONE: output_reg = 1'b1;
 endcase end endmodule
