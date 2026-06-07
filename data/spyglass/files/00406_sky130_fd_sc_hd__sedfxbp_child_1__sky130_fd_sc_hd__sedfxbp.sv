module sky130_fd_sc_hd__sedfxbp (
    output Q,
    output Q_N,
    input CLK,
    input D,
    input DE,
    input SCD,
    input SCE,
    input VPWR,
    input VGND,
    input VPB,
    input VNB
);

    // Power inputs VPWR, VGND, VPB, VNB are typically ignored in behavioral models
    // as they are for physical implementation and power integrity.

    reg q_reg;

    // Functional behavior: "on a clock edge, selects between direct or scan data inputs"
    // DE (Data Enable / Clock Enable) is interpreted as a clock enable, a common function
    // for an 'E' input in D-flip-flops, ensuring the described behavior occurs when DE is active.
    always @(posedge CLK) begin
        if (DE) begin // Only update Q if DE is high (clock enable)
            if (SCE) begin
                q_reg <= SCD; // Select scan data
            end else begin
                q_reg <= D;   // Select direct data
            end
        end
    end

    assign Q = q_reg;
    assign Q_N = ~q_reg;

endmodule
