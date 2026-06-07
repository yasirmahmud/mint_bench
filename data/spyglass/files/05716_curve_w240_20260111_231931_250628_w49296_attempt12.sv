module curve_w240_20260111_231931_250628_w49296_attempt12 (
    input wire clk,
    input wire reset_async, // This input is declared but not read, triggering W240
    input wire [7:0] data_in,
    output reg [7:0] data_out
);

    // Trivial sequential logic that uses clk and data_in/data_out
    always @(posedge clk) begin
        // The 'reset_async' input is intentionally not used to trigger W240.
        data_out <= data_in;
    end

endmodule
