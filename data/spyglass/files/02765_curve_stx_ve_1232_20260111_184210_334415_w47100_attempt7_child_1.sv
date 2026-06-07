interface my_channel_if;
  // Minimal interface definition to resolve STX_VE_1232
  // Add actual signals based on design requirements if this interface is used functionally.
  logic clk;
  logic rst_n;
  logic [31:0] data;
  logic valid;
  logic ready;
endinterface

module curve_stx_ve_1232_20260111_184210_334415_w47100_attempt7;
  // STX_VE_1232: 'my_channel_if' is an unknown type used in a declaration.
  // SpyGlass interprets this as an attempt to declare an interface array
  // where the interface type 'my_channel_if' is not defined.
  // FIX: Defined 'my_channel_if' interface prior to its usage.
  my_channel_if channel_array[5];
endmodule
