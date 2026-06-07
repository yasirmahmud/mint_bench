module jk_ff (input clk, input J, input K, output reg Q);
    always @(posedge clk) begin
        if (J & ~K) begin // J=1, K=0 (Set)
            Q <= 1'b1;
        end else if (~J & K) begin // J=0, K=1 (Reset)
            Q <= 1'b0;
        end else if (J & K) begin // J=1, K=1 (Toggle)
            Q <= ~Q;
        end
        // else if (~J & ~K) begin // J=0, K=0 (Hold) - Q maintains its value
    end
endmodule
