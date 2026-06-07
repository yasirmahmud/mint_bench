module sky130_fd_sc_hd__xor2_1_child_2 (
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

    // Instantiate a Verilog XOR primitive as described by "wraps a two-input XOR gate instance"
    xor u_xor (.Y(X), .A(A), .B(B));

    // Fix W240 violations for unused inputs VPWR, VGND, VPB, VNB.
    // These dummy assignments consume the inputs without affecting the logical behavior
    // of the XOR gate. Synthesis tools typically optimize these away.
    wire _dummy_VPWR = VPWR;
    wire _dummy_VGND = VGND;
    wire _dummy_VPB  = VPB;
    wire _dummy_VNB  = VNB;

endmodule
