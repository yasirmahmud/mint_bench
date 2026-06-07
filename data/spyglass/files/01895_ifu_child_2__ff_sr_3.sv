module ff_sr_3 (output [2:0] out, input [2:0] din, input clk, input reset_l);
    reg [2:0] r_out;
    always @(posedge clk or negedge reset_l) begin
        if (!reset_l) begin
            r_out <= 3'b0;
        end else begin
            r_out <= din;
        end
    end
    assign out = r_out;
endmodule
