`default_nettype none

// Module defining a parameter that will be referenced
module param_source_module #(
    parameter CONST_PARAM = 8 // The parameter whose value will be referenced hierarchically
) (
    input wire clk,
    input wire [CONST_PARAM-1:0] in_data,
    output reg [CONST_PARAM-1:0] out_data
);

    // Simple sequential logic to ensure parameter and ports are used
    always @(posedge clk) begin
        out_data <= in_data;
    end

endmodule
