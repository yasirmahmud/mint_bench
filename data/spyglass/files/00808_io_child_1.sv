module io  (IO_ISOL_N,
          SOC_IN,
          SOC_OUT,
          SOC_DIR,
          FPGA_OUT,
          FPGA_DIR,
          FPGA_IN);

//----- GLOBAL PORTS -----
input [0:0] IO_ISOL_N;
//----- GPIN PORTS -----
input [0:0] SOC_IN;
//----- GPOUT PORTS -----
output [0:0] SOC_OUT;
//----- GPOUT PORTS -----
output [0:0] SOC_DIR;
//----- INPUT PORTS -----
input [0:0] FPGA_OUT;
//----- INPUT PORTS -----
input [0:0] FPGA_DIR;
//----- OUTPUT PORTS -----
output [0:0] FPGA_IN;

//----- BEGIN wire-connection ports -----
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----

// ----- Internal logic should start here -----
  wire [0:0] SOC_DIR_N;

  // Replaced sky130_fd_sc_hd__or2b_4 ISOL_EN_GATE
  // Original behavior: X = A | ~B_N
  // So, SOC_DIR = FPGA_DIR | (~IO_ISOL_N)
  assign SOC_DIR = FPGA_DIR | (~IO_ISOL_N);

  // Replaced sky130_fd_sc_hd__inv_1 INV_SOC_DIR
  // Original behavior: Y = ~A
  // So, SOC_DIR_N = ~SOC_DIR
  assign SOC_DIR_N = ~SOC_DIR;

  // Replaced sky130_fd_sc_hd__ebufn_4 IN_PROTECT_GATE
  // Original behavior: Z = A when TE_B is 0, Z = 'z' when TE_B is 1
  // So, FPGA_IN = SOC_IN when SOC_DIR_N is 0, else 'z'
  assign FPGA_IN = (SOC_DIR_N == 1'b0) ? SOC_IN : 1'bz;

  // Replaced sky130_fd_sc_hd__ebufn_4 OUT_PROTECT_GATE
  // Original behavior: Z = A when TE_B is 0, Z = 'z' when TE_B is 1
  // So, SOC_OUT = FPGA_OUT when SOC_DIR is 0, else 'z'
  assign SOC_OUT = (SOC_DIR == 1'b0) ? FPGA_OUT : 1'bz;

// ----- Internal logic should end here -----
endmodule
