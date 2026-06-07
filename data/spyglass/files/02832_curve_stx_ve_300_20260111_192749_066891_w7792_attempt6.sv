module curve_stx_ve_300_20260111_192749_066891_w7792_attempt6 ();

  // Declare a SystemVerilog constant variable
  const logic [1:0] STATUS_CODE = 2'b01;

  // A Verilog task that attempts to modify the constant
  task update_status_code;
    // Illegal re-assignment to the constant variable
    STATUS_CODE = 2'b10; // This line triggers STX_VE_300
  endtask

  initial begin
    update_status_code;
  end

endmodule
