module curve_synth_5188_20260111_214913_690404_w49296_attempt16 (
    input wire clk,
    input wire rst_n,
    input wire [3:0] data_in,
    output reg [3:0] data_out
);

// This asynchronous always block has an event control statement
// on the RHS of an assignment, triggering SYNTH_5188.
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        data_out <= 4'b0;
    end else begin
        // SYNTH_5188 violation: Invalid placement of event control statement
        // inside an asynchronous implicit style always block.
        data_out <= @(posedge clk) data_in;
    end
end

endmodule
