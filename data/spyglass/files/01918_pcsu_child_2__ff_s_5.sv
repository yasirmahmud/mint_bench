module ff_s_5(
   output reg [4:0] out,
   input [4:0] din,
   input clk
);

always @(posedge clk) begin
    out <= din;
end

endmodule
