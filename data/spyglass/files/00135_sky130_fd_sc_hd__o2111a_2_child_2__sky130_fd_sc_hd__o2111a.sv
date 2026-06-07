// Blackbox definition for sky130_fd_sc_hd__o2111a to satisfy linting tools.
// This module's actual implementation is provided in a technology library and is not detailed here.
module sky130_fd_sc_hd__o2111a (
    X,
    A1,
    A2,
    B1,
    C1,
    D1,
    VPWR,
    VGND,
    VPB,
    VNB
);
    output X;
    input  A1;
    input  A2;
    input  B1;
    input  C1;
    input  D1;
    input  VPWR;
    input  VGND;
    input  VPB;
    input  VNB;

    // synthesis translate_off
    // Dummy logic to satisfy linting tools for blackbox analysis (e.g., WarnAnalyzeBBox and W240).
    // The actual cell behavior is defined in the technology library, not in this Verilog model.

    // Drive output X to an unknown value, as its true logic is external.
    assign X = 1'bx;

    // Consume all inputs to prevent 'input declared but not read' warnings (W240).
    // This includes power pins, as linting tools might not distinguish them without UPF.
    wire [8:0] _dummy_read_inputs; // 5 data inputs + 4 power inputs = 9 bits
    assign _dummy_read_inputs = {A1, A2, B1, C1, D1, VPWR, VGND, VPB, VNB};
    // synthesis translate_on

endmodule
