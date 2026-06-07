module ff_s(
   output out,
   input din,
   input clk
);

always @(posedge clk) begin
    out <= din;
end

endmodule
