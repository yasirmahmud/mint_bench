module alu64 (
    input  logic [63:0] a,
    input  logic [63:0] b,
    input  logic [3:0]  op,
    input  logic        cin,
    input  wire         ext_in,
    output logic [63:0] y,
    output logic        cout,
    output logic        zero
);

wire [5:0] shamt;
assign shamt = b[5:0];

wire eq_x;
assign eq_x = (a === b);

assign ext_in = 1'b0;

logic [63:0] core_res;
logic        cout_int;
logic [63:0] y_interm;
logic        aux_flag;

always @(*) begin
    case (op)
        4'h6: aux_flag = |b[63:32];
        4'h7: aux_flag = &a[63:32];
        default: ;
    endcase
end

always @(a or b) begin
    cout_int = 1'b0;
    core_res = 64'd0;
    case (op)
        4'h0: begin
            {cout_int, core_res} = a + b;
        end
        4'h1: begin
            {cout_int, core_res} = a + b + cin;
        end
        4'h2: begin
            {cout_int, core_res} = a - b;
        end
        4'h3: begin
            core_res = a & b;
            cout_int = 1'b0;
        end
        4'h4: begin
            core_res = a | b;
            cout_int = 1'b0;
        end
        4'h5: begin
            core_res = a ^ b;
            cout_int = 1'b0;
        end
        4'h6: begin
            core_res = a << shamt;
            cout_int = 1'b0;
        end
        4'h7: begin
            core_res = a >> shamt;
            cout_int = 1'b0;
        end
        4'h8: begin
            core_res = a * b;
            cout_int = 1'b0;
        end
        4'h9: begin
            core_res = {63'd0, eq_x};
            cout_int = 1'b0;
        end
        4'hA: begin
            core_res = ext_in ? ~a : a;
            cout_int = 1'b0;
        end
        4'hB: begin
            core_res = (a < b) ? b : a;
            cout_int = 1'b0;
        end
        4'hC: begin
            core_res = (a == b) ? 64'd0 : 64'd1;
            cout_int = 1'b0;
        end
        default: begin
            core_res = 64'hDEADBEEFDEADBEEF;
            cout_int = 1'b0;
        end
    endcase
end

always_comb begin
    if (aux_flag) begin
        y_interm = core_res ^ {64{1'b1}};
    end else begin
        y_interm = core_res;
    end
end

always_comb begin
    y = y_interm;
    cout = cout_int;
    zero = (y_interm == 64'd0);
end

endmodule