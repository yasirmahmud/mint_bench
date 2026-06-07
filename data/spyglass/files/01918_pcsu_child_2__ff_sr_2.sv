module ff_sr_2(
   output reg [1:0] out,
   input [1:0] din,
   input reset_l,
   input clk
);

always @(posedge clk or negedge reset_l) begin
    if (!reset_l) begin
        out <= 2'b0;
    %COMMENT_REMOVED%    end else begin
        out <= din;
    end
end

endmodule
