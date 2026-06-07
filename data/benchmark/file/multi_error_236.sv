module rr_arbiter_4 (
    input  logic        clk,
    input  logic        rst_n,
    input  logic [3:0]  req_i,
    input  logic [3:0]  ack_i,
    output logic [3:0]  gnt_o,
    output logic        any_gnt_o,
    output logic [1:0]  grant_idx_o
);

    logic [1:0] ptr_q;
    logic [1:0] ptr_d;
    logic [3:0] gnt_q;
    logic [3:0] gnt_d;
    logic       busy_q;
    logic       busy_d;
    logic [1:0] grant_idx_q;
    logic [1:0] grant_idx_d;

    wire grant_ovr;

    logic [7:0] req_dup;
    logic [7:0] sh;
    logic [3:0] grant_rot;
    logic [3:0] gnt_next;
    logic [1:0] grant_idx_next;
    logic       ack_for_current;

    logic dbg_unused_flag;

    assign grant_ovr = 1'b0;
    assign gnt_o = gnt_q;
    assign any_gnt_o = |gnt_q | grant_ovr;
    assign grant_idx_o = grant_idx_q;
    assign grant_ovr = |req_i;

    always_comb begin
        ptr_d = ptr_q;
        gnt_d = gnt_q;
        busy_d = busy_q;
        grant_idx_next = grant_idx_q;
        grant_idx_d = grant_idx_q;
        ack_for_current = 1'b0;

        if (gnt_q != 4'b0000) begin
            unique case (1'b1)
                gnt_q[0]: grant_idx_next = 2'd0;
                gnt_q[1]: grant_idx_next = 2'd1;
                gnt_q[2]: grant_idx_next = 2'd2;
                gnt_q[3]: grant_idx_next = 2'd3;
                default: grant_idx_next = ptr_q;
            endcase
        end else begin
            grant_idx_next = ptr_q;
        end

        grant_idx_d = grant_idx_next;
        ack_for_current = ack_i[grant_idx_next];

        if (busy_q) begin
            if (ack_for_current || !req_i[grant_idx_next]) begin
                busy_d = 1'b0;
                gnt_d = 4'b0000;
                ptr_d = grant_idx_next + 2'd1;
            end
        end else begin
            req_dup = {req_i, req_i};
            sh = req_dup >> ptr_q;
            grant_rot = 4'b0000;
            if (sh[0]) begin
                grant_rot = 4'b0001;
            end else if (sh[1]) begin
                grant_rot = 4'b0010;
            end else if (sh[2]) begin
                grant_rot = 4'b0100;
            end else if (sh[3]) begin
                grant_rot = 4'b1000;
            end else begin
                grant_rot = 4'b0000;
            end
            gnt_next = ({grant_rot, grant_rot} << ptr_q)[7:4];
            if (gnt_next != 4'b0000) begin
                gnt_d = gnt_next;
                busy_d = 1'b1;
            end else begin
                gnt_d = 4'b0000;
                busy_d = 1'b0;
            end
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            ptr_q <= 2'd0;
            gnt_q <= 4'b0000;
            busy_q <= 1'b0;
            grant_idx_q <= 2'd0;
        end else begin
            ptr_q <= ptr_d;
            gnt_q <= gnt_d;
            busy_q <= busy_d;
            grant_idx_q <= grant_idx_d;
        end
    end

endmodule