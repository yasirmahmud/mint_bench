module curve_w240_20260111_231931_250628_w49296_attempt11 (
    input wire clk,
    input wire [1:0] unused_control_in, // This input is declared but not read, triggering W240
    input wire [7:0] data_in,
    output reg [7:0] data_out
);

    // Trivial sequential logic that uses clk and data_in
    always @(posedge clk) begin
        data_out <= data_in;
    end

endmodule
