module curve_w505_20260111_231001_919182_w15680_attempt12 (
    input wire clk,
    input wire reset_n,
    input wire [7:0] in_data,
    input wire enable,
    output reg [7:0] out_data
);

reg [7:0] P3;
reg [7:0] internal_reg; // Used to prevent unused signal warning for P3 path

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        P3 <= 8'h00; // Non-blocking assignment during reset
        internal_reg <= 8'h00;
    end else begin
        if (enable) begin
            P3 = in_data; // Blocking assignment when enabled
        end else begin
            P3 <= in_data; // Non-blocking assignment when not enabled
        end
        internal_reg <= P3; // Use P3 to avoid unused signal warning for P3 itself
    end
end

assign out_data = P3; // Use P3 to avoid unused signal warning

endmodule
