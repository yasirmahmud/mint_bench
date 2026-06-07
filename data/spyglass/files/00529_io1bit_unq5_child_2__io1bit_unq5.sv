module io1bit_unq5  (
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
  // Removed redundant 'wire rte, esd;' declaration as they are already declared as inputs.

  reg config_en;
  always @(*) begin
    // Removed 'if (reset)' condition to resolve STARC05-1.3.1.3 violation.
    // 'reset' now only acts as an asynchronous reset for 'io_bit' and 'out_bus' registers,
    // and does not indirectly affect their synchronous enable logic via 'config_en'.
    // Functional behavior is preserved as 'io_bit' and 'out_bus' are asynchronously reset
    // when 'reset' is active, regardless of 'config_en' state.
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
       io_bit <= 1'b0;   // Changed to non-blocking assignment (W336 violation)
       out_bus <= 1'b0;  // Changed to non-blocking assignment (W336 violation)
    end else begin
       if (config_en==1'b1) begin
         io_bit <= config_data[0]; // Changed to non-blocking assignment (W336 violation)
         out_bus <= config_data[1]; // Changed to non-blocking assignment (W336 violation)
       end
    end
  end

  always @(*) begin
    if (config_read&&(config_addr[15:0]==tile_id)&&(config_addr[23:16]==8'd0)) begin
      // Preserving original functional behavior: {io_bit, out_bus} creates a 2-bit value
      // which is then implicitly zero-extended to 32 bits for 'read_data'.
      read_data = {io_bit, out_bus}; 
    end
    else begin
      read_data = 'h0;
    end
  end
  //assign pad = (io_bit==1'b1)?((out_bus==1'b0)?f2p_16:f2p_1):1'bz;
  //assign p2f = pad;

  assign muxed_f2p = (out_bus==1'b0) ? f2p_16 : f2p_1;

PRWDWUWSWCDGH_H IOPAD(
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
