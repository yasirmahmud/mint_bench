module curve_synth_77_20260111_154018_106011_w21676_attempt4 (
    input wire clk,
    input wire rst_n,
    input wire [7:0] in_data,
    input wire blocking_enable, // Control for the blocking assignment path
    output reg [7:0] out_var
);

// The 'out_var' is assigned both blocking and non-blocking within this single always block.
// This setup causes SYNTH_77 because the same variable attempts to behave
// both synchronously (via non-blocking assignments triggered by posedge clk) 
// and combinatorially (via blocking assignment triggered by blocking_enable or in_data) 
// within a single procedural block.
always @(posedge clk or negedge rst_n or blocking_enable or in_data) begin
    if (!rst_n) begin
        // Synchronous reset with non-blocking assignment
        out_var <= 8'h0;
    end else if (blocking_enable) begin
        // Conditional blocking assignment (combinational behavior)
        // This path is sensitive to blocking_enable and in_data
        out_var = in_data; 
    end else begin
        // Default sequential behavior with non-blocking assignment
        // This path is primarily sensitive to posedge clk
        out_var <= 8'hFF; 
    end
end

endmodule
