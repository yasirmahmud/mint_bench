module no_drive_always (
    input wire clk,
    input wire reset,
    output reg data_out
);
    wire data_in; // Declared but not driven

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            data_out <= 1'b0;
        end else begin
            data_out <= data_in; // 'data_in' is loaded but has no driver
        end
    end

endmodule
