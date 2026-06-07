module io1bit_unq3 (
  clk, 
  reset,

  // breakout for verilator
  //pad,
  pad_in,
  pad_out,

  p2f,
  f2p_16,
  f2p_1,
  config_addr,
  config_data,
  config_write,
  config_read,
  tile_id,
  read_data
);

  /* verilator lint_off UNUSED */
  input  clk;
  input  reset;

  // breakout for verilator
  //inout  pad;
  input  pad_in;
  output pad_out;

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


  // Original 'config_en' was a combinational reg driven by an always @(*)
  // block that included 'reset' in its sensitivity list. This caused STARC05-1.3.1.3.
  // To resolve this, 'config_en_val' is now a wire whose logic is independent
  // of 'reset'. The 'reset' signal still correctly clears 'io_bit' and 'out_bus'
  // in their sequential block, preserving functional behavior.
  wire config_en_val;
  assign config_en_val = config_write&&(config_addr[15:0]==tile_id)&&(config_addr[23:16]==8'd0);

  reg io_bit;
  reg out_bus;
  always @(posedge clk or posedge reset) begin
    if (reset==1'b1) begin
       io_bit <= 1'b0;   // Fixed W336: Changed to non-blocking assignment
       out_bus <= 1'b0;  // Fixed W336: Changed to non-blocking assignment
    end else begin
       if (config_en_val==1'b1) begin // Using config_en_val (independent of reset signal in its definition)
         io_bit <= config_data[0]; // Fixed W336: Changed to non-blocking assignment
         out_bus <= config_data[1]; // Fixed W336: Changed to non-blocking assignment
       end
    end
  end

  always @(*) begin
    if(config_read&&(config_addr[15:0]==tile_id)&&(config_addr[23:16]==8'd0)) begin
	read_data = {30'b0, io_bit, out_bus}; // Explicitly zero-extend; functionally same as original
    end
    else begin
	read_data = 'h0;
    }
  end

  assign pad_out = (io_bit==1'b1) ? ((out_bus==1'b0)?f2p_16:f2p_1) : 1'b0;
  assign p2f     = (io_bit==1'b1) ?            1'b0                : pad_in;

endmodule
