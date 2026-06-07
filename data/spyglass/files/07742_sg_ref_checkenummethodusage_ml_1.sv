module enum_method_ex1;
 typedef enum {STATE_IDLE, STATE_RUN, STATE_STOP} fsm_state_t;
 fsm_state_t current_state;
 fsm_state_t next_state;
 initial begin current_state = STATE_IDLE;
 next_state = current_state.next(1);
 end endmodule
