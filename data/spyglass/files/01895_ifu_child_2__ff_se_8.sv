module ff_se_8 (output [7:0] out, input [7:0] din, input clk, input enable);
    reg [7:0] r_out;
    always @(posedge clk) begin
        if (enable) begin
            r_out <= din;
        end
    end
    assign out = r_out;
endmodule
