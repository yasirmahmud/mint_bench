module exotic_clock_ex2 (input clk_in, input rst_n, output reg gclk);
 reg [1:0] count;
 wire [1:0] count_next; // Added for STARC05 fix

 assign count_next = (count == 2'b10) ? 2'b00 : count + 1'b1; // Combinational part of counter state calculation

 always @(posedge clk_in or negedge rst_n) begin
    if (!rst_n) begin
        count <= 2'b00;
    end else begin
        count <= count_next; // Sequential update
    end
 end

 // Original: always @(posedge clk_in or negedge clk_in or negedge rst_n) begin
 // Fixed to explicitly model a level-sensitive latch and resolve bothedges, W442f, W122
 always @(rst_n or clk_in or count) begin // All signals that can change gclk's value, including the reset
    if (!rst_n) begin
        gclk <= 1'b0;
    end else begin
        if (clk_in == 1'b0 && count == 2'b10) begin
            gclk <= 1'b1;
        end else if (clk_in == 1'b1 && count == 2'b01) begin
            gclk <= 1'b0;
        end
        // Implicit else: gclk holds its value. This is a level-sensitive latch behavior.
    end
 end
endmodule
