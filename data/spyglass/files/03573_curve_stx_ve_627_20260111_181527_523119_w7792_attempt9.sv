module curve_stx_ve_627_20260111_181527_523119_w7792_attempt9 (
  output reg [7:0] data_out
);

  // Define a function that expects 2 arguments
  function automatic [7:0] process_data;
    input [7:0] val_a;
    input [7:0] val_b;
    process_data = val_a + val_b;
  endfunction

  initial begin
    // This call triggers STX_VE_627:
    // 'process_data' is defined to expect 2 arguments (val_a, val_b)
    // It is called with only 1 argument (the literal '10'), resulting in too few arguments.
    data_out = process_data(10); // Called with 1 argument, expected 2
  end

endmodule
