module curve_w224_20260111_192320_518970_w47100_attempt10 (
    input clk,
    input rst_n,
    output reg data_out
);

reg [2:0] counter;
reg flag;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        counter <= 3'd0;
        flag <= 1'b0;
        data_out <= 1'b0;
    end else begin
        counter <= counter + 3'd1;
        // W224 violation: Multi-bit expression 'counter' used where one-bit expected
        if (counter) begin 
            flag <= ~flag;
            data_out <= 1'b1;
        end else begin
            data_out <= 1'b0;
        end
    end
end

endmodule
