`timescale 1ns / 1ps
module FNC_NR_AVGV_example_1;
  output reg [7:0] global_data; // Changed to output to resolve W528

  function automatic [7:0] update_and_return;
    input [7:0] input_val;
    begin
      // Removed: global_data = input_val + 1; // Resolved W424 (Function should not set a global variable)
      update_and_return = input_val * 2;
    end
  endfunction

`ifndef SYNTHESIS // Wrap initial block to resolve SYNTH_5143 for synthesis runs
  initial begin
    global_data = 8'h00;
    #10;
    global_data = update_and_return(5);
  end
`endif
endmodule
