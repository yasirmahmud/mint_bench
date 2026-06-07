module curve_synth_5263_20260110_202646_attempt6 (
    input wire clk,
    input wire enable,
    input wire data_in,
    output reg out_a,
    output reg out_b
);

always @(posedge clk) begin
    if (enable) begin
        // The fork/join construct is not synthesizable. 
        // Non-blocking assignments within a sequential always block are inherently concurrent 
        // in their evaluation for the next state, achieving the same functional behavior.
        out_a <= data_in; 
        out_b <= ~data_in; 
    end else begin
        out_a <= 1'b0;
        out_b <= 1'b0;
    }
end

endmodule
