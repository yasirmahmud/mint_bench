// Definition for the base standard cell 'sky130_fd_sc_hd__o21a'
// The logic for an 'o21a' gate is typically (A1 | A2) & B1.
module sky130_fd_sc_hd__o21a (
    X   ,
    A1  ,
    A2  ,
    B1  ,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    output X   ;
    input  A1  ;
    input  A2  ;
    input  B1  ;
    input  VPWR; // Power supply input (for simulation models, often ignored in logic)
    input  VGND; // Ground supply input (for simulation models, often ignored in logic)
    input  VPB ; // Power bulk connection
    input  VNB ; // Ground bulk connection

    assign X = (A1 | A2) & B1;

    // Suppress W240 warnings for unused power/substrate inputs.
    // These inputs are physically part of the cell but not logically used
    // for the 'assign X = ...' statement. This statement ensures they are 'read'
    // without affecting the functional logic of output X.
    wire _unused_power_and_substrate_pins;
    assign _unused_power_and_substrate_pins = VPWR | VGND | VPB | VNB;

endmodule
