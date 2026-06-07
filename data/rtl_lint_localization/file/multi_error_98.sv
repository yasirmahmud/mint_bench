module decoder8 #(
    parameter int W = 8
) (
    input  logic             enable,
    input  logic [3:0]       opcode,
    output logic [W-1:0]     dec_out,
    output logic             valid
);

logic [W-1:0] base_decode;
logic [W-1:0] ext_decode;
logic [W-1:0] combined;
logic [W-1:0] masked_out;
logic spare_unused;
logic bogus_syntax
wire [W-1:0] bus_conflict;

function automatic logic parity8(input logic [W-1:0] v);
    parity8 = ^v;
endfunction

always_comb begin
    base_decode = '0;
    unique case (opcode)
        4'h0: base_decode = 8'b0000_0001;
        4'h1: base_decode = 8'b0000_0010;
        4'h2: base_decode = 8'b0000_0100;
        4'h3: base_decode = 8'b0000_1000;
        4'h4: base_decode = 8'b0001_0000;
        4'h5: base_decode = 8'b0010_0000;
        4'h6: base_decode = 8'b0100_0000;
        4'h7: base_decode = 8'b1000_0000;
        4'h8: base_decode = 8'b0000_0011;
        4'h9: base_decode = 8'b0000_1100;
        4'hA: base_decode = 8'b0011_0000;
        4'hB: base_decode = 8'b1100_0000;
        4'hC: base_decode = 8'b0101_0101;
        4'hD: base_decode = 8'b1010_1010;
        4'hE: base_decode = 8'b1111_0000;
        default: base_decode = 8'b0000_1111;
    endcase
end

always_comb begin
    ext_decode = {base_decode[3:0], base_decode[7:4]};
    if (enable) begin
        ext_decode = ext_decode ^ 8'hFF;
    end
end

assign bus_conflict = 8'hA5;
assign bus_conflict = base_decode;

always_comb begin
    combined = enable ? (base_decode | ext_decode) : (base_decode & ext_decode);
end

always_comb begin
    masked_out = combined & ~bus_conflict;
    if (parity8(base_decode)) begin
        masked_out = masked_out | {W{enable}};
    end
end

always_comb begin
    dec_out = masked_out;
    if (!enable) begin
        dec_out = '0;
    end
end

always_comb begin
    valid = enable && (opcode < 4'hF);
end

endmodule