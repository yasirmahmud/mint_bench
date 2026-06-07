module sky130_fd_sc_hd__sdfbbp (
    Q,
    Q_N,
    D,
    SCD,
    SCE,
    CLK,
    SET_B,
    RESET_B,
    VPWR,
    VGND,
    VPB,
    VNB
);
    output Q;
    output Q_N;
    input  D;
    input  SCD;
    input  SCE;
    input  CLK;
    input  SET_B;
    input  RESET_B;
    input  VPWR;
    input  VGND;
    input  VPB;
    input  VNB;

    reg q_reg;

    // Behavioral model for a scan-enabled D-flip-flop with active-low async set/reset
    // Reset has higher priority than Set.
    always @(posedge CLK or negedge SET_B or negedge RESET_B) begin
        if (!RESET_B) begin // Asynchronous active-low reset
            q_reg <= 1'b0;
        end else if (!SET_B) begin // Asynchronous active-low set
            q_reg <= 1'b1;
        end else begin // Synchronous behavior on clock edge
            if (SCE) begin // Scan Enable active: use scan data
                q_reg <= SCD;
            end else begin // Scan Enable inactive: use primary data
                q_reg <= D;
            end
        end
    end

    // Assign complementary outputs
    assign Q = q_reg;
    assign Q_N = ~q_reg;

endmodule
