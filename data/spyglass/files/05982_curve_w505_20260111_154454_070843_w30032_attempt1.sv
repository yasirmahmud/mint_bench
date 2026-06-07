module curve_w505_20260111_154454_070843_w30032_attempt1 (
    input wire clk,
    input wire reset,
    input wire [7:0] data_in,
    output reg [7:0] P3
);

always @(posedge clk) begin
    if (reset) begin
        P3 <= 8'h00; // Non-blocking assignment to P3
    end else begin
        if (data_in[0]) begin
            P3 = data_in; // Blocking assignment to P3
        end else begin
            P3 <= data_in + 1; // Non-blocking assignment to P3
        end
    end
end

endmodule
