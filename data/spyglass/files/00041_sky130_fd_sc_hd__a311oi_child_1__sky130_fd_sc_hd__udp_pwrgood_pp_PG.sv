// Definition for sky130_fd_sc_hd__udp_pwrgood_pp$PG to resolve black-box error.
// This module passes its data input through, modeling the "power-good check"
// as a pass-through under normal operating conditions for linting purposes.
module sky130_fd_sc_hd__udp_pwrgood_pp$PG (
    OUT,
    IN,
    VPWR,
    VGND
);
    output OUT;
    input  IN;
    input  VPWR; // Power input (not logically used to gate data in this model)
    input  VGND; // Ground input (not logically used to gate data in this model)

    // Functional behavior: passes the input signal to the output.
    // The "power-good check" aspect is implicitly handled by the physical cell behavior,
    // not by explicit gating logic here for linting purposes.
    assign OUT = IN;

endmodule
