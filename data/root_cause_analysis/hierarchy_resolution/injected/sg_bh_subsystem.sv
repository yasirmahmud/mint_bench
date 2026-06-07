module sg_bh_subsystem #(
    parameter int DATA_W = 32
) (
    output logic [DATA_W-1:0] digest,
    output logic              signature
);
    // These signal names are intentionally aligned with the child module port names so we can
    // use SystemVerilog implicit port connections (.*).
    //
    // If the instance is unresolved, (.*) cannot be expanded, and the tool may treat these as:
    // - src*: driven but unused
    // - sink*: read but undriven
    logic [DATA_W-1:0] src0, src1, src2, src3, src4, src5, src6, src7, src8, src9;
    logic [DATA_W-1:0] sink0, sink1, sink2, sink3, sink4, sink5, sink6, sink7, sink8, sink9;

    always_comb begin
        src0 = 32'h0000_0001;
        src1 = 32'h0000_0002;
        src2 = 32'h0000_0004;
        src3 = 32'h0000_0008;
        src4 = 32'h0000_0010;
        src5 = 32'h0000_0020;
        src6 = 32'h0000_0040;
        src7 = 32'h0000_0080;
        src8 = 32'h0000_0100;
        src9 = 32'h0000_0200;
    end

    // ROOT BUG: typo in instantiated module name causes unresolved hierarchy reports.
    // Intended module name is sg_bh_unit (defined in sg_bh_unit.sv).
    sg_bh_unti #(
        .DATA_W(DATA_W)
    ) u_unit (.*);

    always_comb begin
        digest = sink0 ^ sink1 ^ sink2 ^ sink3 ^ sink4 ^ sink5 ^ sink6 ^ sink7 ^ sink8 ^ sink9;
        signature = ^digest;
    end
endmodule
