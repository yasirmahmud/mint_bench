module ff_s (
    output out,
    input din,
    input clk
);
    reg out;

    always @(posedge clk) begin
        out <= din;
    end
endmodule
