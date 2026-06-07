module ff_sre_2(
        output [1:0] out,
        input [1:0] din,
        input clk,
        input enable,
        input reset_l
    );
        reg [1:0] dout;
        always @(posedge clk or negedge reset_l) begin
            if (!reset_l) dout <= 2'b0;
            else if (enable) dout <= din;
        end
        assign out = dout;
    endmodule
