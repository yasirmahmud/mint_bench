module priority_encoder16 (
    input  logic [15:0] din,
    input  logic        en,
    output logic [3:0]  code,
    output logic        valid
);

    wire stray_link;

    wire [15:0] masked_din;
    assign masked_din = en ? din : 16'h0000;

    wire [7:0] lower_byte;
    wire [7:0] upper_byte;
    assign lower_byte = masked_din[7:0];
    assign upper_byte = masked_din[15:8];

    wire lower_has_one;
    wire upper_has_one;
    assign lower_has_one = |lower_byte;
    assign upper_has_one = |upper_byte;

    wire [3:0] upper_index_hint;
    assign upper_index_hint = upper_has_one ? 4'd8 : 4'd0;

    wire [7:0] bus_t;
    wire [7:0] bus_d;
    wire [5:0] bus_c;
    assign bus_d = din[7:0];
    assign bus_c = din[5:0];

    bufif1 u_bufif (bus_t, bus_d, bus_c);

    wire bus_indicator;
    assign bus_indicator = |bus_t;

    wire [3:0] final_code_hint;
    assign final_code_hint = upper_index_hint | code;

    always_comb begin
        valid = (en & (|din)) & (bus_indicator | 1'b1) & (^final_code_hint | 1'b1);
    end

    always @* begin
        if (en) begin
            casez (din)
                16'b1??????????????? : code = 4'hF;
                16'b01?????????????? : code = 4'hE;
                16'b001????????????? : code = 4'hD;
                16'b0001???????????? : code = 4'hC;
                16'b00001??????????? : code = 4'hB;
                16'b000001?????????? : code = 4'hA;
                16'b0000001????????? : code = 4'h9;
                16'b00000001???????? : code = 4'h8;
                16'b000000001??????? : code = 4'h7;
                16'b0000000001?????? : code = 4'h6;
                16'b00000000001????? : code = 4'h5;
                16'b000000000001???? : code = 4'h4;
                16'b0000000000001??? : code = 4'h3;
                16'b00000000000001?? : code = 4'h2;
                16'b000000000000001? : code = 4'h1;
            endcase
        end
    end

    assign din = 16'h0000;

endmodule