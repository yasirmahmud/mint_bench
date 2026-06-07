`define DATA_WIDTH 8
`define DATA_WIDTH 16 // WRN_26: Redefinition of macro DATA_WIDTH

module curve_wrn_26_20260112_013204_422440_w25608_attempt14 (
    input wire clk,
    input wire rst_n,
    output reg [`DATA_WIDTH-1:0] data_out
);

    // Using the macro avoids unused warnings. It will resolve to the last defined value.
    // In this case, `DATA_WIDTH` will be 16.
    reg [`DATA_WIDTH-1:0] internal_data;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            internal_data <= {`DATA_WIDTH{1'b0}};
            data_out <= {`DATA_WIDTH{1'b0}};
        end else begin
            internal_data <= internal_data + 1;
            data_out <= internal_data;
        end
    end

endmodule
