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

  // --- Conflict for rst1_i --- 
  // This block uses 'rst1_i' as an asynchronous active-high reset
  always @(posedge clk_i or posedge rst1_i) begin
    if (rst1_i) begin // 'rst1_i' causes reset when high
      q1_high_o <= 1'b0;
    end else begin
      q1_high_o <= data_i;
    end
  end

  // This block uses 'rst1_i' as an asynchronous active-low reset
  always @(posedge clk_i or negedge rst1_i) begin
    if (!rst1_i) begin // 'rst1_i' causes reset when low
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

  // This block uses 'rst2_i' as an asynchronous active-low reset
  always @(posedge clk_i or negedge rst2_i) begin
    if (!rst2_i) begin
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

  // This block uses 'rst3_i' as an asynchronous active-low reset
  always @(posedge clk_i or negedge rst3_i) begin
    if (!rst3_i) begin
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

  // This block uses 'rst4_i' as an asynchronous active-low reset
  always @(posedge clk_i or negedge rst4_i) begin
    if (!rst4_i) begin
      q4_low_o <= 1'b1;
    end else begin
      q4_low_o <= data_i;
    end
  end

endmodule
