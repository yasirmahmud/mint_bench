module curve_starc05_2_1_5_3_20260111_081759_attempt5 (
    input clk,
    input rst,
    input [7:0] data_in,
    output reg [7:0] output_data
);

always @(posedge clk or posedge rst) begin
    if (rst) {
        output_data <= 8'h00;
    } else {
        // STARC05-2.1.5.3 and W224 violation fixed:
        // Changed '4'hF' (multi-bit constant) to '1'b1' (scalar constant)
        // This maintains the original behavior where the 'if' condition was always true.
        if (1'b1) begin 
            output_data <= data_in;
        end else begin
            output_data <= 8'hFF; // This branch is still never taken, preserving original behavior
        end
    }
end

endmodule
