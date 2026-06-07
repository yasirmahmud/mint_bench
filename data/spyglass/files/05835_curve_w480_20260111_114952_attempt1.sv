module curve_w480_20260111_114952_attempt1 (
    input clk,
    input rst_n,
    output reg [7:0] counter_out
);

    // W480 violation: Loop index 'i' is not of type integer
    reg [3:0] i; 

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            counter_out <= 8'h00;
        end else begin
            // The loop index 'i' is declared as 'reg [3:0]' instead of 'integer'
            for (i = 0; i < 10; i = i + 1) begin
                counter_out <= counter_out + 1;
            end
        end
    end

endmodule
