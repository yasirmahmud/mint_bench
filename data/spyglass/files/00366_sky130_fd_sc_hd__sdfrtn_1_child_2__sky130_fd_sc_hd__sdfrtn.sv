module sky130_fd_sc_hd__sdfrtn (
    Q      ,
    CLK_N  ,
    D      ,
    SCD    ,
    SCE    ,
    RESET_B,
    VPWR   ,
    VGND   ,
    VPB    ,
    VNB
);
    output reg Q; // Q must be declared as 'reg' as it's assigned in an always block
    input  CLK_N  ;
    input  D      ;
    input  SCD    ;
    input  SCE    ;
    input  RESET_B;
    input  VPWR   ;
    input  VGND   ;
    input  VPB    ;
    input  VNB    ;

    // Behavioral model of a scan-enabled D flip-flop with:
    // - asynchronous active-low reset (RESET_B)
    // - negative-edge triggered clock (CLK_N, as it's an "inverted clock")
    // - scan functionality (SCD and SCE)
    always @(negedge CLK_N or negedge RESET_B) begin
        if (!RESET_B) begin // Asynchronous active-low reset is asserted
            Q <= 1'b0; // Reset Q to 0
        end else begin // Not in reset, clocking behavior
            if (SCE) begin // Scan Enable is high, load scan data
                Q <= SCD;
            end else begin // Scan Enable is low, load functional data
                Q <= D;
            end
        end
    end

endmodule
