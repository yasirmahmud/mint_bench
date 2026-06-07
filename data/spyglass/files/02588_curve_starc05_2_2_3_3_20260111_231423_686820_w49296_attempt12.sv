module curve_starc05_2_2_3_3_20260111_231423_686820_w49296_attempt12 (
    input wire clk,
    input wire rst_n,
    input wire data_in,
    output reg output_flop
);

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        output_flop <= 1'b0;
    end else begin
        // First assignment to output_flop
        output_flop <= data_in;

        // Second assignment to output_flop within the same always block
        // This assignment is identical to the first. The intention is to trigger
        // STARC05-2.2.3.3 which looks for a flip-flop being "assigned over the same signal".
        // It is hoped that using an identical source for the assignment might differentiate
        // it from a general "multiple assignments" warning (W415a), if W415a specifically
        // looks for *conflicting* or *different* assignments. This is a speculative attempt
        // to isolate STARC05-2.2.3.3, as previous attempts consistently triggered both.
        output_flop <= data_in; 
    end
end

endmodule
