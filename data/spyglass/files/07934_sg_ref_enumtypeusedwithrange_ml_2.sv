module EnumTypeUsedWithRange_ex2;
 typedef enum {STATE_IDLE, STATE_RUN, STATE_STOP} state_t;
 state_t current_state;
 logic [1:0] output_val;
 always_comb begin output_val = current_state[0];
 end endmodule
