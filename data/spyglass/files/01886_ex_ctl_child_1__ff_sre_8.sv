module ff_sre_8(
        output [7:0] out,
        input [7:0] din,
        input clk,
        input enable,
        input reset_l
    );
        reg [7:0] dout;
        always @(posedge clk or negedge reset_l) begin
            if (!reset_l) dout <= 8'b0;
            else if (enable) dout <= din;
        end
        assign out = dout;
    endmodule
