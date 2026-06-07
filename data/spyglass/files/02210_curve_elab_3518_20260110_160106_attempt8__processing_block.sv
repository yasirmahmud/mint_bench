module processing_block (
  input wire data_in,
  output wire data_out
);
  parameter DELAY_TIME = 1; // Integer parameter

  // Simple assignment to avoid unused signals or latches
  assign data_out = data_in;
endmodule
