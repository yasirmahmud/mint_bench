module ff_sre_3(
        output [2:0] out,
        input [2:0] din,
        input clk,
        input enable,
        input reset_l
    );
        reg [2:0] dout;
        always @(posedge clk or negedge reset_l) begin
            if (!reset_l) dout <= 3'b0;
            else if (enable) dout <= din;
        end
        assign out = dout;
    endmodule
