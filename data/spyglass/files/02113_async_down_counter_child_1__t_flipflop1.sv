module t_flipflop1 (
    input t, clk, rst,
    input reset_val,
    output reg q
);
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            q <= reset_val;
        end else if (t) begin
            q <= ~q;
        end
    end
endmodule
