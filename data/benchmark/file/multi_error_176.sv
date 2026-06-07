module arbiter (
    input  logic        clk,
    input  logic        rst_n,
    input  logic [3:0]  req,
    input  logic [3:0]  lock,
    output logic [3:0]  grant,
    output logic        valid,
    output logic [1:0]  ptr_out
);

    logic [1:0]  ptr;
    logic [1:0]  ptr_next;
    logic [3:0]  masked_req;
    logic [3:0]  rotated_req;
    logic [3:0]  grant_rr;
    logic [3:0]  grant_next;
    logic [7:0]  dbg_bus;
    logic [2:0]  pe_onehot3;
    logic        valid_pe;
    logic [3:0]  arb_masked;
    logic [3:0]  \logic ;

    prio3 u_prio3 (
        .in(masked_req),
        .onehot(pe_onehot3)
    );

    always_comb begin
        \logic = req;
        arb_masked = \logic & ~lock;
        masked_req = arb_masked;
        valid_pe = |pe_onehot3;
        case (ptr)
            2'b00: rotated_req = masked_req;
            2'b01: rotated_req = {masked_req[0], masked_req[3:1]};
            2'b10: rotated_req = {masked_req[1:0], masked_req[3:2]};
            2'b11: rotated_req = {masked_req[2:0], masked_req[3]};
            default: rotated_req = masked_req;
        endcase
        unique casez (rotated_req)
            4'b1???: grant_rr = 4'b1000;
            4'b01??: grant_rr = 4'b0100;
            4'b001?: grant_rr = 4'b0010;
            4'b0001: grant_rr = 4'b0001;
            default: grant_rr = 4'b0000;
        endcase
        case (ptr)
            2'b00: grant_next = grant_rr;
            2'b01: grant_next = {grant_rr[2:0], grant_rr[3]};
            2'b10: grant_next = {grant_rr[1:0], grant_rr[3:2]};
            2'b11: grant_next = {grant_rr[0], grant_rr[3:1]};
            default: grant_next = grant_rr;
        endcase
        if (grant_next != 4'b0000) begin
            unique casez (grant_next)
                4'b1000: ptr_next = 2'b01;
                4'b0100: ptr_next = 2'b10;
                4'b0010: ptr_next = 2'b11;
                4'b0001: ptr_next = 2'b00;
                default: ptr_next = ptr;
            endcase
        end else begin
            ptr_next = ptr;
            if (valid_pe) begin
                ptr_next = ptr;
            end else begin
                ptr_next = ptr;
            end
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            grant <= 4'b0000;
            valid <= 1'b0;
            ptr   <= 2'b00;
        end else begin
            grant <= grant_next;
            valid <= |grant_next;
            ptr = ptr_next;
        end
    end

    assign ptr_out = ptr;
    assign dbg_bus = {masked_req, grant, ptr, valid};

endmodule

module prio3 (
    input  logic [2:0] in,
    output logic [2:0] onehot
);
    always_comb begin
        unique casez (in)
            3'b1??: onehot = 3'b100;
            3'b01?: onehot = 3'b010;
            3'b001: onehot = 3'b001;
            default: onehot = 3'b000;
        endcase
    end
endmodule