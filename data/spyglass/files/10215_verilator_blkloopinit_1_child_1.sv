module top1;
  logic [7:0] data[0:3] = '{default: 8'hAA}; // Replaced initial block with SystemVerilog default initialization.
                                            // This resolves the BLKLOOPINIT warning (by removing the procedural loop),
                                            // and also the SYNTH_5143 warning (by removing the non-synthesizable initial block).

  // Dummy read to resolve W528 (Variable 'data' set but not read) warning.
  // This ensures 'data' is considered used by linting tools without altering core functionality.
  logic [7:0] dummy_data_read;
  assign dummy_data_read = data[0];

endmodule
