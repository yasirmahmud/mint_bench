module sky130_fd_sc_hd__sdfrtp (
    Q,
    CLK,
    D,
    SCD,
    SCE,
    RESET_B,
    VPWR,
    VGND,
    VPB,
    VNB
);

    output reg Q; // Q needs to be 'reg' for sequential logic
    input CLK;
    input D;
    input SCD;
    input SCE;
    input RESET_B;
    input VPWR; // Power inputs are typically not used in behavioral models
    input VGND;
    input VPB;
    input VNB;

    always @(posedge CLK or negedge RESET_B) begin
        if (!RESET_B) begin // Active-low reset
            Q <= 1'b0;
        end else begin
            if (SCE) begin // Scan enable high, select scan data
                Q <= SCD;
            end else begin // Scan enable low, select normal data
                Q <= D;
            end
        end
    end

endmodule
