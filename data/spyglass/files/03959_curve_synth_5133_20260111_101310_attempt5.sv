`default_nettype none

module curve_synth_5133_20260111_101310_attempt5 (
    input wire clk,
    input wire rst_n,
    input wire [3:0] data_in,
    input reg [3:0] target_input_port, // The input port that will be driven internally
    output wire [3:0] dummy_out
);

    // SYNTH_5133 violation: An input port is being internally driven.
    // Declaring an input port as 'reg' and then assigning to it in an 'always' block
    // makes it appear that the module is attempting to drive its own input.
    // This is distinct from previous attempts using 'assign' on an 'input wire'.
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            target_input_port <= 4'b0;
        end else begin
            // The internal drive of the input port
            target_input_port <= data_in + 1; // Example internal logic
        end
    end

    // Use other input ports and the (internally driven) target_input_port for the dummy output
    // to avoid 'unused signal' warnings (W240 for other signals, and potentially for target_input_port itself).
    assign dummy_out = target_input_port ^ data_in; // Use internally driven target_input_port

endmodule
