module ff_sre (output out, input din, input clk, input enable, input reset_l);
    reg r_out;
    always @(posedge clk or negedge reset_l) begin
        if (!reset_l) begin
            r_out <= 1'b0;
        end else if (enable) begin
            r_out <= din;
        end
    end
    assign out = r_out;
endmodule
