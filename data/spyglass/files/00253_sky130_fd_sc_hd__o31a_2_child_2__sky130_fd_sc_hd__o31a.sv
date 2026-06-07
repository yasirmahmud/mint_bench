module sky130_fd_sc_hd__o31a (
    X   ,
    A1  ,
    A2  ,
    A3  ,
    B1  ,
    VPWR,
    VGND,
    VPB ,
    VNB
);
    output X   ;
    input  A1  ;
    input  A2  ;
    input  A3  ;
    input  B1  ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;

    // Behavioral model for o31a gate: (A1 | A2 | A3) & B1
    assign X = (A1 | A2 | A3) & B1;

    // Linting fix: Dummy reference to power/ground inputs to resolve 'input declared but not read' warnings (W240).
    // This statement ensures the inputs are 'read' by the linter but does not affect the functional logic
    // of the gate. Synthesis tools typically optimize away such unused wires.
    wire [3:0] _dummy_unused_power_inputs_ref = {VPWR, VGND, VPB, VNB};

endmodule
