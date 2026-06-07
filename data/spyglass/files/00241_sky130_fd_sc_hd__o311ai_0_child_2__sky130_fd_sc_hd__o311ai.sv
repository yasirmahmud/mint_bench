module sky130_fd_sc_hd__o311ai (
    Y,
    A1,
    A2,
    A3,
    B1,
    C1,
    VPWR,
    VGND,
    VPB,
    VNB
);
    output Y;
    input  A1;
    input  A2;
    input  A3;
    input  B1;
    input  C1;
    input  VPWR;
    input  VGND;
    input  VPB;
    input  VNB;

    // Functional definition for O311AI cell:
    // Y = ~(((A1 | A2 | A3) & B1 & C1))
    assign Y = ~(((A1 | A2 | A3) & B1 & C1));

    // Fix for SpyGlass W240: dummy read of power pins.
    // These pins are essential for the physical cell but do not directly
    // participate in the logical 'assign' statement, causing linting tools
    // to flag them as unused. This dummy assignment makes them 'read'.
    wire _dummy_read_power_pins_sg_fix;
    assign _dummy_read_power_pins_sg_fix = VPWR & VGND & VPB & VNB;

endmodule
