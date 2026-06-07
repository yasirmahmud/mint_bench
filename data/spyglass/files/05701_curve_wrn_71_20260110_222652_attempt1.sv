module curve_wrn_71_20260110_222652_attempt1 (
    input clk,
    input rst_n,
    input [7:0] unused_in, // Dummy input to avoid unused port warnings
    output [7:0] unused_out // Dummy output
);

    // Set NVDLA_MCIF_BURST_SIZE_LOG2 to a value such that (3 - NVDLA_MCIF_BURST_SIZE_LOG2) is negative.
    // If NVDLA_MCIF_BURST_SIZE_LOG2 = 4, then (3 - 4) = -1.
    // A replication count must be a non-negative integer according to Verilog LRM.
    // This negative value will trigger WRN_71, as it's an integer but not a valid non-negative one for replication.
    parameter NVDLA_MCIF_BURST_SIZE_LOG2 = 4;

    // Wire declarations for the target assignments
    wire [2:0] ftran_size_1;
    wire [2:0] ftran_size_2;

    // Reg declarations for the second part of the concatenation, with width dependent on the parameter.
    // For NVDLA_MCIF_BURST_SIZE_LOG2 = 4, these are reg [3:0]
    reg [NVDLA_MCIF_BURST_SIZE_LOG2-1:0] ftran_size_tmp_1;
    reg [NVDLA_MCIF_BURST_SIZE_LOG2-1:0] ftran_size_tmp_2;

    // Always block to drive ftran_size_tmp_1 and ftran_size_tmp_2, avoiding latches and unused reg warnings
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            ftran_size_tmp_1 <= {NVDLA_MCIF_BURST_SIZE_LOG2{1'b0}}; // Reset to all zeros
            ftran_size_tmp_2 <= {NVDLA_MCIF_BURST_SIZE_LOG2{1'b0}};
        end else begin
            // Use a portion of unused_in to drive the registers
            ftran_size_tmp_1 <= unused_in[NVDLA_MCIF_BURST_SIZE_LOG2-1:0];
            ftran_size_tmp_2 <= unused_in[NVDLA_MCIF_BURST_SIZE_LOG2-1:0] + 1; // Assign different values
        end
    end

    // First assignment: Triggers WRN_71
    // LHS (ftran_size_1) is 3 bits wide.
    // RHS concatenation: { { (3-4){1'b0} }, ftran_size_tmp_1 }
    //   - Replication count (3-4) = -1. This is the WRN_71 trigger.
    //   - Width of replicated part = -1 * 1 = -1 bit.
    //   - Width of ftran_size_tmp_1 = NVDLA_MCIF_BURST_SIZE_LOG2 = 4 bits.
    //   - Total RHS width = -1 + 4 = 3 bits. This perfectly matches LHS width (3 bits),
    //     avoiding any width mismatch warnings (e.g., STX_VE_533).
    assign ftran_size_1[2:0] = {{(3-NVDLA_MCIF_BURST_SIZE_LOG2){1'b0}}, ftran_size_tmp_1};

    // Second assignment: Triggers WRN_71 (for a total of 2 occurrences as requested by the summary)
    // Same logic as above, ensures a second violation of the same rule without introducing others.
    assign ftran_size_2[2:0] = {{(3-NVDLA_MCIF_BURST_SIZE_LOG2){1'b0}}, ftran_size_tmp_2};

    // Connect unused_out to avoid unused output port warning.
    // Concatenate with zeros and the two 3-bit signals to form an 8-bit output.
    assign unused_out = {2'b0, ftran_size_1, ftran_size_2}; // 2 + 3 + 3 = 8 bits

endmodule
