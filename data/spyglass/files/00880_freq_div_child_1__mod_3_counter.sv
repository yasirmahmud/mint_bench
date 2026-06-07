// Definition for mod_3_counter
module mod_3_counter(
    input clk, reset,
    output reg [1:0] q
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 2'b00; // Reset to 0
        end else begin
            if (q == 2'b10) begin // If count is 2 (binary 10),
                q <= 2'b00;    // reset to 0 on next clock edge
            end else begin
                q <= q + 1;    // Increment counter
            end
        end
    end
endmodule
