// Definition of the base XOR2 module to resolve the black-box violation
module sky130_fd_sc_hd__xor2 (
    X   ,
    A   ,
    B   ,
    VPWR,
    VGND,
    VPB ,
    VNB
);
    output X   ;
    input  A   ;
    input  B   ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;

    // Implement XOR logic
    assign X = A ^ B;

    // Resolve W240 violations for unused power/ground inputs.
    // These inputs are necessary for physical connectivity but do not
    // directly influence the logical XOR behavior in the RTL model.
    // The assignment to an unused wire satisfies the linter without
    // altering the functional design, as synthesis tools will optimize
    // away the unused 'dummy_read' wire.
    wire dummy_read = VPWR | VGND | VPB | VNB;

endmodule
