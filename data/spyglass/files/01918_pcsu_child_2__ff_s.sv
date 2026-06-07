module ff_s(
   output reg out,
   input din,
   input clk
);

always @(posedge clk) begin
    out <= din;
end

endmodule
