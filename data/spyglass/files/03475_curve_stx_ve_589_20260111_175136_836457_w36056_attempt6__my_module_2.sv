module my_module ( // Duplicate module definition triggers STX_VE_589
  input wire en,
  output wire busy
);
  assign busy = en;
endmodule
