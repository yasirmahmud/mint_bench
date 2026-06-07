module curve_stx_ve_573_20260111_045730_attempt12 (
    input wire clk,
    input wire reset,
    input wire enable,
    input wire data_in,
    output reg data_out
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            data_out <= 1'b0;
        end else begin
            if (enable) begin
                data_out <= data_in // Semicolon missing here
            end else begin
                data_out <= data_out;
            end
        end
    end

endmodule
