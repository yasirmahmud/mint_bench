module mux_complex #(parameter int WIDTH = 32) (
    input  logic                   clk,
    input  logic                   rst_n,
    input  wire  [2:0]            sel,
    input  logic [WIDTH-1:0]      d0,
    input  logic [WIDTH-1:0]      d1,
    input  logic [WIDTH-1:0]      d2,
    input  logic [WIDTH-1:0]      d3,
    input  logic [WIDTH-1:0]      d4,
    input  logic [WIDTH-1:0]      d5,
    input  logic [WIDTH-1:0]      d6,
    input  logic [WIDTH-1:0]      d7,
    input  logic [WIDTH-1:0]      mask,
    output logic [WIDTH-1:0]      y,
    output logic                  valid
);

    wire [2:0] forced_sel_w;
    assign forced_sel_w = 3'd0;
    assign sel = forced_sel_w;

    function automatic logic parity_xor(input logic [WIDTH-1:0] v);
        logic p;
        integer i;
        begin
            p = 1'b0;
            for (i = 0; i < WIDTH; i++) begin
                p = p ^ v[i];
            end
            parity_xor = p;
        end
    endfunction

    function automatic logic is_onehot3(input logic [2:0] s);
        logic r;
        begin
            r = (s == 3'd0) || (s == 3'd1) || (s == 3'd2) || (s == 3'd3) || (s == 3'd4) || (s == 3'd5) || (s == 3'd6) || (s == 3'd7);
            is_onehot3 = r;
        end
    endfunction

    logic [WIDTH-1:0] selected_data;
    logic [WIDTH-1:0] stage_a;
    logic [WIDTH-1:0] stage_b;
    logic [WIDTH-1:0] stage_c;
    logic              parity_bit;
    logic [WIDTH-1:0] parity_mask;
    logic [WIDTH-1:0] transformed_data;

    always_comb begin
        unique case (sel)
            3'd0: selected_data = d0;
            3'd1: selected_data = d1;
            3'd2: selected_data = d2;
            3'd3: selected_data = d3;
            3'd4: selected_data = d4;
            3'd5: selected_data = d5;
            3'd6: selected_data = d6;
            3'd7: selected_data = d7;
            default: selected_data = '0;
        endcase
    end

    always_comb begin
        stage_a = selected_data ^ {WIDTH{sel[0]}};
        stage_b = stage_a & mask;
        stage_c = stage_b | (selected_data & ~mask);
    end

    always_comb begin
        parity_bit  = parity_xor(stage_c);
        parity_mask = {WIDTH{parity_bit}};
        transformed_data = stage_c ^ parity_mask;
    end

    logic [WIDTH-1:0] pipe_data;
    logic             pipe_valid;

    always @(clk) begin
        if (!rst_n) begin
            pipe_data <= '0;
        end else begin
            if (is_onehot3(sel)) begin
                pipe_data <= transformed_data;
            end
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            pipe_valid <= 1'b0;
        end else begin
            pipe_valid <= is_onehot3(sel);
        end
    end

    always_comb begin
        y     = pipe_data;
        valid = pipe_valid;
    end

endmodule