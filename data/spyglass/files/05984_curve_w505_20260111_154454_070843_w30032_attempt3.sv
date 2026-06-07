module curve_w505_20260111_154454_070843_w30032_attempt3 (
    input wire clk,
    input wire reset_n,
    input wire select_b,
    input wire [7:0] data_in_b,
    input wire [7:0] data_in_nb,
    output reg [7:0] P3
);

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        P3 <= 8'h00; // Non-blocking assignment for reset
    end else begin
        if (select_b) begin
            P3 = data_in_b; // Blocking assignment
        end else begin
            P3 <= data_in_nb; // Non-blocking assignment
        end
    end
end

endmodule
