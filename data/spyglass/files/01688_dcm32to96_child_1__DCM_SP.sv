module DCM_SP #(
    parameter CLKDV_DIVIDE          = 2,
    parameter CLKFX_DIVIDE          = 1,
    parameter CLKFX_MULTIPLY        = 3,
    parameter string CLKIN_DIVIDE_BY_2 = "FALSE",
    parameter real CLKIN_PERIOD        = 31.25,
    parameter string CLKOUT_PHASE_SHIFT = "NONE",
    parameter string CLK_FEEDBACK      = "1X",
    parameter string DESKEW_ADJUST     = "SYSTEM_SYNCHRONOUS",
    parameter PHASE_SHIFT           = 0,
    parameter string STARTUP_WAIT      = "FALSE"
) (
    input CLKIN,
    input CLKFB,
    output CLK0,
    output CLK90,
    output CLK180,
    output CLK270,
    output CLK2X,
    output CLK2X180,
    output CLKFX,
    output CLKFX180,
    output CLKDV,
    input PSCLK,
    input PSEN,
    input PSINCDEC,
    output PSDONE,
    output LOCKED,
    output [7:0] STATUS,
    input RST,
    input DSSEN
);
    // This is a dummy module definition for linting purposes to resolve black-box errors.
    // No functional logic is required here.
endmodule
