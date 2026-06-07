module curve_stx_ve_450_20260111_173714_471306_w7792_attempt7;

  // STX_VE_450: This 'typedef struct packed' contains an unpacked member 'data_buffer'.
  // Verilog-2001 does not inherently support 'typedef struct'. This example
  // leverages SystemVerilog's 'typedef struct packed' to demonstrate the rule,
  // while using Verilog-2001 compatible syntax for other parts of the module.
  typedef struct packed {
    reg [15:0] data_buffer[4]; // This is the unpacked member triggering the violation
  } my_data_config_t;

  my_data_config_t config_registers;

  initial begin
    config_registers.data_buffer[0] = 16'h1234;
    config_registers.data_buffer[3] = 16'hABCD;
    $display("Config Data[0]: %h", config_registers.data_buffer[0]);
  end

endmodule
