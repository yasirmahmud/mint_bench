// Dummy module definition for pipe_reg (ErrorAnalyzeBBox fix)
// This module simulates a simple 1-stage pipeline register with valid/empty/reload signals.
module pipe_reg #(
    parameter DSIZE = 8
)(
    input clock,
    input rst_n,
    input wr_en,       // Write enable: new data available from upstream
    input [DSIZE-1:0] indata,
    input low_empty,   // Input from downstream, indicates readiness to consume data
    output reg valid,  // Output data is valid
    output reg curr_empty, // Current register is empty
    output sum_empty,  // Sum of empty registers (for a 1-stage, same as curr_empty)
    output reg [DSIZE-1:0] outdata,
    output reg high_reload // Indicates data consumed/pipe reloaded state
);
    always @(posedge clock or negedge rst_n) begin
        if (!rst_n) begin
            outdata <= {DSIZE{1'b0}};
            valid <= 1'b0;
            curr_empty <= 1'b1;
            high_reload <= 1'b1; // Initially empty/reloaded
        end else begin
            if (wr_en) begin // New data is being written
                outdata <= indata;
                valid <= 1'b1;
                curr_empty <= 1'b0;
                high_reload <= 1'b0; // Data is available, not reloaded/empty
            end else if (low_empty) begin // Downstream consumed the data (if valid) or is requesting new data
                // If no new data (wr_en low) and downstream is ready (low_empty high),
                // consider the current output consumed and the pipe empty/reloaded.
                valid <= 1'b0;
                curr_empty <= 1'b1;
                high_reload <= 1'b1;
            end
            // else: retain current state (data remains, valid, not empty if wr_en was low and low_empty was low)
        end
    end

    assign sum_empty = curr_empty;
endmodule
