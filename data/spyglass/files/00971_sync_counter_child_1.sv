module sync_counter (
    input clk,       // Clock signal
    input reset,     // Active-high synchronous reset
    output reg [3:0] count // 4-bit output
);

    wire [3:0] next_count;

    // Combinational logic for next_count
    always @* begin
        if (reset) begin
            next_count = 4'd3; // Reset counter to 3
        end else if (count == 4'd12) begin
            next_count = 4'd3; // Reset to 3 when reaching 12
        end else begin
            next_count = count + 1; // Increment count
        end
    end

    // Sequential update of count
    always @(posedge clk) begin
        count <= next_count;
    end

endmodule
