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

  // For Occurrence 1: posedge (clk_in | reset_in)
  // Detect the rising edge of the complex expression synchronously to clk_in.
  // data_out1 is updated on posedge clk_in when this rising edge is detected.
  wire trigger_1_val = clk_in | reset_in;
  reg trigger_1_val_q;
  wire trigger_1_posedge = trigger_1_val && !trigger_1_val_q;

  // For Occurrence 2: posedge (clk_in & enable_in)
  wire trigger_2_val = clk_in & enable_in;
  reg trigger_2_val_q;
  wire trigger_2_posedge = trigger_2_val && !trigger_2_val_q;

  // For Occurrence 3: posedge (clk_in ^ reset_in)
  wire trigger_3_val = clk_in ^ reset_in;
  reg trigger_3_val_q;
  wire trigger_3_posedge = trigger_3_val && !trigger_3_val_q;

  // For Occurrence 4: posedge (~clk_in | reset_in)
  wire trigger_4_val = ~clk_in | reset_in;
  reg trigger_4_val_q;
  wire trigger_4_posedge = trigger_4_val && !trigger_4_val_q;

  // For Occurrence 5: posedge (clk_in & ~enable_in)
  wire trigger_5_val = clk_in & ~enable_in;
  reg trigger_5_val_q;
  wire trigger_5_posedge = trigger_5_val && !trigger_5_val_q;

  // Register for data_out1 (and its trigger detection flop)
  always @(posedge clk_in or posedge reset_in) begin
    if (reset_in) begin
      trigger_1_val_q <= 1'b0; // Reset internal trigger detection flop
      data_out1 <= 8'b0;       // Reset output register to default value
    end else begin
      trigger_1_val_q <= trigger_1_val;
      if (trigger_1_posedge) begin
        data_out1 <= data_in;
      end
    end
  end

  // Register for data_out2 (and its trigger detection flop)
  always @(posedge clk_in or posedge reset_in) begin
    if (reset_in) begin
      trigger_2_val_q <= 1'b0;
      data_out2 <= 8'b0;
    end else begin
      trigger_2_val_q <= trigger_2_val;
      if (trigger_2_posedge) begin
        data_out2 <= data_in;
      end
    end
  end

  // Register for data_out3 (and its trigger detection flop)
  always @(posedge clk_in or posedge reset_in) begin
    if (reset_in) begin
      trigger_3_val_q <= 1'b0;
      data_out3 <= 8'b0;
    end else begin
      trigger_3_val_q <= trigger_3_val;
      if (trigger_3_posedge) begin
        data_out3 <= data_in;
      end
    end
  end

  // Register for data_out4 (and its trigger detection flop)
  always @(posedge clk_in or posedge reset_in) begin
    if (reset_in) begin
      trigger_4_val_q <= 1'b0;
      data_out4 <= 8'b0;
    end else begin
      trigger_4_val_q <= trigger_4_val;
      if (trigger_4_posedge) begin
        data_out4 <= data_in;
      end
    end
  end

  // Register for data_out5 (and its trigger detection flop)
  always @(posedge clk_in or posedge reset_in) begin
    if (reset_in) begin
      trigger_5_val_q <= 1'b0;
      data_out5 <= 8'b0;
    end else begin
      trigger_5_val_q <= trigger_5_val;
      if (trigger_5_posedge) begin
        data_out5 <= data_in;
      end
    end
  end

endmodule
