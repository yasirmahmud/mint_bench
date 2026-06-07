module curve_w442b_20260112_004524_711248_w25608_attempt16 (
    input clk,
    input arst_n, // Asynchronous active-low reset signal
    input control_val_1, // Non-constant expression for comparison 1
    input control_val_2, // Non-constant expression for comparison 2
    input data_in_a, // Data for synchronous update of reg_out_a
    input data_in_b, // Data for synchronous update of reg_out_b
    output reg reg_out_a,
    output reg reg_out_b
);

    // W442b violation 1: 'arst_n' is compared to non-constant 'control_val_1'
    // in an asynchronous reset always block with negative edge reset.
    always @(posedge clk or negedge arst_n) begin
        if (arst_n == control_val_1) begin // Violation occurs here: 'arst_n' compared to non-constant 'control_val_1'
            reg_out_a <= 1'b0; // Asynchronous reset condition
        end else begin
            reg_out_a <= data_in_a; // Synchronous data path
        end
    end

    // W442b violation 2: 'arst_n' is compared to non-constant 'control_val_2'
    // in an asynchronous reset always block with negative edge reset.
    always @(posedge clk or negedge arst_n) begin
        if (arst_n == control_val_2) begin // Violation occurs here: 'arst_n' compared to non-constant 'control_val_2'
            reg_out_b <= 1'b0; // Asynchronous reset condition
        end else begin
            reg_out_b <= data_in_b; // Synchronous data path
        end
    end

endmodule
