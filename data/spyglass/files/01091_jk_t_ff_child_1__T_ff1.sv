// Definition of the T flip-flop module to resolve the black-box violation
module T_ff1(t, clk, rst, q, qbar);
    input t, clk, rst;
    output reg q;
    output wire qbar;

    assign qbar = ~q;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            q <= 1'b0;
        end else if (clk) begin // Ensure synchronous behavior to clock edge, after reset check
            if (t) begin
                q <= ~q;
            end
        end
    end
endmodule
