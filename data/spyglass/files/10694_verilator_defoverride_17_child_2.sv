module top17;
  `define DEVICE_ID 16'hABCD
  logic [15:0] dev_id;
  assign dev_id = `DEVICE_ID;

  // To resolve 'set but not read' violation, display the variable's value
  initial begin
    $display("dev_id: %h", dev_id);
  end
endmodule
