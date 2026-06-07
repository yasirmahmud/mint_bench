module curve_synth_77_20260111_230740_342010_w15680_attempt11 (
    input clk,
    input rst,
    input [7:0] data_b,           // Data for blocking assignment
    input [7:0] data_nb,          // Data for non-blocking assignment
    input sel_b,                  // Selector for blocking assignment path
    input sel_nb,                 // Selector for non-blocking assignment path
    output reg [7:0] violator_reg
);

    // SYNTH_77 violation will be triggered here because 'violator_reg'
    // receives both blocking (=) and non-blocking (<=) assignments
    // within this single always block.
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            violator_reg <= 8'd0; // Non-blocking assignment for reset
        end else begin
            if (sel_b) begin
                violator_reg = data_b; // Blocking assignment
            end else if (sel_nb) begin
                violator_reg <= data_nb; // Non-blocking assignment
            end else begin
                // Default path to avoid latch inference, uses non-blocking assignment
                violator_reg <= 8'd0; 
            end
        end
    end

endmodule
