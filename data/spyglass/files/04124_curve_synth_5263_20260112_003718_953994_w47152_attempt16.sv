module curve_synth_5263_20260112_003718_953994_w47152_attempt16 (
    input clk,
    input rst_n,
    input select_path,
    output reg out_a,
    output reg out_b
);

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        out_a <= 1'b0;
        out_b <= 1'b0;
    end else begin
        if (select_path) begin
            // SYNTH_5263: First non-synthesizable fork-join construct
            fork
                out_a <= 1'b1;
            join
        end else begin
            // SYNTH_5263: Second non-synthesizable fork-join construct
            fork
                out_b <= 1'b0;
            join
        end
    end
end

endmodule
