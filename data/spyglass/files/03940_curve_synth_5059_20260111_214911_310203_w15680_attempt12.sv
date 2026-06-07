module curve_synth_5059_20260111_214911_310203_w15680_attempt12 (
    input [5:0] data_in,
    output reg flag_out
);

// Declare a local parameter for the comparison value, including 'x' and 'z' states.
parameter [5:0] REFERENCE_VAL = 6'b10X1Z0; 

// Use an always_comb block (Verilog 2001 style: always @*)
// to perform the case inequality comparison.
always @* begin
    // Trigger SYNTH_5059: Case inequality (!==) which is not supported by synthesis.
    // The comparison involves an input signal and a parameter with 'x' and 'z' bits.
    flag_out = (data_in !== REFERENCE_VAL);
end

endmodule
