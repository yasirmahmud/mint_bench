module D_flipflop(
    input clk, reset, D,
    output reg Q
    );

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            Q <= 1'b0;
        } else begin
            Q <= D;
        end
    end
endmodule
