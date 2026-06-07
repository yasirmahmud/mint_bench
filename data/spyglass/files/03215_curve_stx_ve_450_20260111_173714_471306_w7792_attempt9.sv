module curve_stx_ve_450_20260111_173714_471306_w7792_attempt9;

  // STX_VE_450: This 'typedef struct packed' contains an unpacked member 'data_fifo'.
  // Note: 'typedef struct' is a SystemVerilog construct. This example uses it to trigger
  // the STX_VE_450 rule, as Verilog-2001 does not strictly support structures. SpyGlass
  // often processes SystemVerilog constructs in this context.
  typedef struct packed {
    reg [3:0] id;
    reg [15:0] data_fifo[4]; // This is the unpacked member triggering the violation
    reg [7:0] crc;
  } config_reg_map_t;

  config_reg_map_t my_config_map;

  initial begin
    my_config_map.id = 4'hA;
    my_config_map.data_fifo[0] = 16'h1234;
    my_config_map.data_fifo[3] = 16'hABCD;
    my_config_map.crc = 8'hEF;

    $display("ID: %h", my_config_map.id);
    $display("Data FIFO[0]: %h", my_config_map.data_fifo[0]);
    $display("CRC: %h", my_config_map.crc);
  end

endmodule
