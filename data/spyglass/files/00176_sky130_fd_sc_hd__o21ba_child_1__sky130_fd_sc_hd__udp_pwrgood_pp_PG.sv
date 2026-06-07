// Stub definition for 'sky130_fd_sc_hd__udp_pwrgood_pp$PG' to resolve the D (ErrorAnalyzeBBox) violation.
// This module typically represents a power-good conditioning cell in standard cell libraries.
// For linting and digital simulation purposes, it's often modeled as a simple buffer,
// assuming its 'power-good conditioning' behavior ensures data passes through when power is stable.
// The actual low-level behavior related to VPWR/VGND is handled at the transistor level or by the physical cell definition.
module sky130_fd_sc_hd__udp_pwrgood_pp$PG (
    out,
    in,
    VPWR,
    VGND
);
    output out;
    input  in;
    input  VPWR; // Power net, treated as an input for this UDP model.
    input  VGND; // Ground net, treated as an input for this UDP model.

    // Assume a pass-through behavior for digital logic simulation and linting.
    // This preserves the data flow when power is considered good.
    assign out = in;
endmodule
