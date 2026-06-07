module curve_synth_5263_20260110_202646_attempt6 (
    input wire clk,
    input wire enable,
    input wire data_in,
    output reg out_a,
    output reg out_b
);

always @(posedge clk) begin
    if (enable) begin
        // SYNTH_5263 violation: Fork and Join constructs are not synthesizable
        fork
            out_a <= data_in; // First concurrent task
            out_b <= ~data_in; // Second concurrent task
        join
    end else begin
        out_a <= 1'b0;
        out_b <= 1'b0;
    end
end

endmodule
