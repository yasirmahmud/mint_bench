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
    // To suppress linting warnings for unused inputs, we assign them to dummy wires.
    wire _unused_VPWR = VPWR;
    wire _unused_VGND = VGND;
    wire _unused_VPB  = VPB;
    wire _unused_VNB  = VNB;

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
        }
    end

    assign Q = q_reg;
    assign Q_N = ~q_reg;

endmodule
