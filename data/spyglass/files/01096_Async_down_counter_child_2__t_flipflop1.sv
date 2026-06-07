module t_flipflop1(
    input t,
    input clk,
    input rst,
    output reg q
    );

    always @(negedge clk or posedge rst) begin
        if (rst) begin
            q <= 1'b0;
        end else if (t) begin
            q <= ~q;
        end
    end

endmodule
