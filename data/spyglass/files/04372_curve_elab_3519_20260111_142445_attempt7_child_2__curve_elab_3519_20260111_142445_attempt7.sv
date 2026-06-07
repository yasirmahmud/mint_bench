module curve_elab_3519_20260111_142445_attempt7 (
    input clk,
    input rst,
    input in_data0,
    input in_data1,
    input sel_mux,
    output out_reg_data,
    output out_mux_data
);

    // Rule ELAB_3519 states: "The register in the always block also gets elaborated as M0. That conflicts with the MUX instance name"

    // 1. This is a register named 'M0' in an always block. It implements MUX-like behavior.
    // Per the rule description, this register's elaborated name is expected to be 'M0'.
    reg M0;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            M0 <= 1'b0;
        end else begin
            M0 <= sel_mux ? in_data1 : in_data0;
        end
    end

    // 2. This is an instance of a MUX (module type 'MUX').
    // The original instance name 'M0' caused a re-declaration error (STX_VE_600)
    // because 'M0' was already declared as a 'reg'.
    // Renamed the instance to 'mux_inst' to resolve the syntax violation.
    // In Verilog-2001, instantiating an undefined module (like 'MUX' here) typically creates a black box.
    MUX mux_inst (
        .IN0(in_data0),
        .IN1(in_data1),
        .SEL(sel_mux),
        .OUT(out_mux_data) // Connect to an output to avoid an unused signal violation
    );

    // Connect the internal register to an output to avoid an unused signal violation
    assign out_reg_data = M0;

endmodule
