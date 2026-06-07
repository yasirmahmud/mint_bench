// Placeholder module for conv_ram to resolve BBox error.
// In a real design, this would be a separate, fully implemented RAM module.
module conv_ram (
    input clk,
    input rst,
    input wr_en,
    input rd_en,
    input [6:0] wr_addr,
    input [6:0] rd_addr,
    input [7:0] d_in,
    output wire [7:0] d_out
);
    // Simple memory model to satisfy linting and provide a connection for d_out
    reg [7:0] ram_mem [0:127]; // 7-bit address -> 2^7 = 128 locations

    always @(posedge clk) begin
        if (rst) begin
            // Optional: Add reset logic for RAM contents if required by design specifications.
            // For example: for (int i=0; i<128; i++) ram_mem[i] <= 8'h00;
        end else begin
            if (wr_en) begin
                ram_mem[wr_addr] <= d_in;
            end
        end
    end

    // Asynchronous read from the RAM.
    assign d_out = ram_mem[rd_addr];

endmodule
