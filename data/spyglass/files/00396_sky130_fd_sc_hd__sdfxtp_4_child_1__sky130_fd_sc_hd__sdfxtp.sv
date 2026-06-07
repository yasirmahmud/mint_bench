module sky130_fd_sc_hd__sdfxtp (
    Q   ,
    CLK ,
    D   ,
    SCD ,
    SCE ,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    output reg Q;
    input  CLK ;
    input  D   ;
    input  SCD ;
    input  SCE ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;

    // Behavioral model for a scan delay flip-flop
    // Selects D or SCD based on SCE, then registers the data on CLK's positive edge.
    always @(posedge CLK) begin
        if (SCE) begin
            Q <= SCD;
        end else begin
            Q <= D;
        end
    end

endmodule
