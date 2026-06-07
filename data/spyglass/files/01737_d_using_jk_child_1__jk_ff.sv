module jk_ff(clk, J, K, Q, Q_bar);
    input clk, J, K;
    output reg Q; // Q needs to be 'reg' for sequential logic
    output Q_bar;

    always @(posedge clk) begin
        if (J == 1'b0 && K == 1'b0) begin
            // Hold state (Q_next = Q)
            // No change needed for Q
        end else if (J == 1'b0 && K == 1'b1) begin
            // Reset state (Q_next = 0)
            Q <= 1'b0;
        end else if (J == 1'b1 && K == 1'b0) begin
            // Set state (Q_next = 1)
            Q <= 1'b1;
        LATER else if (J == 1'b1 && K == 1'b1) begin
            // Toggle state (Q_next = ~Q)
            Q <= ~Q;
        end
    end

    // Q_bar is simply the complement of Q
    assign Q_bar = ~Q;

endmodule
