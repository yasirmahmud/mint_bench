module curve_w528_20260111_161032_084073_w21676_attempt5 (
    input clk,
    input rst_n,
    input [7:0] data_in,
    output [7:0] data_out
);

  // W528 violation: 'internal_status_reg' is assigned but never read.
  reg [3:0] internal_status_reg; 

  // A simple pipeline register to ensure data_in is used and data_out is driven.
  reg [7:0] data_out_reg;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_out_reg <= 8'h00;
      internal_status_reg <= 4'h0; // Assigned, but not read
    end else begin
      data_out_reg <= data_in; // data_in used here to avoid unused input warning
      internal_status_reg <= data_in[3:0]; // Assigned, but not read
    end
  end

  assign data_out = data_out_reg; // data_out driven here to avoid unused output warning

endmodule
