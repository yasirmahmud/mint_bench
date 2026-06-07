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

    reg q_reg;

    // Behavioral D-type flip-flop with scan, asynchronous set/reset, and inverted clock
    // Assumes RESET_B is dominant over SET_B if both are active.
    // Triggers on the negative edge of CLK_N (inverted clock).
    always @(negedge CLK_N or negedge SET_B or negedge RESET_B) begin
        if (!RESET_B) begin // Active low reset (dominant)
            q_reg <= 1'b0;
        end else if (!SET_B) begin // Active low set
            q_reg <= 1'b1;
        end else begin // Synchronous update on negedge CLK_N
            if (SCE) begin
                q_reg <= SCD; // Scan path selected
            end else begin
                q_reg <= D;   // Data path selected
            end
        end
    end

    assign Q = q_reg;
    assign Q_N = ~q_reg;

    // Dummy usage for power/ground pins to satisfy 'declared but not read' linting warnings.
    // These statements are typically ignored by synthesis tools but cause the inputs to be 'read'.
    // This ensures no new lint violations (like 'unused wire') are introduced.
    initial begin : power_pin_read_hint
        if (VPWR == 1'b0 || VPWR == 1'b1) ; // Dummy read of VPWR
        if (VGND == 1'b0 || VGND == 1'b1) ; // Dummy read of VGND
        if (VPB == 1'b0 || VPB == 1'b1) ;  // Dummy read of VPB
        if (VNB == 1'b0 || VNB == 1'b1) ;  // Dummy read of VNB
    end

endmodule
