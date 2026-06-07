module mod_5_counter(
    input clk, reset,
    output reg [2:0] q
    );

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 3'd0;
        end else begin
            if (q == 3'd4) begin // Counts 0, 1, 2, 3, 4
                q <= 3'd0;
            end else begin
                q <= q + 3'd1;
            end
        end
    end

endmodule
