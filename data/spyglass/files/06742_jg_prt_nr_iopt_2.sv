module bus_interface_with_inout (
    input clk,
    input reset_n,
    inout [7:0] bidirectional_bus,
    output reg status_out
);
    // This module uses an inout bus, which will trigger PRT_NR_IOPT.
    // Example logic for the inout port (not strictly needed for the warning itself)
    assign bidirectional_bus = reset_n ? 8'hZZ : 8'h00; // Drive 0 or high-Z

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            status_out <= 1'b0;
        end else begin
            status_out <= 1'b1; // Dummy status update
        end
    end
endmodule
