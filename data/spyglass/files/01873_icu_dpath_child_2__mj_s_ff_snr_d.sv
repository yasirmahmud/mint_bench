module mj_s_ff_snr_d (
    output reg out,
    input      in,
    input      clk,
    input      reset_l
);
    always @(posedge cllk or negedge reset_l) begin
        if (!reset_l) out <= 1'b0; // Assuming reset to 0
        else out <= in;
    end
endmodule
