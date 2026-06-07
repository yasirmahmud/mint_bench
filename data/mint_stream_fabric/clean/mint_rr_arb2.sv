`default_nettype none

module mint_rr_arb2 (
    input  logic clk,
    input  logic rst_n,

    input  logic req0,
    input  logic req1,
    input  logic advance,

    output logic gnt0,
    output logic gnt1,
    output logic gnt_valid
);
    logic last_grant;

    always_comb begin
        gnt0 = 1'b0;
        gnt1 = 1'b0;
        gnt_valid = 1'b0;

        unique case ({req1, req0})
            2'b00: begin
                // No requests.
            end
            2'b01: begin
                gnt0 = 1'b1;
                gnt_valid = 1'b1;
            end
            2'b10: begin
                gnt1 = 1'b1;
                gnt_valid = 1'b1;
            end
            2'b11: begin
                gnt_valid = 1'b1;
                if (last_grant == 1'b0) begin
                    gnt1 = 1'b1;
                end else begin
                    gnt0 = 1'b1;
                end
            end
            default: begin
                // Fully specified above.
            end
        endcase
    end

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            last_grant <= 1'b0;
        end else if (advance && gnt_valid) begin
            if (gnt1) begin
                last_grant <= 1'b1;
            end else if (gnt0) begin
                last_grant <= 1'b0;
            end
        end
    end
endmodule

`default_nettype wire
