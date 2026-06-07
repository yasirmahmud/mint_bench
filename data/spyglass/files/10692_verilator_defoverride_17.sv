module top17;
  `define DEVICE_ID 0xABCD
  logic [15:0] dev_id;
  assign dev_id = `DEVICE_ID;
endmodule
