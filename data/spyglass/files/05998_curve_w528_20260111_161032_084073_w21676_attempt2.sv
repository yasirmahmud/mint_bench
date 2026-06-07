module curve_w528_20260111_161032_084073_w21676_attempt2 (
    input clk,
    input rst_n,
    input [15:0] data_in,
    output [15:0] data_out
);

// W528 violation: Variable 'round_no_store' is set but not read.
wire [15:0] round_no_store;
assign round_no_store = data_in; // 'round_no_store' is assigned but its value is never used.

reg [15:0] data_out_reg;

assign data_out = data_out_reg;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        data_out_reg <= 16'h0;
    end else begin
        // 'data_in' is used here to avoid an unused input warning
        data_out_reg <= data_in;
    end
end

endmodule
