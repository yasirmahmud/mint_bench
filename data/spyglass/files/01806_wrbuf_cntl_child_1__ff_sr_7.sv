// 7-bit flip-flop with synchronous reset, matching wb_state[7:1] indices
module ff_sr_7(
    output reg [7:1] out,
    input      [7:1] din,
    input      clk,
    input      reset_l
);
always @(posedge clk or negedge reset_l) begin
    if (!reset_l)
        out <= '0; // All bits to 0
    else
        out <= din;
end
endmodule
