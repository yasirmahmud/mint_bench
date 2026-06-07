module sky130_fd_sc_hd__or2b (
    X   ,
    A   ,
    B_N ,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    output X   ;
    input  A   ;
    input  B_N ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;

    // Functional behavior: X = A OR (NOT B_N)
    assign X = A | ~B_N;

    // Fix for SpyGlass W240: Inputs 'VPWR', 'VGND', 'VPB', 'VNB' declared but not read.
    // In standard cell models, these signals are implicitly used by the physical
    // implementation (e.g., connecting to transistor bulks/sources/drains),
    // but not typically in a logical Verilog expression. This dummy assignment
    // ensures these inputs are 'read' by linting tools without affecting functional behavior.
    wire _sg_fix_unused_power_inputs;
    assign _sg_fix_unused_power_inputs = VPWR & VGND & VPB & VNB;

endmodule
