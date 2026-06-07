module curve_synth_5143_20260111_155009_476782_w11684_attempt1 (
    output wire my_state // Make my_state an output to resolve W528
);

// Declare an internal register to hold the state, initialized to 0.
// The direct initialization ` = 1'b0` is a synthesizable power-on default
// for registers in modern Verilog/SystemVerilog flows, resolving SYNTH_5143.
reg my_state_reg = 1'b0;

// Assign the internal register to the output port.
// This means 'my_state_reg' is now being 'read', resolving W528.
assign my_state = my_state_reg;

endmodule
