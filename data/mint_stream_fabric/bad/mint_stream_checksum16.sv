`default_nettype none

module mint_stream_checksum16 #(
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
    output logic [USER_W-1:0]  m_user,
    output logic [15:0]        m_checksum
);
    logic              r_valid;
    logic [DATA_W-1:0] r_data;
    logic              r_last;
    logic [USER_W-1:0] r_user;
    logic [15:0]       r_checksum;

    logic push;
    logic pop;

    logic [15:0] sum_running;
    logic        in_packet;

    logic [15:0] base_sum;
    logic [17:0] sum_ext;
    logic [15:0] word_sum;

    assign s_ready = (!r_valid) || m_ready;

    assign m_valid = r_valid;
    assign m_data = r_data;
    assign m_last = r_last;
    assign m_user = r_user;
    assign m_checksum = r_checksum;

    assign push = s_valid && s_ready;
    assign pop = r_valid && m_ready;

    assign base_sum = in_packet ? sum_running : 16'h0000;
    assign sum_ext = {2'b00, base_sum}
                   + {2'b00, s_data[15:0]}
                   + {2'b00, s_data[31:16]};
    assign word_sum = sum_ext[15:0];

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            r_valid <= 1'b0;
            r_data <= '0;
            r_last <= 1'b0;
            r_user <= '0;
            r_checksum <= 16'h0000;
            sum_running <= 16'h0000;
            in_packet <= 1'b0;
        end else begin
            if (push) begin
                r_valid <= 1'b1;
                r_data <= s_data;
                r_last <= s_last;
                r_user <= s_user;
                r_checksum <= word_sum;

                if (s_last) begin
                    sum_running <= 16'h0000;
                    in_packet <= 1'b0;
                end else begin
                    sum_running <= word_sum;
                    in_packet <= 1'b1;
                end
            end else if (pop) begin
                r_valid <= 1'b0;
            end
        end
    end
endmodule

`default_nettype wire
