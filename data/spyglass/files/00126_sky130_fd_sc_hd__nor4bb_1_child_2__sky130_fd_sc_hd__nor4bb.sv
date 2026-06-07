module sky130_fd_sc_hd__nor4bb (
    output Y,
    input  A,
    input  B,
    input  C_N,
    input  D_N,
    input  VPWR,
    input  VGND,
    input  VPB,
    input  VNB
);
    // Behavioral model for a 4-input NOR gate with two inverted inputs.
    // Y = ~(A | B | C_N | D_N)
    assign Y = ~(A | B | C_N | D_N);

    // synthesis translate_off
    // Dummy usage of power/ground inputs to satisfy linting tools.
    // These inputs are part of the standard cell interface but are not used
    // in this behavioral model's logical function. This block is ignored by synthesis.
    initial begin
        integer dummy_int; // Declare a local integer variable
        dummy_int = VPWR;  // Explicitly 'read' VPWR
        dummy_int = VGND;  // Explicitly 'read' VGND
        dummy_int = VPB;   // Explicitly 'read' VPB
        dummy_int = VNB;   // Explicitly 'read' VNB
    end
    // synthesis translate_on

endmodule
