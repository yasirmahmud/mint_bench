module curve_synth_5263_20260112_003718_953994_w47152_attempt14 (
    input clk,
    input rst_n,
    input [7:0] data_in,
    output reg [7:0] out_reg_a,
    output reg [7:0] out_reg_b
);

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        out_reg_a <= 8'h00;
        out_reg_b <= 8'h00;
    end else begin
        // SYNTH_5263: First fork-join construct, not synthesizable
        fork
            out_reg_a <= data_in;
        join

        // SYNTH_5263: Second fork-join construct, not synthesizable
        fork
            out_reg_b <= data_in + 8'd1;
        join
    end
end

endmodule
