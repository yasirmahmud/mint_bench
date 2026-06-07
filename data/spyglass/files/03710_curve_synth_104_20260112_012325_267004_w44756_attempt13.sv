module curve_synth_104_20260112_012325_267004_w44756_attempt13 (
  input wire        clk,
  input wire        rst_n, // Active low reset
  input wire  [7:0] in_data,
  output reg  [7:0] out_data
);

  reg [7:0] data_a;
  reg [7:0] data_b;
  reg [7:0] data_c;

  // Initial assignments for registers to ensure they are driven
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_a <= 8'h00;
      data_b <= 8'h00;
      data_c <= 8'h00;
    end else begin
      data_a <= in_data;
      data_b <= in_data + 1;
      data_c <= in_data + 2;
    end
  end

  // SYNTH_104 trigger #1: DEASSIGN statements are not synthesizable
  // Deassign data_a on positive edge of clk
  always @(posedge clk) begin
    deassign data_a;
  end

  // SYNTH_104 trigger #2: DEASSIGN statements are not synthesizable
  // Deassign data_b on negative edge of clk
  always @(negedge clk) begin
    deassign data_b;
  end

  // SYNTH_104 trigger #3: DEASSIGN statements are not synthesizable
  // Deassign data_c when rst_n goes high
  always @(posedge rst_n) begin
    deassign data_c;
  end

  // Use the registers (even though they are deassigned) to avoid unused signal warnings
  always @* begin
    out_data = data_a ^ data_b ^ data_c;
  end

endmodule
