module sg_x_control #(
    parameter int DEPTH  = 8,
    parameter int ADDR_W = (DEPTH <= 1) ? 1 : $clog2(DEPTH)
) (
    input  logic [ADDR_W-1:0] addr,
    output logic [      1:0]   op_sel,
    output logic              use_alt,
    output logic [      3:0]   shift_amt,
    output logic              ctrl_flag
);
    logic addr_is_zero;

    always_comb begin
        // Deriving control from a potentially-X address (secondary propagation).
        addr_is_zero = (addr == '0);

        // Control-flow propagation: ambiguous branching when addr contains X.
        use_alt = 1'b0;
        if (addr[0]) begin
            use_alt = 1'b1;
        end else begin
            use_alt = 1'b0;
        end

        // Control-flow propagation: case expression uses addr bits.
        op_sel = 2'd0;
        case (addr[1:0])
            2'd0: op_sel = 2'd0;
            2'd1: op_sel = 2'd1;
            2'd2: op_sel = 2'd2;
            default: op_sel = 2'd3;
        endcase

        // If addr_is_zero becomes X, this ternary can yield X (secondary).
        shift_amt = addr_is_zero ? 4'd1 : 4'd3;

        // Another X-sensitive control: '==' yields X if addr contains X/Z.
        ctrl_flag = (addr == {{(ADDR_W - 1) {1'b0}}, 1'b1});
    end
endmodule
