module top17;
  `define DEVICE_ID 16'hABCD
  logic [15:0] dev_id;
  assign dev_id = `DEVICE_ID;
endmodule
