module curve_w505_20260111_154454_070843_w30032_attempt4 (
    input wire clk,
    input wire reset_n,
    input wire [7:0] in_data,
    output reg [7:0] P3
);

initial begin
    // Blocking assignment for initial value of P3
    P3 = 8'hAB;
end

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        // Non-blocking assignment for reset
        P3 <= 8'h00;
    end else begin
        // Non-blocking assignment for data path
        P3 <= in_data;
    end
end

endmodule
