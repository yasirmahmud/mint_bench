module sky130_fd_sc_hd__sdfrbp (
    Q,
    Q_N,
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
    output Q;
    output Q_N;
    input CLK;
    input D;
    input SCD;
    input SCE;
    input RESET_B;
    input VPWR;
    input VGND;
    input VPB;
    input VNB;

    reg q_reg;

    // Assign complementary outputs
    assign Q   = q_reg;
    assign Q_N = ~q_reg;

    // Sequential logic for scan delay flip-flop with active-low reset
    always @(posedge CLK or negedge RESET_B) begin
        if (!RESET_B) begin // Asynchronous active-low reset
            q_reg <= 1'b0;
        end else begin
            if (SCE) begin // Scan Enable is high, capture scan data
                q_reg <= SCD;
            end else begin // Scan Enable is low, capture normal data
                q_reg <= D;
            end
        end
    end
endmodule
