module curve_w240_20260111_202148_355612_w37940_attempt9 (
    input wire clk,
    input wire [7:0] data_in,
    input wire [3:0] cfg_param,
    output reg [7:0] data_out
);

    // 'cfg_param' is declared but never read, triggering W240.
    // 'clk' and 'data_in' are used to drive 'data_out' to avoid other unused signal warnings.
    always @(posedge clk) begin
        data_out <= data_in;
    end

endmodule
