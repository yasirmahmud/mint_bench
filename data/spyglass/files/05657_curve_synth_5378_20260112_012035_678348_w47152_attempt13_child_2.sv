module curve_synth_5378_20260112_012035_678348_w47152_attempt13 (
  input clk_in,
  input reset_in,
  input enable_in,
  input [7:0] data_in,
  output reg [7:0] data_out1,
  output reg [7:0] data_out2,
  output reg [7:0] data_out3,
  output reg [7:0] data_out4,
  output reg [7:0] data_out5
);

  // Synchronize reset_in for use in synchronous logic paths.
  // This addresses STARC05-1.3.1.3 by ensuring original reset_in is not in data path of flops it async resets.
  reg reset_in_sync;
  always @(posedge clk_in or posedge reset_in) begin
    if (reset_in) begin
      reset_in_sync <= 1'b1; // Keep asserted during async reset
    end else begin
      reset_in_sync <= 1'b0; // Deassert synchronously
    end
  end

  // For Occurrence 1: posedge (clk_in | reset_in)
  // Detect the rising edge of the complex expression synchronously to clk_in.
  // data_out1 is updated on posedge clk_in when this rising edge is detected.
  wire combinatorial_trigger_1_val = clk_in | reset_in_sync;
  reg  combinatorial_trigger_1_val_q;
  reg  combinatorial_trigger_1_val_qq;
  wire trigger_1_posedge_comb = combinatorial_trigger_1_val_q && !combinatorial_trigger_1_val_qq;
  reg  trigger_1_enable_reg; // Flopped enable to fix STARC05-1.4.3.4

  // For Occurrence 2: posedge (clk_in & enable_in)
  wire combinatorial_trigger_2_val = clk_in & enable_in;
  reg  combinatorial_trigger_2_val_q;
  reg  combinatorial_trigger_2_val_qq;
  wire trigger_2_posedge_comb = combinatorial_trigger_2_val_q && !combinatorial_trigger_2_val_qq;
  reg  trigger_2_enable_reg;

  // For Occurrence 3: posedge (clk_in ^ reset_in)
  wire combinatorial_trigger_3_val = clk_in ^ reset_in_sync;
  reg  combinatorial_trigger_3_val_q;
  reg  combinatorial_trigger_3_val_qq;
  wire trigger_3_posedge_comb = combinatorial_trigger_3_val_q && !combinatorial_trigger_3_val_qq;
  reg  trigger_3_enable_reg;

  // For Occurrence 4: posedge (~clk_in | reset_in)
  wire combinatorial_trigger_4_val = ~clk_in | reset_in_sync;
  reg  combinatorial_trigger_4_val_q;
  reg  combinatorial_trigger_4_val_qq;
  wire trigger_4_posedge_comb = combinatorial_trigger_4_val_q && !combinatorial_trigger_4_val_qq;
  reg  trigger_4_enable_reg;

  // For Occurrence 5: posedge (clk_in & ~enable_in)
  wire combinatorial_trigger_5_val = clk_in & ~enable_in;
  reg  combinatorial_trigger_5_val_q;
  reg  combinatorial_trigger_5_val_qq;
  wire trigger_5_posedge_comb = combinatorial_trigger_5_val_q && !combinatorial_trigger_5_val_qq;
  reg  trigger_5_enable_reg;

  // Register for data_out1 (and its trigger detection flops)
  always @(posedge clk_in or posedge reset_in) begin
    if (reset_in) begin
      combinatorial_trigger_1_val_q  <= 1'b0;
      combinatorial_trigger_1_val_qq <= 1'b0;
      trigger_1_enable_reg           <= 1'b0;
      data_out1 <= 8'b0;
    end else begin
      // Sample the combinatorial trigger expression synchronously
      combinatorial_trigger_1_val_q  <= combinatorial_trigger_1_val;
      // Store previous sampled value for edge detection
      combinatorial_trigger_1_val_qq <= combinatorial_trigger_1_val_q;
      // Pipeline the enable signal to resolve "clock used as non-clock" violation
      trigger_1_enable_reg           <= trigger_1_posedge_comb;

      if (trigger_1_enable_reg) begin // Use the flopped enable
        data_out1 <= data_in;
      end
    end
  end

  // Register for data_out2 (and its trigger detection flops)
  always @(posedge clk_in or posedge reset_in) begin
    if (reset_in) begin
      combinatorial_trigger_2_val_q  <= 1'b0;
      combinatorial_trigger_2_val_qq <= 1'b0;
      trigger_2_enable_reg           <= 1'b0;
      data_out2 <= 8'b0;
    end else begin
      combinatorial_trigger_2_val_q  <= combinatorial_trigger_2_val;
      combinatorial_trigger_2_val_qq <= combinatorial_trigger_2_val_q;
      trigger_2_enable_reg           <= trigger_2_posedge_comb;

      if (trigger_2_enable_reg) begin
        data_out2 <= data_in;
      end
    end
  end

  // Register for data_out3 (and its trigger detection flops)
  always @(posedge clk_in or posedge reset_in) begin
    if (reset_in) begin
      combinatorial_trigger_3_val_q  <= 1'b0;
      combinatorial_trigger_3_val_qq <= 1'b0;
      trigger_3_enable_reg           <= 1'b0;
      data_out3 <= 8'b0;
    end else begin
      combinatorial_trigger_3_val_q  <= combinatorial_trigger_3_val;
      combinatorial_trigger_3_val_qq <= combinatorial_trigger_3_val_q;
      trigger_3_enable_reg           <= trigger_3_posedge_comb;

      if (trigger_3_enable_reg) begin
        data_out3 <= data_in;
      end
    end
  end

  // Register for data_out4 (and its trigger detection flops)
  always @(posedge clk_in or posedge reset_in) begin
    if (reset_in) begin
      combinatorial_trigger_4_val_q  <= 1'b0;
      combinatorial_trigger_4_val_qq <= 1'b0;
      trigger_4_enable_reg           <= 1'b0;
      data_out4 <= 8'b0;
    end else begin
      combinatorial_trigger_4_val_q  <= combinatorial_trigger_4_val;
      combinatorial_trigger_4_val_qq <= combinatorial_trigger_4_val_q;
      trigger_4_enable_reg           <= trigger_4_posedge_comb;

      if (trigger_4_enable_reg) begin
        data_out4 <= data_in;
      end
    end
  end

  // Register for data_out5 (and its trigger detection flops)
  always @(posedge clk_in or posedge reset_in) begin
    if (reset_in) begin
      combinatorial_trigger_5_val_q  <= 1'b0;
      combinatorial_trigger_5_val_qq <= 1'b0;
      trigger_5_enable_reg           <= 1'b0;
      data_out5 <= 8'b0;
    end else begin
      combinatorial_trigger_5_val_q  <= combinatorial_trigger_5_val;
      combinatorial_trigger_5_val_qq <= combinatorial_trigger_5_val_q;
      trigger_5_enable_reg           <= trigger_5_posedge_comb;

      if (trigger_5_enable_reg) begin
        data_out5 <= data_in;
      end
    end
  end

endmodule
