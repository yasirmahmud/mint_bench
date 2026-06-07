module ff_sre_5(
        output [4:0] out,
        input [4:0] din,
        input enable,
        input reset_l,
        input clk
    );
        reg [4:0] dout;
        always @(posedge clk or negedge reset_l) begin
            if (!reset_l) dout <= 5'b0;
            else if (enable) dout <= din;
        end
        assign out = dout;
    endmodule
