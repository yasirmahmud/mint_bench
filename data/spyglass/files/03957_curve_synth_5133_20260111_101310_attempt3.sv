`default_nettype none

module curve_synth_5133_20260111_101310_attempt3 (
    input wire clk,
    input wire rst_n,
    input wire enable_signal,
    input wire data_in,
    input wire target_input_port // This is the input port targeted by SYNTH_5133
);

    // Define states for a simple FSM to use all inputs
    parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;
    reg [1:0] state_reg;

    // Sequential FSM logic to use all input ports and internal registers
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state_reg <= S0;
        end else begin
            case (state_reg)
                S0: state_reg <= enable_signal ? S1 : S0; // Reads enable_signal
                S1: state_reg <= target_input_port ? S2 : S0; // Reads target_input_port
                S2: state_reg <= data_in ? S3 : S0;          // Reads data_in
                S3: state_reg <= S0;
                default: state_reg <= S0; // Ensure full case coverage, though S0 is typical default
            endcase
        end
    end

    // This is the specific violation: continuously driving an input port.
    // The use of '1'bz' (high impedance) is a critical attempt to avoid the
    // 'multiple simultaneous drivers' (W415) violation. SpyGlass often treats
    // '1'bz' as a non-driving state, which could allow SYNTH_5133 (a warning)
    // to trigger without the more severe W415 (an error). This aligns with the
    // summary indicating only WARNINGs for SYNTH_5133.
    assign target_input_port = (state_reg == S2) ? 1'b1 : 1'bz;

endmodule
