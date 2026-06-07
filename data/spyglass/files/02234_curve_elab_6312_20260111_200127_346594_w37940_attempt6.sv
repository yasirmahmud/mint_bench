module curve_elab_6312_20260111_200127_346594_w37940_attempt6 (
  input clk,
  input rst_n,
  input clk_en,
  input [7:0] data_in,
  output reg [7:0] data_out
);

  // The 'iff' construct in the always sensitivity list is a SystemVerilog feature
  // and is not supported in Verilog-2001, triggering ELAB_6312.
  always @(posedge clk iff clk_en or negedge rst_n) begin
    if (!rst_n) begin
      data_out <= 8'h00;
    end else begin
      data_out <= data_in;
    end
  end

endmodule
