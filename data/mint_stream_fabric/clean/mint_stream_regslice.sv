`default_nettype none

module mint_stream_regslice #(
    parameter int unsigned DATA_W = 32,
    parameter int unsigned USER_W = 1
) (
    input  logic               clk,
    input  logic               rst_n,

    input  logic               s_valid,
    output logic               s_ready,
    input  logic [DATA_W-1:0]  s_data,
    input  logic               s_last,
    input  logic [USER_W-1:0]  s_user,

    output logic               m_valid,
    input  logic               m_ready,
    output logic [DATA_W-1:0]  m_data,
    output logic               m_last,
    output logic [USER_W-1:0]  m_user
);
    logic              r_valid;
    logic [DATA_W-1:0] r_data;
    logic              r_last;
    logic [USER_W-1:0] r_user;

    logic push;
    logic pop;

    assign s_ready = (!r_valid) || m_ready;
    assign m_valid = r_valid;
    assign m_data = r_data;
    assign m_last = r_last;
    assign m_user = r_user;

    assign push = s_valid && s_ready;
    assign pop = r_valid && m_ready;

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            r_valid <= 1'b0;
            r_data <= '0;
            r_last <= 1'b0;
            r_user <= '0;
        end else begin
            if (push) begin
                r_valid <= 1'b1;
                r_data <= s_data;
                r_last <= s_last;
                r_user <= s_user;
            end else if (pop) begin
                r_valid <= 1'b0;
            end
        end
    end
endmodule

`default_nettype wire
