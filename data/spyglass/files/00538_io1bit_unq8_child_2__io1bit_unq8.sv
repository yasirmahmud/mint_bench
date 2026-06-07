module io1bit_unq8  (
clk,
reset,
pad,
p2f,
f2p_16,
f2p_1,
config_addr,
config_data,
config_write,
config_read,
tile_id,
read_data,
rte,
esd);


  input rte;
  input esd;
  /* verilator lint_off UNUSED */
  input  clk;
  input  reset;
  inout  pad;
  output p2f;
  input f2p_16;
  input f2p_1;
  input [31:0] config_data;
  input [31:0] config_addr;
  input config_read;
  input config_write;
  input [15:0] tile_id;
  output [31:0] read_data; // Changed from 'output reg' to 'output' to resolve SYNTH_126
  /* verilator lint_on UNUSED */

  wire muxed_f2p;
  // Removed redundant 'wire rte, esd;' declarations as they are already inputs.

  // Refactored config_en logic to explicitly combine reset for potentially better lint tool interpretation
  wire config_enable_pulse = config_write && (config_addr[15:0]==tile_id) && (config_addr[23:16]==8'd0);
  reg config_en;
  always @(*) begin
    config_en = config_enable_pulse & ~reset;
  end

  reg io_bit;
  reg out_bus;
  always @(posedge clk or posedge reset) begin
    if (reset==1'b1) begin
       io_bit <= 1'b0;
       out_bus <= 1'b0;
    end else begin
       if (config_en==1'b1) begin
         io_bit <= config_data[0];
         out_bus <= config_data[1];
       end
    end
  end

  // Internal wire for read_data_combinational to resolve SYNTH_126
  wire [31:0] read_data_combinational;
  always @(*) begin
    if (config_read&&(config_addr[15:0]==tile_id)&&(config_addr[23:16]==8'd0)) begin
      read_data_combinational = {30'b0, io_bit, out_bus};
    end
    else begin
      read_data_combinational = 'h0;
    end // Added missing 'end' for the else block, fixing STX_VE_481/569
  end
  assign read_data = read_data_combinational; // Continuous assignment to output port

  //assign pad = (io_bit==1'b1)?((out_bus==1'b0)?f2p_16:f2p_1):1'bz; // Kept commented as in original
  //assign p2f = pad; // Kept commented as in original

  assign muxed_f2p = (out_bus==1'b0) ? f2p_16 : f2p_1;

// Changed to Verilog-1995 style ordered port connection to address STX_VE_479/569
PRWDWUWSWCDGH_V IOPAD(
  pad,       // .PAD
  muxed_f2p, // .I
  io_bit,    // .OEN
  1'b0,      // .ST
  1'b0,      // .SL
  io_bit,    // .IE
  p2f,       // .C
  1'b0,      // .DS0
  1'b0,      // .DS1
  1'b0,      // .DS2
  1'b0,      // .PU
  1'b0,      // .PD
  rte,       // .RTE
  esd        // .ESD
);


endmodule
