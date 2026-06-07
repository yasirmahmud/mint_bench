module jkff (
    input j, k, clk, rst, output reg q
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            q <= 1'b0; // Asynchronous reset
        end else begin
            // Synchronous behavior on posedge clk
            case ({j, k})
                2'b00: q <= q;       // No change
                2'b01: q <= 1'b0;    // Reset
                2'b10: q <= 1'b1;    // Set
                2'b11: q <= ~q;      // Toggle
            endcase
        end
    end

endmodule
