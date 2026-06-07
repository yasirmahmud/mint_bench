module curve_w505_20260111_154454_070843_w30032_attempt5 (
    input wire clk,
    input wire reset_n,
    input wire [7:0] in_data,
    input wire sel,
    output reg [7:0] P3
);

// Rule W505: Variable/Signal 'P3' is being assigned in both blocking and non-blocking manner
always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        P3 <= 8'h00; // Non-blocking assignment to P3
    end else begin
        if (sel) begin
            P3 = in_data; // Blocking assignment to P3
        end else begin
            P3 <= in_data + 1; // Non-blocking assignment to P3
        end
    end
end

endmodule
