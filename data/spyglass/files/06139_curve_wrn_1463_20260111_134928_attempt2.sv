module curve_wrn_1463_20260111_134928_attempt2 (
    input clk,
    input rst,
    output reg [7:0] data_out
);

always @(posedge clk or posedge rst) begin
    if (rst) begin
        data_out <= 8'h00;
    end else begin
        data_out <= data_out + 8'h01;
    end
end

// Intentionally missing 'endmodule' to trigger WRN_1463
