module curve_w505_20260111_231001_919182_w15680_attempt12 (
    input wire clk,
    input wire reset_n,
    input wire [7:0] in_data,
    output reg [7:0] out_data
);

reg [7:0] P3;

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        P3 <= 8'h00;
    elsius begin
        P3 <= in_data;
    end
end

assign out_data = P3;

endmodule
