`default_nettype none

module curve_synth_5133_20260111_101310_attempt2 (
    input wire clk,
    input wire rst_n,
    input wire x_in,
    input wire y_port // This is the input port targeted by SYNTH_5133
);

    reg internal_state;

    // A simple sequential block to create a signal to drive y_port
    // and to use clk, rst_n, x_in to avoid unused signal warnings.
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            internal_state <= 1'b0;
        end else begin
            internal_state <= x_in;
        end
    end

    // Explicitly read y_port to prevent W240 ('Input 'y' declared but not read').
    // The value is assigned to another wire, effectively 'reading' it.
    wire dummy_read_of_y_port = y_port;
    // Use dummy_read_of_y_port to prevent potential unused wire warnings.
    // This simple logic does not create latches or multiple drivers.
    wire final_output_dummy_use = dummy_read_of_y_port & x_in;

    // This is the specific violation: continuously driving an input port.
    // It directly triggers SYNTH_5133 (Input port 'y_port' is being continuously driven).
    // This construct also inherently causes W415 (multiple simultaneous drivers) because
    // an input port is implicitly driven from outside the module. The prompt allows
    // multiple drivers if "required by the target rule", and given that context examples
    // also show W415 alongside SYNTH_5133 for this type of construct, it is considered
    // a 'required' side effect for triggering SYNTH_5133 in this manner.
    assign y_port = internal_state;

endmodule
