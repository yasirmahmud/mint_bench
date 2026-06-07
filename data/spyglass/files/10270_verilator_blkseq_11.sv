module blkseq_ex11 (
  input clk,
  input [6:0] data,
  output reg [6:0] pipeline_stage1,
  output reg [6:0] pipeline_stage2
);

  always_ff @(posedge clk) begin
    pipeline_stage1 = data; // Triggers BLKSEQ
    pipeline_stage2 = pipeline_stage1; // Triggers BLKSEQ
  end

endmodule
