module ff_s (q, d, clk);
    output q;
    input  d;
    input  clk;

    always @(posedge clk) begin
        q <= d;
    end
endmodule
