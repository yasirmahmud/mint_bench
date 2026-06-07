module EMBEDDED_IO_HD  (
  input SOC_IN,
  output SOC_OUT,
  output SOC_DIR,
  output FPGA_IN,
  input FPGA_OUT,
  input FPGA_DIR,
  input IO_ISOL_N
);


  wire SOC_DIR_N;

  // Drive SOC_DIR based on FPGA_DIR and IO_ISOL_N
  assign SOC_DIR = FPGA_DIR | (~IO_ISOL_N);

  // Invert SOC_DIR for SOC_DIR_N
  assign SOC_DIR_N = ~SOC_DIR;

  // Data flow from SoC to FPGA (active when SOC_DIR is high)
  assign FPGA_IN = SOC_DIR ? SOC_IN : 1'bz;

  // Data flow from FPGA to SoC (active when SOC_DIR is low, i.e., SOC_DIR_N is high)
  assign SOC_OUT = SOC_DIR_N ? FPGA_OUT : 1'bz;

endmodule
