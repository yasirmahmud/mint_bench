// Definition for the missing module to resolve the black-box error.
// This behavioral model for the power-good cell assumes that when power is good
// (VPWR and VGND are at correct levels), the input signal 'IN' is passed directly
// to the output 'OUT'. The VPWR and VGND ports are typically used by physical
// design tools for power integrity checks, but functionally they don't gate the
// data path in a simple behavioral model for linting/synthesis unless explicitly
// defined to do so in the cell's specification.
module sky130_fd_sc_hd__udp_pwrgood_pp$PG (
    OUT,
    IN,
    VPWR,
    VGND
);
    output OUT;
    input IN;
    input VPWR;
    input VGND;

    assign OUT = IN;

endmodule
