module sky130_fd_sc_hd__a311oi (
    output logic Y,
    input  A1,
    input  A2,
    input  A3,
    input  B1,
    input  C1,
    input  VPWR,
    input  VGND,
    input  VPB,
    input  VNB
);
    // Behavioral model for the A311OI cell to satisfy linting tools.
    // This defines the logical function Y = !(((A1 & A2 & A3) | B1 | C1)).
    // The actual cell behavior is external and handled during synthesis/P&R.
    always_comb begin
        Y = ~((A1 & A2 & A3) | B1 | C1);

        // Dummy usage for power/ground/bulk inputs to resolve "Input declared but not read" (W240)
        // violations without affecting the functional logic of Y.
        // This is a common workaround for linting standard cell stubs.
        if (VPWR) ;
        if (VGND) ;
        if (VPB) ;
        if (VNB) ;
    end

endmodule
