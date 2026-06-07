module curve_w240_20260111_202148_355612_w37940_attempt7 (
    input clk,
    input enable_input, // This input will trigger W240 as it is declared but not read
    input [7:0] data_in,
    output reg [7:0] data_out
);

    always @(posedge clk) begin
        // 'enable_input' is intentionally not used here to trigger W240
        data_out <= data_in;
    end

endmodule
