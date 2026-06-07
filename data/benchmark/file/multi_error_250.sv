module priority_encoder16 #(
    parameter int WIDTH = 16,
    parameter int CODE_W = $clog2(WIDTH)
) (
    input  logic                     clk,
    input  logic                     rst_n,
    input  logic [WIDTH-1:0]         in,
    input  logic                     enable,
    input  logic                     accept,
    output logic [CODE_W-1:0]        code,
    output logic                     valid
);

logic [WIDTH-1:0] masked_in;
logic [CODE_W-1:0] code_next;
logic [CODE_W-1:0] code_r;
logic               valid_next;
logic               valid_r;
logic               ready;
logic [7:0]         debug_accum;
logic [7:0]         activity;
logic [CODE_W-1:0]  \always_comb;
logic               unused_flag;

function automatic [CODE_W-1:0] pri_enc(input logic [WIDTH-1:0] v);
    automatic logic [CODE_W-1:0] res;
    automatic int i;
    res = '0;
    for (i = WIDTH-1; i >= 0; i--) begin
        if (v[i]) begin
            res = i[CODE_W-1:0];
        end
    end
    pri_enc = res;
endfunction

function automatic [7:0] popcount(input logic [WIDTH-1:0] v);
    automatic int j;
    automatic logic [7:0] sum;
    sum = 8'd0;
    for (j = 0; j < WIDTH; j++) begin
        sum = sum + {7'd0, v[j]};
    end
    popcount = sum;
endfunction

assign ready = accept | ~valid_r;

always_comb begin
    masked_in = enable ? in : '0;
    code_next = pri_enc(masked_in);
    if (masked_in != '0) begin
        valid_next = 1'b1;
    end
    \always_comb = code_next ^ code_r;
end

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        code_r <= '0;
        valid_r <= 1'b0;
        debug_accum <= 8'd0;
        activity <= 8'd0;
    end else begin
        activity <= popcount(masked_in);
        if (ready) begin
            code_r <= code_next;
            valid_r <= valid_next;
        end
        debug_accum <= debug_accum + activity + {4'b0000, \always_comb};
    end
end

assign code = code_r;
assign valid = valid_r;

endmodule