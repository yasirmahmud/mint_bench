module jk_ff (clk, J, K, Q, Q_bar);
    input clk, J, K;
    output reg Q;
    output Q_bar;

    assign Q_bar = ~Q;

    always @(posedge clk) begin
        if (J == 0 && K == 0) begin
            // Q remains Q (hold)
        end else if (J == 0 && K == 1) begin
            Q <= 1'b0; // Reset
        end else if (J == 1 && K == 0) begin
            Q <= 1'b1; // Set
        end else if (J == 1 && K == 1) begin
            Q <= ~Q; // Toggle
        end
    end
endmodule
