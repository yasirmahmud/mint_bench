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
    output wire Q;
    output wire Q_N;
    input CLK;
    input D;
    input SCD;
    input SCE;
    input RESET_B;
    input VPWR;
    input VGND;
    input VPB;
    input VNB;

    reg q_int; // Internal register to hold the flip-flop state

    // Behavioral model for a scan-enabled D flip-flop with active-low reset
    always @(posedge CLK or negedge RESET_B) begin
        if (!RESET_B) begin
            q_int <= 1'b0; // Active-low asynchronous reset
        end else begin
            if (SCE) begin
                q_int <= SCD; // Scan mode: load scan data
            end else begin
                q_int <= D; // Normal mode: load data input
            end
        end
    end

    // Assign complementary outputs from the internal register
    assign Q = q_int;
    assign Q_N = ~q_int;

    // Dummy assignments to resolve 'input declared but not read' (W240) violations
    // for power/ground inputs in this behavioral model, without affecting functional logic.
    wire _unused_vpwr = VPWR;
    wire _unused_vgnd = VGND;
    wire _unused_vpb = VPB;
    wire _unused_vnb = VNB;

endmodule
