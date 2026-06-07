module sgmii_fifo
#(
    parameter DEPTH = 16,
    parameter DATA_WIDTH = 9
)
(
    input rst_in,
    input clk_in,
    input clk_out,

    input [DATA_WIDTH-1:0] fifo_in,
    input push,
    output full,

    output [DATA_WIDTH-1:0] fifo_out,
    input pop,
    output empty
);

    localparam ADDR_WIDTH = $clog2(DEPTH); // bits for address index

    // FIFO RAM
    reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];

    // --- Write-side (clk_in domain) ---
    reg [ADDR_WIDTH:0] wptr_bin;    // Binary write pointer (size ADDR_WIDTH+1 for full/empty detection)
    reg [ADDR_WIDTH:0] wptr_gray;   // Gray-code write pointer
    wire w_full; // Full signal in write domain

    // Synchronized read pointer from clk_out domain
    reg [ADDR_WIDTH:0] rptr_gray_sync0_in, rptr_gray_sync1_in; // 2-flop synchronizer
    wire [ADDR_WIDTH:0] rptr_gray_sync_in;

    // --- Read-side (clk_out domain) ---
    reg [ADDR_WIDTH:0] rptr_bin;    // Binary read pointer
    reg [ADDR_WIDTH:0] rptr_gray;   // Gray-code read pointer
    wire r_empty; // Empty signal in read domain
    reg [DATA_WIDTH-1:0] fifo_data_out_reg; // Output register

    // Synchronized write pointer from clk_in domain
    reg [ADDR_WIDTH:0] wptr_gray_sync0_out, wptr_gray_sync1_out; // 2-flop synchronizer
    wire [ADDR_WIDTH:0] wptr_gray_sync_out;

    // --- Gray Code Conversions ---
    // Binary to Gray
    function [ADDR_WIDTH:0] bin_to_gray_func;
        input [ADDR_WIDTH:0] bin_val;
        bin_to_gray_func = (bin_val >> 1) ^ bin_val;
    endfunction

    // --- Write-side logic (clk_in domain) ---
    always @(posedge clk_in or posedge rst_in) begin
        if (rst_in) begin
            wptr_bin <= {(ADDR_WIDTH+1){1'b0}};
            wptr_gray <= {(ADDR_WIDTH+1){1'b0}};
        end else begin
            if (push && !w_full) begin
                mem[wptr_bin[ADDR_WIDTH-1:0]] <= fifo_in; // Write data
                wptr_bin <= wptr_bin + 1;
                wptr_gray <= bin_to_gray_func(wptr_bin + 1);
            end
        end
    end

    // Full logic in write domain
    assign w_full = (wptr_gray == ({ ~rptr_gray_sync_in[ADDR_WIDTH], ~rptr_gray_sync_in[ADDR_WIDTH-1], rptr_gray_sync_in[ADDR_WIDTH-2:0] }));


    // --- Read-side logic (clk_out domain) ---
    always @(posedge clk_out or posedge rst_in) begin
        if (rst_in) begin
            rptr_bin <= {(ADDR_WIDTH+1){1'b0}};
            rptr_gray <= {(ADDR_WIDTH+1){1'b0}};
            fifo_data_out_reg <= {DATA_WIDTH{1'b0}};
        end else begin
            if (pop && !r_empty) begin
                rptr_bin <= rptr_bin + 1;
                rptr_gray <= bin_to_gray_func(rptr_bin + 1);
                fifo_data_out_reg <= mem[rptr_bin[ADDR_WIDTH-1:0]]; // Read data
            end
        end
    end

    // Empty logic in read domain
    assign r_empty = (wptr_gray_sync_out == rptr_gray);
    assign fifo_out = fifo_data_out_reg;

    // --- Pointer Synchronization ---
    // Synchronize rptr_gray from clk_out to clk_in
    always @(posedge clk_in or posedge rst_in) begin
        if (rst_in) begin
            rptr_gray_sync0_in <= {(ADDR_WIDTH+1){1'b0}};
            rptr_gray_sync1_in <= {(ADDR_WIDTH+1){1'b0}};
        end else begin
            rptr_gray_sync0_in <= rptr_gray;
            rptr_gray_sync1_in <= rptr_gray_sync0_in;
        end
    end
    assign rptr_gray_sync_in = rptr_gray_sync1_in;

    // Synchronize wptr_gray from clk_in to clk_out
    always @(posedge clk_out or posedge rst_in) begin
        if (rst_in) begin
            wptr_gray_sync0_out <= {(ADDR_WIDTH+1){1'b0}};
            wptr_gray_sync1_out <= {(ADDR_WIDTH+1){1'b0}};
        end else begin
            wptr_gray_sync0_out <= wptr_gray;
            wptr_gray_sync1_out <= wptr_gray_sync0_out;
        end
    end
    assign wptr_gray_sync_out = wptr_gray_sync1_out;

    // Output assignments
    assign full = w_full;
    assign empty = r_empty;

endmodule
