// Module that will receive a parameter override
module param_sink_module #(
    parameter SINK_WIDTH = 1 // Default width, will be overridden by hierarchical reference
) (
    input wire clk,
    input wire [SINK_WIDTH-1:0] data_in,
    output reg [SINK_WIDTH-1:0] data_out
);

    // Simple sequential logic to ensure parameter and ports are used
    always @(posedge clk) begin
        data_out <= data_in;
    end

endmodule
