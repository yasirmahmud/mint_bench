module afifo(
    input rst,
    input rdclk,
    input wrclk,
    input rd_en,
    input wr_en,
    output reg is_full,
    output reg is_empty,
    output reg [3:0]count, // count is now derived in wrclk domain
    input [7:0] data_in,
    output reg [7:0] data_out,
    output reg [2:0] wr_ptr, // write pointer, also output
    output reg [2:0] rd_ptr  // read pointer, also output
);
             
    parameter size = 8;
    
    reg [7:0] fifo [0:size-1];
    
    // Synchronized pointers for cross-domain comparisons
    wire [2:0] wr_sync_ptr; // wr_ptr synchronized to rdclk domain
    wire [2:0] rd_sync_ptr; // rd_ptr synchronized to wrclk domain
    
    // Instantiate synchronizers
    synchronizer sync_wr_to_rd(.clk(rdclk), .ptra(wr_ptr), .ptrb(wr_sync_ptr));
    synchronizer sync_rd_to_wr(.clk(wrclk), .ptra(rd_ptr), .ptrb(rd_sync_ptr));
    
    // Write path (wrclk domain)
    always @(posedge wrclk or posedge rst) begin
        if (rst) begin
            wr_ptr <= 0;
            is_full <= 0; // Reset full flag
            count <= 0;   // Reset count (driven in wrclk domain)
        end else begin
            // Update wr_ptr
            if (wr_en && !is_full) begin
                fifo[wr_ptr] <= data_in;
                wr_ptr <= (wr_ptr + 1) % size;
            end
            
            // Calculate count and is_full in wrclk domain based on synchronized rd_ptr
            // Count is (wr_ptr - rd_sync_ptr) considering wrap-around
            if (wr_ptr >= rd_sync_ptr) begin
                count <= wr_ptr - rd_sync_ptr; // Count in wrclk domain
            end else begin
                count <= size - rd_sync_ptr + wr_ptr; // Handle wrap-around
            end
            is_full <= (count == size); // is_full becomes '1' when count reaches size
        end
    end

    // Read path (rdclk domain)
    reg [3:0] count_rd_domain; // Internal signal for count in rdclk domain
    always @(posedge rdclk or posedge rst) begin
        if (rst) begin
            rd_ptr <= 0;
            data_out <= 8'b00000000;
            is_empty <= 1; // Initially empty
            count_rd_domain <= 0;
        end else begin
            // Update rd_ptr and data_out
            if (rd_en && !is_empty) begin
                data_out <= fifo[rd_ptr];
                rd_ptr <= (rd_ptr + 1) % size;
            end
            
            // Calculate is_empty in rdclk domain based on synchronized wr_ptr
            // Count in rdclk domain for empty check
            if (wr_sync_ptr >= rd_ptr) begin
                count_rd_domain <= wr_sync_ptr - rd_ptr;
            end else begin
                count_rd_domain <= size - rd_ptr + wr_sync_ptr;
            end
            is_empty <= (count_rd_domain == 0); // is_empty becomes '1' when count is 0
        end
    end
                
endmodule
