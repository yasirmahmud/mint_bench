module ff_sre_8 (output [7:0] out, input [7:0] din, input clk, input enable, input reset_l);
    reg [7:0] r_out;
    always @(posedge clk or negedge reset_l) begin
        if (!reset_l) begin
            r_out <= 8'b0;
        end else if (enable) begin
            r_out <= din;
        end
    end
    assign out = r_out;
endmodule
