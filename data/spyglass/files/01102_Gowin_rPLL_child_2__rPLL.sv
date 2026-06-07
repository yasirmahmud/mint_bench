module rPLL (
    CLKOUT,
    LOCK,
    CLKOUTP,
    CLKOUTD,
    CLKOUTD3,
    RESET,
    RESET_P,
    CLKIN,
    CLKFB,
    FBDSEL,
    IDSEL,
    ODSEL,
    PSDA,
    DUTYDA,
    FDLY
);
    parameter FCLKIN = "27";
    parameter DYN_IDIV_SEL = "false";
    parameter IDIV_SEL = 4;
    parameter DYN_FBDIV_SEL = "false";
    parameter FBDIV_SEL = 11;
    parameter DYN_ODIV_SEL = "false";
    parameter ODIV_SEL = 8;
    parameter PSDA_SEL = "0000";
    parameter DYN_DA_EN = "true";
    parameter DUTYDA_SEL = "1000";
    parameter CLKOUT_FT_DIR = 1'b1;
    parameter CLKOUTP_FT_DIR = 1'b1;
    parameter CLKOUT_DLY_STEP = 0;
    parameter CLKOUTP_DLY_STEP = 0;
    parameter CLKFB_SEL = "internal";
    parameter CLKOUT_BYPASS = "false";
    parameter CLKOUTP_BYPASS = "false";
    parameter CLKOUTD_BYPASS = "false";
    parameter DYN_SDIV_SEL = 2;
    parameter CLKOUTD_SRC = "CLKOUT";
    parameter CLKOUTD3_SRC = "CLKOUT";
    parameter DEVICE = "GW1NR-9C";

    output CLKOUT;
    output LOCK;
    output CLKOUTP;
    output CLKOUTD;
    output CLKOUTD3;
    input RESET;
    input RESET_P;
    input CLKIN;
    input CLKFB;
    input [5:0] FBDSEL;
    input [5:0] IDSEL;
    input [5:0] ODSEL;
    input [3:0] PSDA;
    input [3:0] DUTYDA;
    input [3:0] FDLY;

    assign CLKOUT = CLKIN;
    assign CLKOUTP = CLKIN;
    assign CLKOUTD = CLKIN;
    assign CLKOUTD3 = CLKIN;
    assign LOCK = 1'b1;

    wire dummy_input_read = RESET
                          | RESET_P
                          | CLKFB
                          | FBDSEL[0]
                          | FBDSEL[1]
                          | FBDSEL[2]
                          | FBDSEL[3]
                          | FBDSEL[4]
                          | FBDSEL[5]
                          | IDSEL[0]
                          | IDSEL[1]
                          | IDSEL[2]
                          | IDSEL[3]
                          | IDSEL[4]
                          | IDSEL[5]
                          | ODSEL[0]
                          | ODSEL[1]
                          | ODSEL[2]
                          | ODSEL[3]
                          | ODSEL[4]
                          | ODSEL[5]
                          | PSDA[0]
                          | PSDA[1]
                          | PSDA[2]
                          | PSDA[3]
                          | DUTYDA[0]
                          | DUTYDA[1]
                          | DUTYDA[2]
                          | DUTYDA[3]
                          | FDLY[0]
                          | FDLY[1]
                          | FDLY[2]
                          | FDLY[3];

endmodule
