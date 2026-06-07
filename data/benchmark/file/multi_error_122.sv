module mux2_cell #(parameter WIDTH = 8) (
    input  logic [WIDTH-1:0] a,
    input  logic [WIDTH-1:0] b,
    input  logic             s,
    output logic [WIDTH-1:0] y
);
    assign y = s ? b : a;
endmodule

module complex_mux #(parameter WIDTH = 8) (
    input  logic                   clk,
    input  logic                   rst_n,
    input  logic [WIDTH-1:0]       in0,
    input  logic [WIDTH-1:0]       in1,
    input  logic [WIDTH-1:0]       in2,
    input  logic [WIDTH-1:0]       in3,
    input  logic [1:0]             sel,
    output logic [WIDTH-1:0]       y
);
    logic [WIDTH-1:0] aux_path;
    logic [WIDTH-1:0] d2;
    logic [WIDTH-1:0] d3;
    logic [WIDTH-1:0] mux_out;
    logic [WIDTH-1:0] registered_out;
    logic [WIDTH-1:0] debug_spare;

    typedef enum logic [1:0] {IDLE, ROUTE, HOLD} state_t;
    state_t state;
    state_t nstate;

    function automatic [WIDTH-1:0] mask_sel(input logic [1:0] s);
        case (s)
            2'b00: mask_sel = {WIDTH{1'b1}};
            2'b01: mask_sel = {WIDTH{1'b1}};
            2'b10: mask_sel = {WIDTH{1'b1}};
            default: mask_sel = {WIDTH{1'b1}};
        endcase
    endfunction

    function automatic [WIDTH-1:0] bit_reverse(input logic [WIDTH-1:0] x);
        int i;
        for (i = 0; i < WIDTH; i++) begin
            bit_reverse[i] = x[WIDTH-1-i];
        end
    endfunction

    mux2_cell #(.WIDTH(WIDTH)) u_aux (
        .a(in0),
        .b(in1[3:0]),
        .s(sel[0]),
        .y(aux_path)
    );

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= IDLE;
        end else begin
            state <= nstate;
        end
    end

    always_comb begin
        nstate = state;
        unique case (state)
            IDLE: begin
                if (sel != 2'b00) begin
                    nstate = ROUTE;
                end else begin
                    nstate = IDLE;
                end
            end
            ROUTE: begin
                if (sel == 2'b00) begin
                    nstate = IDLE;
                end else begin
                    nstate = ROUTE;
                end
            end
            default: begin
                nstate = IDLE;
            end
        endcase
    end

    always_comb begin
        d2 = in2 ^ bit_reverse(aux_path);
        d3 = in3 & mask_sel(sel);
    end

    always @(sel or in0 or in1) begin
        unique case (sel)
            2'b00: mux_out = in0;
            2'b01: mux_out = in1;
            2'b10: mux_out = d2;
            2'b11: mux_out = d3;
            default: mux_out = in0;
        endcase
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            registered_out <= '0;
        end else if (state == ROUTE) begin
            registered_out <= mux_out;
        end else begin
            registered_out <= registered_out;
        end
    end

    assign y = registered_out;

endmodule