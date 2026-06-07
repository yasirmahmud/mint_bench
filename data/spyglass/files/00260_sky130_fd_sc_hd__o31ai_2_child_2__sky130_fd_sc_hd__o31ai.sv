module sky130_fd_sc_hd__o31ai (
    output Y,
    input A1,
    input A2,
    input A3,
    input B1,
    input VPWR,
    input VGND,
    input VPB,
    input VNB
);
    // Functional behavior as described: Y = !((A1 | A2 | A3) & B1)
    assign Y = ~((A1 | A2 | A3) & B1);

    // Dummy read for power/ground/well pins to resolve W240 linting violations.
    // These pins are essential for physical design but do not participate in logical computation.
    wire _unused_power_pins = VPWR & VGND & VPB & VNB;

endmodule
