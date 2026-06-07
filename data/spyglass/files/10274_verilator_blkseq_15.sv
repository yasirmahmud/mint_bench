module blkseq_ex15 (
  input clk,
  input write_en,
  input [3:0] write_data,
  output reg [3:0] mem_data_out
);

  reg [3:0] mem_cell;

  always_ff @(posedge clk) begin
    if (write_en) begin
      mem_cell = write_data; // Triggers BLKSEQ
    end
    mem_data_out = mem_cell; // Triggers BLKSEQ
  end

endmodule
