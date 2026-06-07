module curve_w528_20260111_161032_084073_w21676_attempt4 (
    input clk,
    input rst_n,
    input [7:0] data_in,
    output [7:0] data_out
);

  // W528 violation: 'unused_static_wire' is assigned but never read.
  wire [7:0] unused_static_wire = 8'h5A; // Set, but not read

  // A simple register to ensure data_in is used and data_out is driven.
  reg [7:0] data_out_reg;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_out_reg <= 8'h0;
    end else begin
      data_out_reg <= data_in; // data_in used here to avoid unused input warning
    end
  end

  assign data_out = data_out_reg; // data_out driven here to avoid unused output warning

endmodule
