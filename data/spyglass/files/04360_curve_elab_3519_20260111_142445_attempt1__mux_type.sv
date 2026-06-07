// Minimal dummy module definition required for instantiation.
// This module acts as the "MUX" type referenced in the rule description.
module mux_type (
    input in,
    output out
);
    assign out = in;
endmodule
