module blkseq_ex6 (
  input clk,
  input [1:0] sel,
  input [15:0] d0,
  input [15:0] d1,
  output reg [15:0] mux_out
);

  always @(posedge clk) begin
    case (sel)
      2'b00: mux_out = d0;
      2'b01: mux_out = d1;
      default: mux_out = 16'h0000;
    endcase // Triggers BLKSEQ
  end

endmodule
