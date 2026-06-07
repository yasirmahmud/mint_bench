module mod_3_counter(
    input clk, reset,
    output reg [1:0] q
    );

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 2'b00;
        end else begin
            if (q == 2'b10) begin
                q <= 2'b00;
            end else begin
                q <= q + 1;
            end
        end
    end
endmodule
