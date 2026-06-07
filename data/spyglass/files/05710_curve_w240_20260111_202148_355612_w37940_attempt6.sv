module curve_w240_20260111_202148_355612_w37940_attempt6 (
    input clk,
    input rst, // This input will trigger W240 as it is declared but not read
    input [7:0] in_data,
    output reg [7:0] out_data
);

    always @(posedge clk) begin
        // 'rst' is intentionally not used here to trigger W240
        out_data <= in_data;
    end

endmodule
