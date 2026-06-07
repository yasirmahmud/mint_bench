module curve_w442b_20260111_180047_057014_w37940_attempt9 (
    input clk,
    input rst,
    input data_in,
    output reg q_out
);

    // W442b violation: In an asynchronous reset/set always block, comparison is being made to a non-constant expression (data_in)
    always @(posedge clk or posedge rst) begin
        if (rst == data_in) begin // Violation occurs here: 'rst' compared to non-constant 'data_in'
            q_out <= 1'b0;
        end else begin
            q_out <= data_in;
        end
    end

endmodule
