module test16;
  logic [63:0] dma_buffer;
  logic [15:0] dma_word;
  assign dma_word = dma_buffer[16 +: 16];
endmodule
