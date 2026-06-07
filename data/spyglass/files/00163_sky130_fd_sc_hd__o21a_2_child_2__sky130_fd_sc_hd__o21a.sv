module sky130_fd_sc_hd__o21a (
    output X,
    input  A1,
    input  A2,
    input  B1,
    input  VPWR,
    input  VGND,
    input  VPB,
    input  VNB
);
    // Behavioral model to define the standard cell's logic.
    // X = (A1 OR A2) AND B1
    assign X = (A1 | A2) & B1;

    // Suppress unused input warnings for power/ground pins.
    // These inputs are for physical connection and do not affect the behavioral logic.
    wire _unused_power_pins = VPWR | VGND | VPB | VNB;

endmodule
