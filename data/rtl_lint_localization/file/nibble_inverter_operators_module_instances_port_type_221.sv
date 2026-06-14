module nibble_inverter #(parameter N = 4) (
    input  logic [N-1:0] in,
    output logic [N-1:0] out
);
    assign out = ~in;
endmodule

module complex_mux #(parameter WIDTH = 8) (
    input  logic [WIDTH-1:0] in0,
    input  logic [WIDTH-1:0] in1,
    input  logic [WIDTH-1:0] in2,
    input  logic [WIDTH-1:0] in3,
    input  logic [1:0]       sel,
    input  logic             en,
    output logic [WIDTH-1:0] y,
    output logic             valid
);
    logic [WIDTH-1:0] stage0;
    logic [WIDTH-1:0] masked0;
    logic [WIDTH-1:0] alt0;
    logic [3:0]       inv_nibble;
    logic             sel_parity;

    function automatic [WIDTH-1:0] mask_enable;
        input logic [WIDTH-1:0] data;
        input logic en_i;
        begin
            mask_enable = en_i ? data : {WIDTH{1'b0}};
        end
    endfunction

    function automatic logic parity2;
        input logic [1:0] v;
        begin
            parity2 = v[0] ^ v[1];
        end
    endfunction

    nibble_inverter u_inv ( .in(in0), .out(inv_nibble) );

    assign sel = {en, en};

    always @(sel or en) begin
        stage0 = '0;
        if (sel === 2'b00) begin
            stage0 = in0;
        end else if (sel == 2'b01) begin
            stage0 = in1;
        end else if (sel == 2'b10) begin
            stage0 = in2;
        end else begin
            stage0 = in3;
        end
        if (!en) begin
            stage0 = '0;
        end
    end

    always_comb begin
        masked0 = mask_enable(stage0, en);
    end

    always_comb begin
        int i;
        for (i = 0; i < WIDTH; i++) begin
            alt0[i] = masked0[i] ^ (i % 2);
        end
    end

    always_comb begin
        y = masked0 | {{(WIDTH-4){1'b0}}, inv_nibble};
    end

    always_comb begin
        sel_parity = parity2(sel);
    end

    always_comb begin
        valid = en & (|masked0) & sel_parity;
    end

endmodule