module curve_stx_ve_1182_20260111_214138_657202_w38092_attempt12 (
  input wire [1:0] in_port,
  output wire [1:0] out_port
);

  // Declare 'loop_idx' as integer instead of genvar to trigger STX_VE_1182
  integer loop_idx;

  generate
    for (loop_idx = 0; loop_idx < 2; loop_idx = loop_idx + 1) begin : gen_loop_block
      // Minimal logic inside the generate block to avoid other warnings
      // Each generated block will have its own local connection
      wire local_connection;
      assign local_connection = in_port[loop_idx];
      assign out_port[loop_idx] = local_connection;
    end
  endgenerate

endmodule
