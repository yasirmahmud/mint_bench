module t_flipflop1 (
    input T,
    input clk,
    input rst,
    output reg Q
);

always @(posedge clk or posedge rst) begin
    if (rst) begin
        Q <= 1'b0;
    end else begin
        if (T) begin
            Q <= ~Q;
        end
    end
end

endmodule
