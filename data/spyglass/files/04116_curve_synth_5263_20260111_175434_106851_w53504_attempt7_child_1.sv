module curve_synth_5263_20260111_175434_106851_w53504_attempt7 (
    input wire clk,
    input wire reset,
    input wire enable_a,
    input wire enable_b,
    output reg out_a,
    output reg out_b
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        out_a <= 1'b0;
        out_b <= 1'b0;
    end else begin
        if (enable_a) begin
            out_a <= 1'b1;
        end else begin
            out_a <= 1'b0;
        end

        if (enable_b) begin
            out_b <= 1'b1;
        end else begin
            out_b <= 1'b0;
        }
    end
end

endmodule
