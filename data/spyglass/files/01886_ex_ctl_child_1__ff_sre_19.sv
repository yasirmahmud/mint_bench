module ff_sre_19(
        output [18:0] out,
        input [18:0] din,
        input enable,
        input reset_l,
        input clk
    );
        reg [18:0] dout;
        always @(posedge clk or negedge reset_l) begin
            if (!reset_l) dout <= 19'b0;
            else if (enable) dout <= din;
        end
        assign out = dout;
    endmodule
