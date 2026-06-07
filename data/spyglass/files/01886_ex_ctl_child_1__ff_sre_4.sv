module ff_sre_4(
        output [3:0] out,
        input [3:0] din,
        input clk,
        input reset_l,
        input enable
    );
        reg [3:0] dout;
        always @(posedge clk or negedge reset_l) begin
            if (!reset_l) dout <= 4'b0;
            else if (enable) dout <= din;
        end
        assign out = dout;
    endmodule
