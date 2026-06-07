module JK_flipflop(
    input J, K, clk, reset,
    output reg Q
    );

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            Q <= 1'b0;
        end else begin
            if (J == 1'b0 && K == 1'b0) begin
                // Q holds its value
            end else if (J == 1'b1 && K == 1'b0) begin
                Q <= 1'b1; // Set
            end else if (J == 1'b0 && K == 1'b1) begin
                Q <= 1'b0; // Reset
            } else if (J == 1'b1 && K == 1'b1) begin
                Q <= ~Q; // Toggle
            end
        end
    end
endmodule
