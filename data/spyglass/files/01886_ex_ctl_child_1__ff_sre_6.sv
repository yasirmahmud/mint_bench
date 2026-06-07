module ff_sre_6(
        output [5:0] out,
        input [5:0] din,
        input enable,
        input reset_l,
        input clk
    );
        reg [5:0] dout;
        always @(posedge clk or negedge reset_l) begin
            if (!reset_l) dout <= 6'b0;
            else if (enable) dout <= din;
        end
        assign out = dout;
    endmodule
