module enum_method_ex2;
 typedef enum {STATE_A, STATE_B, STATE_C} my_state_t;
 my_state_t current_state;
 my_state_t next_state;
 initial begin current_state = STATE_A;
 next_state = current_state.next(1);
 end endmodule
