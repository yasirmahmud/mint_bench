module io1bit_unq7  (
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
  output reg [31:0] read_data;
  /* verilator lint_on UNUSED */

  wire muxed_f2p;
  wire rte, esd;

  reg config_en;
  // Removed reset from this combinational block to resolve STARC05-1.3.1.3
  // The flip-flops (io_bit, out_bus) are still asynchronously reset,
  // and this enable signal correctly gates synchronous updates after reset de-assertion.
  always @(*) begin
    if (config_write&&(config_addr[15:0]==tile_id)&&(config_addr[23:16]==8'd0)) begin
      config_en = 1'b1;
    end else begin
      config_en = 1'b0;
    end
  end
  reg io_bit;
  reg out_bus;
  always @(posedge clk or posedge reset) begin
    if (reset==1'b1) begin
       io_bit <= 1'b0;   // Changed to non-blocking assignment
       out_bus <= 1'b0;  // Changed to non-blocking assignment
    end else begin
       if (config_en==1'b1) begin
         io_bit <= config_data[0];  // Changed to non-blocking assignment
         out_bus <= config_data[1]; // Changed to non-blocking assignment
       }
    end
  end

  always @(*) begin
    if (config_read&&(config_addr[15:0]==tile_id)&&(config_addr[23:16]==8'd0)) begin
      read_data = {30'b0, io_bit, out_bus}; // Zero-pad for 32-bit output
    end
    else begin
      read_data = 'h0;
    }
  end

  assign muxed_f2p = (out_bus==1'b0) ? f2p_16 : f2p_1;

PRWDWUWSWCDGH_V IOPAD(
  .PAD(pad),
  .I(muxed_f2p),
  .OEN(io_bit),
  .ST(1'b0),
  .SL(1'b0),
  .IE(io_bit),
  .C(p2f),
  .DS0(1'b0), 
  .DS1(1'b0), 
  .DS2(1'b0),
  .PU(1'b0),
  .PD(1'b0), 
  .RTE(rte),
  .ESD(esd)
);


endmodule
