module curve_bothedges_20260111_191906_453079_w53504_attempt6 (
    input clk,
    output reg out_data
);

    // SpyGlass bothedges violation will occur here
    always @(posedge clk or negedge clk) begin
        out_data <= clk;
    end

endmodule
