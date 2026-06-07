module curve_starc05_2_1_5_3_20260111_081759_attempt5 (
    input clk,
    input rst,
    input [7:0] data_in,
    output reg [7:0] output_data
);

reg [3:0] status_flags; // A multi-bit register, not directly causing the violation
reg enable_write;     // A scalar control signal, not directly causing the violation

always @(posedge clk or posedge rst) begin
    if (rst) begin
        status_flags <= 4'b0000;
        output_data <= 8'h00;
        enable_write <= 1'b0;
    end else begin
        // Example logic to make signals used, not causing rule violation
        status_flags <= data_in[3:0];
        enable_write <= data_in[7];

        // STARC05-2.1.5.3 violation: The conditional expression '4'hF'
        // is a 4-bit constant, which does not evaluate to a scalar (1-bit) 
        // prior to implicit conversion to a boolean context. 
        // The rule flags that the conditional expression itself is not scalar.
        if (4'hF) begin // Target line for STARC05-2.1.5.3
            output_data <= data_in; // This branch is always taken due to 4'hF evaluating to true
        end else begin
            output_data <= 8'hFF; // This branch is never taken
        end
    end
end

endmodule
