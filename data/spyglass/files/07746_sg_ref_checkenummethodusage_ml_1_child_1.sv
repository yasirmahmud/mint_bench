module enum_method_ex1 (
  output fsm_state_t next_state_out
);
 typedef enum {STATE_IDLE, STATE_RUN, STATE_STOP} fsm_state_t;
 
 // The original 'current_state' was assigned STATE_IDLE once in an initial block.
 // To make this synthesizable and remove the 'initial block ignored' warning,
 // we replace it with a localparam, which acts as a fixed constant value.
 localparam fsm_state_t current_state_val = STATE_IDLE;
 
 // The original 'next_state' was set but not read (W528).
 // To resolve this and make it synthesizable, we make it an output port
 // driven by a continuous assignment 'assign'. This also removes the need
 // for the initial block for 'next_state'.
 assign next_state_out = current_state_val.next(1);

endmodule
