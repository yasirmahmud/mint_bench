module curve_w505_20260111_154454_070843_w30032_attempt2 (
    input wire clk,
    input wire select_b,
    input wire [7:0] data_in_b,
    input wire [7:0] data_in_nb,
    output reg [7:0] P3
);

// P3 is assigned non-blocking in a sequential block
always @(posedge clk) begin
    P3 <= data_in_nb;
end

// P3 is assigned blocking in a combinational block
always @* begin
    if (select_b) begin
        P3 = data_in_b;
    end else begin
        P3 = ~data_in_b; // Ensures P3 is always assigned blocking within this block
    end
end

endmodule
