module ff_sre_21(
        output [20:0] out,
        input [20:0] din,
        input enable,
        input reset_l,
        input clk
    );
        reg [20:0] dout;
        always @(posedge clk or negedge reset_l) begin
            if (!reset_l) dout <= 21'b0;
            else if (enable) dout <= din;
        end
        assign out = dout;
    endmodule
