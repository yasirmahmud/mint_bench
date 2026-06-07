module curve_w505_20260111_195945_833405_w7792_attempt8 (
    input wire clk,
    input wire reset_n,
    input wire [7:0] data_in_a,
    input wire [7:0] data_in_b,
    input wire sel,
    output reg [7:0] output_reg
);

// The 'output_reg' is assigned using both non-blocking ('<=') and blocking ('=') assignments
// within the same always block, triggering W505.
always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        output_reg <= 8'h00; // Non-blocking assignment (reset logic)
    end else begin
        if (sel) begin
            output_reg = data_in_a; // Blocking assignment
        end else begin
            output_reg <= data_in_b; // Non-blocking assignment
        end
    end
end

endmodule
