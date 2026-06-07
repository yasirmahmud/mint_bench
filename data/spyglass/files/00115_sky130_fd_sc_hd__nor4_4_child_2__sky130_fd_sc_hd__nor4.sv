module sky130_fd_sc_hd__nor4 (
    output Y,
    input  A,
    input  B,
    input  C,
    input  D,
    input  VPWR,
    input  VGND,
    input  VPB,
    input  VNB
);
    // Implement the 4-input NOR function for the base cell
    assign Y = ~(A | B | C | D);

    // Resolve W240 violations: Power/Ground inputs (VPWR, VGND, VPB, VNB)
    // are required for physical implementation but are not logically used
    // in the 'assign' statement. Concatenate them to an unused wire
    // to satisfy the linter without affecting functional behavior.
    wire [3:0] _unused_pwr_gnd_ports = {VPWR, VGND, VPB, VNB};

endmodule
