module top9;
  `define RESET_ACTIVE_LOW 0
  logic rst_n;
  logic dummy_read; // Added to resolve W528

  assign rst_n = `RESET_ACTIVE_LOW;

  // Dummy block to read rst_n and resolve W528 violation
  always_comb begin
    dummy_read = rst_n;
  end

endmodule
