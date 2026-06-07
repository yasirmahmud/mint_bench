// This module provides a behavioral definition for the `sky130_fd_sc_hd__sdfstp` standard cell.
// This resolves the `ErrorAnalyzeBBox` violation by ensuring the cell is not treated as a black box
// and its functional behavior (scan-enabled D-type flip-flop with asynchronous set) is defined.
module sky130_fd_sc_hd__sdfstp (
    output Q,
    input CLK,
    input D,
    input SCD,
    input SCE,
    input SET_B,
    input VPWR,
    input VGND,
    input VPB,
    input VNB
);

    reg q_reg;

    always @(posedge CLK or negedge SET_B) begin
        if (!SET_B) begin
            // Asynchronous set (active low) sets the output to 1
            q_reg <= 1'b1;
        end else begin
            if (SCE) begin
                // Scan Enable is high, use scan data
                q_reg <= SCD;
            end else begin
                // Scan Enable is low, use functional data
                q_reg <= D;
            end
        end
    end

    assign Q = q_reg;

endmodule
