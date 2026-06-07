module m_layer_input_1 (
    input clk,
    input rst,
    input [7:0] d_in,
    input wr_en,
    input rd_en,
    input [9:0] wr_addr,
    output [9:0] rd_addr,
    output [7:0] d_out,
    output layer_1_write_complete, // Keep this name, Top module will disambiguate
    output layer_2_relu_begin
);
    // To resolve WarnAnalyzeBBox and W240 (input not read)
    reg [9:0] rd_addr_r;
    reg [7:0] d_out_r;
    reg layer_1_write_complete_r;
    reg layer_2_relu_begin_r;
    reg [7:0] d_in_r;
    reg wr_en_r;
    reg rd_en_r;
    reg [9:0] wr_addr_r;

    // Simple memory model (for linting only, not functional RAM)
    reg [7:0] mem [0:1023]; // 1024 depth, 8-bit wide
    reg [9:0] current_read_addr;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            rd_addr_r <= 10'b0;
            d_out_r <= 8'b0;
            layer_1_write_complete_r <= 1'b0;
            layer_2_relu_begin_r <= 1'b0;
            current_read_addr <= 10'b0;
            // Initialize memory to avoid X propagation warnings in some tools
            for (integer i = 0; i < 1024; i = i + 1) mem[i] <= 8'b0;
        end else begin
            d_in_r <= d_in; // Read input
            wr_en_r <= wr_en; // Read input
            rd_en_r <= rd_en; // Read input
            wr_addr_r <= wr_addr; // Read input

            // Write logic
            if (wr_en_r) begin
                mem[wr_addr_r] <= d_in_r;
                // Dummy completion for mem when last address is written
                layer_1_write_complete_r <= (wr_addr_r == 10'd1023) ? 1'b1 : 1'b0;
            end else begin
                layer_1_write_complete_r <= 1'b0;
            end

            // Read logic
            if (rd_en_r) begin
                d_out_r <= mem[current_read_addr];
                rd_addr_r <= current_read_addr;
                current_read_addr <= current_read_addr + 1;
            end else begin
                d_out_r <= 8'b0;
                rd_addr_r <= current_read_addr; // Assign current addr when not reading to read it
            end

            // Dummy logic for layer_2_relu_begin: trigger when writes complete
            if (layer_1_write_complete_r) begin
                layer_2_relu_begin_r <= 1'b1; // Signal start of ReLU stage
                current_read_addr <= 10'b0; // Reset read address for next stage
            end else if (rd_en_r && current_read_addr == 10'd1023) begin
                // De-assert when all data has been read by max_relu_2
                layer_2_relu_begin_r <= 1'b0;
            end
        end
    end
    assign rd_addr = rd_addr_r;
    assign d_out = d_out_r;
    assign layer_1_write_complete = layer_1_write_complete_r;
    assign layer_2_relu_begin = layer_2_relu_begin_r;
endmodule
