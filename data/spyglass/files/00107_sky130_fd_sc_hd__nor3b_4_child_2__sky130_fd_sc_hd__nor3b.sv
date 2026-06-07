// Stub definition for sky130_fd_sc_hd__nor3b to resolve ErrorAnalyzeBBox and W240 linting violations.
// In a full design flow, this module would be provided by a standard cell library.
// The linting tool requires a definition for instantiated modules in the current compilation scope.
module sky130_fd_sc_hd__nor3b (
    output Y,
    input A,
    input B,
    input C_N,
    input VPWR,
    input VGND,
    input VPB,
    input VNB
);
    // Functional behavior to satisfy the linter by driving output Y and reading inputs A, B, C_N.
    // This implements the logical function Y = ~ (A | B | C_N).
    assign Y = ~(A | B | C_N);

    // Dummy assignments to consume power/ground inputs (VPWR, VGND, VPB, VNB) for linting purposes.
    // These inputs are typically for physical connection and not used in RTL logic directly,
    // but the linter flags them as 'declared but not read' when the module is empty.
    wire _unused_VPWR = VPWR;
    wire _unused_VGND = VGND;
    wire _unused_VPB  = VPB;
    wire _unused_VNB  = VNB;
endmodule
