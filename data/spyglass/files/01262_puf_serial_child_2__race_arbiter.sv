module race_arbiter(
    input fin1,
    input fin2,
    input arbiter_reset,
    output reg out,       // Changed to reg
    output reg bit_done  // Changed to reg
    );
    // Implemented a minimal combinational arbiter logic to consume all inputs
    always @(*) begin
        if (arbiter_reset) begin
            out = 1'b0;
            bit_done = 1'b0;
        end else begin
            // Simple logic: if fin1 or fin2 are asserted, one of them wins
            if (fin1 && !fin2) begin
                out = 1'b0;
                bit_done = 1'b1;
            end else if (fin2 && !fin1) begin
                out = 1'b1;
                bit_done = 1'b1;
            end else if (fin1 && fin2) begin
                out = 1'b0; // fin1 wins tie-breaker for this dummy logic
                bit_done = 1'b1;
            end else begin
                out = 1'b0;
                bit_done = 1'b0;
            end
        end
    end
endmodule
