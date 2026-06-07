`ifndef NVDLA_MEMIF_WIDTH
`define NVDLA_MEMIF_WIDTH 512
`endif
`ifndef NVDLA_MEMORY_ATOMIC_SIZE
`define NVDLA_MEMORY_ATOMIC_SIZE 64
`endif
`ifndef NVDLA_BPE
`define NVDLA_BPE 8
`endif

// Define a generic pipeline stage module that implements the ready/valid handshaking.
// This module mimics the behavior typically expected from an 'eperl::pipe' directive
// in NVDLA designs for a single-stage registered pipeline.
module NV_NVDLA_pipe_stage #(
    parameter DATA_WIDTH = 1
) (
    input                     nvdla_core_clk,
    input                     nvdla_core_rstn,
    // Upstream interface
    input  [DATA_WIDTH-1:0]   di,    // Data In
    input                     vi,    // Valid In
    output                    ro,    // Ready Out (to upstream)
    // Downstream interface
    output [DATA_WIDTH-1:0]   do,    // Data Out
    output                    vo,    // Valid Out
    input                     ri     // Ready In (from downstream)
);

    reg  [DATA_WIDTH-1:0] data_reg;
    reg                   valid_reg;

    // Ready signal to upstream:
    // We are ready to accept new data if the downstream is ready to take our current data (ri is high)
    // OR if our register is currently empty (valid_reg is low).
    // If valid_reg is high and ri is low, we are not ready.
    assign ro = ri || !valid_reg; // Correct handshaking logic for a typical pipeline stage

    assign do = data_reg;
    assign vo = valid_reg;

    always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
        if (!nvdla_core_rstn) begin
            data_reg  <= {DATA_WIDTH{1'b0}};
            valid_reg <= 1'b0;
        end else begin
            if (ro) begin // If we are ready to accept new data from upstream
                valid_reg <= vi; // Pass valid through if we accept it
                if (vi) begin // Only update data if input is valid
                    data_reg <= di;
                end
            end
        end
    end

endmodule // NV_NVDLA_pipe_stage
