module curve_w528_20260111_161032_084073_w21676_attempt1 (
    input clk,
    input rst_n,
    input [15:0] round_number_in,
    output [15:0] dummy_out
);

reg [15:0] round_no_store; // This variable is set but never read, triggering W528
reg [15:0] dummy_out_reg;

assign dummy_out = dummy_out_reg;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        round_no_store <= 16'h0;
        dummy_out_reg <= 16'h0;
    end else begin
        // W528 violation: 'round_no_store' is set here...
        round_no_store <= round_number_in;

        // ...but never read anywhere else in the module.
        // 'round_number_in' is used here to avoid an unused input warning.
        dummy_out_reg <= round_number_in + 16'h1; 
    end
end

endmodule
