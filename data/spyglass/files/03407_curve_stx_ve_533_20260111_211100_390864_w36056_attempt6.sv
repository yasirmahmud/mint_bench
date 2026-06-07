module curve_stx_ve_533_20260111_211100_390864_w36056_attempt6 (
    input clk,
    input rst_n,
    input [7:0] data_in,
    output reg [7:0] data_out
);

    parameter DATA_WIDTH = 8;
    parameter FACTOR_A = 4;
    parameter FACTOR_B = 2;

    // STX_VE_533 violation: The macro `DIV` is used but not defined.
    parameter CALC_WIDTH = DATA_WIDTH + `DIV(FACTOR_A, FACTOR_B);

    wire [CALC_WIDTH-1:0] intermediate_signal;

    // Pad data_in to CALC_WIDTH for demonstration
    assign intermediate_signal = {{(CALC_WIDTH > DATA_WIDTH ? CALC_WIDTH - DATA_WIDTH : 0){1'b0}}, data_in};

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            data_out <= {DATA_WIDTH{1'b0}};
        end else begin
            // Assign the lower DATA_WIDTH bits to data_out
            data_out <= intermediate_signal[DATA_WIDTH-1:0];
        end
    end

endmodule
