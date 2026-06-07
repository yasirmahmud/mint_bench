module example1 (
    input clk,
    output reg q
);

always @(posedge clk) begin : my_named_block
    q <= ~q;
end

initial begin
    #10;
    disable my_named_block; // Non-synthesizable disable
end

endmodule
