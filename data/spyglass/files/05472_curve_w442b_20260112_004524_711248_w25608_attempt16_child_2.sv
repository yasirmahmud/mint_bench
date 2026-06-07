module curve_w442b_20260112_004524_711248_w25608_attempt16 (
    input clk,
    input arst_n, // Asynchronous active-low reset signal

    input data_in_a, // Data for synchronous update of reg_out_a
    input data_in_b, // Data for synchronous update of reg_out_b
    output reg reg_out_a,
    output reg reg_out_b
);

    // W442b violation 1 fixed: 'arst_n' is now compared to a constant (implied 1'b0 for active-low reset).
    // The functional behavior is preserved as 'arst_n' is described as an "Asynchronous active-low reset signal".
    always @(posedge clk or negedge arst_n) begin
        if (!arst_n) begin // Fixed: 'arst_n' is now compared to a constant 1'b0
            reg_out_a <= 1'b0; // Asynchronous reset condition
        end else begin
            reg_out_a <= data_in_a; // Synchronous data path
        end
    }

    // W442b violation 2 fixed: 'arst_n' is now compared to a constant (implied 1'b0 for active-low reset).
    // The functional behavior is preserved as 'arst_n' is described as an "Asynchronous active-low reset signal".
    always @(posedge clk or negedge arst_n) begin
        if (!arst_n) begin // Fixed: 'arst_n' is now compared to a constant 1'b0
            reg_out_b <= 1'b0; // Asynchronous reset condition
        end else begin
            reg_out_b <= data_in_b; // Synchronous data path
        }
    }

endmodule
