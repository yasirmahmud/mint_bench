module curve_synth_5263_20260112_003718_953994_w47152_attempt15 (
    input clk,
    input rst_n,
    input select,
    input [7:0] data_in_a,
    input [7:0] data_in_b,
    output reg [7:0] out_reg_x,
    output reg [7:0] out_reg_y
);

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        out_reg_x <= 8'h00;
        out_reg_y <= 8'h00;
    end else begin
        if (select) begin
            // SYNTH_5263: First non-synthesizable fork-join construct
            fork
                out_reg_x <= data_in_a;
            join
        end else begin
            // SYNTH_5263: Second non-synthesizable fork-join construct
            fork
                out_reg_y <= data_in_b;
            join
        end
    end
end

endmodule
