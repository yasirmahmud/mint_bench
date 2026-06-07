module jk_ff (j, k, clk, reset, q);
    input j, k, clk, reset;
    output reg q;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 1'b0;
        end else begin
            case ({j, k})
                2'b00: begin // No Change
                    // q retains its value
                end
                2'b01: begin // Reset
                    q <= 1'b0;
                end
                2'b10: begin // Set
                    q <= 1'b1;
                end
                2'b11: begin // Toggle
                    q <= ~q;
                end
            endcase
        end
    end
endmodule
