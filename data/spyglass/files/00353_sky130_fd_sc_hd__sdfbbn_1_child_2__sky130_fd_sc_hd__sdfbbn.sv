module sky130_fd_sc_hd__sdfbbn (
    Q,
    Q_N,
    D,
    SCD,
    SCE,
    CLK_N,
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
    input  CLK_N;
    input  SET_B;
    input  RESET_B;
    input  VPWR;
    input  VGND;
    input  VPB;
    input  VNB;

    // Internal registers for the flip-flop outputs
    reg Q_reg;

    // Functional behavior for a scan-enabled D-flip-flop:
    // - Negative-edge triggered (posedge CLK_N means falling edge of true clock)
    // - Asynchronous active-low reset (RESET_B)
    // - Asynchronous active-low set (SET_B)
    // - Active-high scan enable (SCE)
    // - Active-high data inputs (D, SCD)
    always @(posedge CLK_N or negedge RESET_B or negedge SET_B) begin
        if (!RESET_B) begin // Active-low asynchronous reset takes precedence
            Q_reg <= 1'b0;
        end else if (!SET_B) begin // Active-low asynchronous set takes precedence over clock
            Q_reg <= 1'b1;
        end else begin // Clock edge (posedge CLK_N implies negative edge of actual clock)
            if (SCE) begin // Scan Enable is active (high)
                Q_reg <= SCD;
            end else begin // Normal mode
                Q_reg <= D;
            end
        end
    end

    // Assign outputs: Q_N is the inverted output of Q
    assign Q = Q_reg;
    assign Q_N = ~Q_reg;

    // VPWR, VGND, VPB, VNB are power/ground/substrate pins.
    // They are declared as inputs but are not involved in the logical behavior of the cell.
    // Linting tools may flag them as 'declared but not read', which is expected for these pins.

endmodule
