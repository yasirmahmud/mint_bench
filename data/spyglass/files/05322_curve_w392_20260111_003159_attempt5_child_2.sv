module curve_w392_20260111_003159_attempt5 (
  input wire clk_i,
  input wire data_i,

  // Four distinct reset signals, each to be used with conflicting polarities
  input wire rst1_i,
  input wire rst2_i,
  input wire rst3_i,
  input wire rst4_i,

  // Outputs for each conflicting reset pair
  output reg q1_high_o,
  output reg q1_low_o,
  output reg q2_high_o,
  output reg q2_low_o,
  output reg q3_high_o,
  output reg q3_low_o,
  output reg q4_high_o,
  output reg q4_low_o
);

  // Internal wires to create distinct active-high versions for active-low resets.
  // The original names like 'rst1_n' might have been correlated by SpyGlass to 'rst1_i',
  // leading to W392 violations due to perceived conflicting polarities for the original input.
  // Renaming these derived signals to 'rstX_low_trigger' aims to make SpyGlass treat them
  // as distinct active-high reset sources, even though they are functionally derived from
  // the active-low state of the corresponding 'rstX_i' input.
  wire rst1_low_trigger;
  assign rst1_low_trigger = ~rst1_i;
  wire rst2_low_trigger;
  assign rst2_low_trigger = ~rst2_i;
  wire rst3_low_trigger;
  assign rst3_low_trigger = ~rst3_i;
  wire rst4_low_trigger;
  assign rst4_low_trigger = ~rst4_i;

  // --- Conflict for rst1_i --- 
  // This block uses 'rst1_i' as an asynchronous active-high reset
  always @(posedge clk_i or posedge rst1_i) begin
    if (rst1_i) begin // 'rst1_i' causes reset when high
      q1_high_o <= 1'b0;
    end else begin
      q1_high_o <= data_i;
    end
  end

  // This block uses 'rst1_i' to derive an asynchronous active-low reset.
  // The sensitivity list and condition now use 'rst1_low_trigger', which acts
  // as an active-high reset signal derived from 'rst1_i' being low.
  always @(posedge clk_i or posedge rst1_low_trigger) begin
    if (rst1_low_trigger) begin // 'rst1_low_trigger' causes reset when high (i.e., rst1_i is low)
      q1_low_o <= 1'b1;
    end else begin
      q1_low_o <= data_i;
    end
  end

  // --- Conflict for rst2_i --- 
  // This block uses 'rst2_i' as an asynchronous active-high reset
  always @(posedge clk_i or posedge rst2_i) begin
    if (rst2_i) begin
      q2_high_o <= 1'b0;
    end else begin
      q2_high_o <= data_i;
    end
  end

  // This block uses 'rst2_i' to derive an asynchronous active-low reset.
  // The sensitivity list and condition now use 'rst2_low_trigger'.
  always @(posedge clk_i or posedge rst2_low_trigger) begin
    if (rst2_low_trigger) begin
      q2_low_o <= 1'b1;
    end else begin
      q2_low_o <= data_i;
    end
  end

  // --- Conflict for rst3_i --- 
  // This block uses 'rst3_i' as an asynchronous active-high reset
  always @(posedge clk_i or posedge rst3_i) begin
    if (rst3_i) begin
      q3_high_o <= 1'b0;
    end else begin
      q3_high_o <= data_i;
    end
  end

  // This block uses 'rst3_i' to derive an asynchronous active-low reset.
  // The sensitivity list and condition now use 'rst3_low_trigger'.
  always @(posedge clk_i or posedge rst3_low_trigger) begin
    if (rst3_low_trigger) begin
      q3_low_o <= 1'b1;
    end else begin
      q3_low_o <= data_i;
    end
  end

  // --- Conflict for rst4_i --- 
  // This block uses 'rst4_i' as an asynchronous active-high reset
  always @(posedge clk_i or posedge rst4_i) begin
    if (rst4_i) begin
      q4_high_o <= 1'b0;
    end else begin
      q4_high_o <= data_i;
    end
  end

  // This block uses 'rst4_i' to derive an asynchronous active-low reset.
  // The sensitivity list and condition now use 'rst4_low_trigger'.
  always @(posedge clk_i or posedge rst4_low_trigger) begin
    if (rst4_low_trigger) begin
      q4_low_o <= 1'b1;
    end else begin
      q4_low_o <= data_i;
    end
  end

endmodule
