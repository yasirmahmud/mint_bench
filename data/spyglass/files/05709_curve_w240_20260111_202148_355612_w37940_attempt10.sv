module curve_w240_20260111_202148_355612_w37940_attempt10 (
    input wire clk,
    input wire [7:0] data_in,
    input wire enable_flag, // This input is declared but not read
    output reg [7:0] data_out
);

    // 'enable_flag' is declared but never read, triggering the W240 violation.
    // 'clk' and 'data_in' are used to drive 'data_out' to avoid other unused signal warnings.
    always @(posedge clk) begin
        data_out <= data_in;
    end

endmodule
