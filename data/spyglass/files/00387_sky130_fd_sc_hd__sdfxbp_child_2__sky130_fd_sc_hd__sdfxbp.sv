module sky130_fd_sc_hd__sdfxbp (
    Q   ,
    Q_N ,
    CLK ,
    D   ,
    SCD ,
    SCE ,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    output Q   ;
    output Q_N ;
    input  CLK ;
    input  D   ;
    input  SCD ;
    input  SCE ;
    input  VPWR; // Unused in logic, but part of standard cell definition
    input  VGND; // Unused in logic, but part of standard cell definition
    input  VPB ; // Unused in logic, but part of standard cell definition
    input  VNB ; // Unused in logic, but part of standard cell definition

    reg Q_reg; // Internal register for Q

    // Assign outputs from the internal register
    assign Q = Q_reg;
    assign Q_N = ~Q_reg; // Complementary output

    // Scan-enabled D flip-flop logic
    always @(posedge CLK) begin
        if (SCE) begin
            Q_reg <= SCD; // Scan mode: output follows scan data
        end else begin
            Q_reg <= D;   // Functional mode: output follows data input
        end
    end

endmodule // sky130_fd_sc_hd__sdfxbp
