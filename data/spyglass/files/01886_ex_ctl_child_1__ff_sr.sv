module ff_sr(
        output out,
        input din,
        input reset_l,
        input clk
    );
        reg dout;
        always @(posedge clk or negedge reset_l) begin
            if (!reset_l) dout <= 1'b0;
            else dout <= din;
        end
        assign out = dout;
    endmodule
