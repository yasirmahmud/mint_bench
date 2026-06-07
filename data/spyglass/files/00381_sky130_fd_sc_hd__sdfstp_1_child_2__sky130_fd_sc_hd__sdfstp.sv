module sky130_fd_sc_hd__sdfstp (
    output Q,
    input  CLK,
    input  D,
    input  SCD,
    input  SCE,
    input  SET_B,
    input  VPWR,
    input  VGND,
    input  VPB,
    input  VNB
);
    reg Q_reg;

    assign Q = Q_reg;

    always @(posedge CLK or negedge SET_B) begin
        if (!SET_B) begin // Asynchronous active-low set
            Q_reg <= 1'b1; // Set Q to 1
        end else begin
            if (SCE) begin
                Q_reg <= SCD; // Scan mode: load scan data
            end else begin
                Q_reg <= D;   // Normal mode: load data
            end
        end
    end

    // To resolve 'Input declared but not read' warnings for power pins,
    // these inputs are assigned to dummy wires, ensuring they are 'read'
    // without affecting the functional logic.
    wire _unused_vpwr = VPWR;
    wire _unused_vgnd = VGND;
    wire _unused_vpb = VPB;
    wire _unused_vnb = VNB;

endmodule
