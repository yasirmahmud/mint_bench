module exotic_clock_ex2 (input clk_in, input rst_n, output reg gclk);
 reg [1:0] count;
 always @(posedge clk_in or negedge rst_n) begin
    if (!rst_n) begin
        count <= 2'b00;
    end else begin
        count <= (count == 2'b10) ? 2'b00 : count + 1'b1;
    end
 end
 always @(posedge clk_in or negedge clk_in or negedge rst_n) begin
    if (!rst_n) begin
        gclk <= 1'b0;
    end else begin
        if (clk_in == 1'b0 && count == 2'b10) begin
            gclk <= 1'b1;
        end else if (clk_in == 1'b1 && count == 2'b01) begin
            gclk <= 1'b0;
        end
    end
 end
endmodule
