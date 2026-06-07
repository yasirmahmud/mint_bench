module curve_elab_3519_20260111_142445_attempt12 (
    input clk,
    input rst,
    input [7:0] in_data,
    input sel_i,
    output [7:0] out_mux_data,
    output [7:0] out_reg_data
);

    // Instantiate a MUX module named 'M0'. This is one of the conflicting entities.
    MY_MUX M0 (
        .IN0(in_data),
        .IN1(in_data),
        .SEL(sel_i),
        .OUT(out_mux_data)
    );

    // Declare a register variable named 'M0' at the same hierarchical level.
    // SpyGlass's elaboration phase is expected to identify a conflict between this register
    // and the MUX instance also named 'M0'. This directly addresses the rule description:
    // "The register in the always block also gets elaborated as M0. That conflicts with the MUX instance name"
    reg [7:0] M0; 

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            M0 <= 8'h00;
        end else begin
            M0 <= in_data;
        end
    end

    // Assign the register value to an output to avoid an 'unused signal' violation.
    assign out_reg_data = M0;

endmodule
