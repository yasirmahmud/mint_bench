typedef enum {STATE_IDLE, STATE_RUN, STATE_STOP} state_t;
module EnumTypeUsedWithRange_ex2 (
    input state_t current_state,
    output logic [1:0] output_val
);

 always_comb begin 
    // Explicitly cast the enum to a sized logic type before bit-selection.
    // The original code implies current_state[0] is a single bit, 
    // and output_val[1] is left undriven (X in simulation).
    // This corrected assignment maintains that behavior for output_val[1].
    output_val = ((logic [1:0])current_state)[0];
 end 
endmodule
