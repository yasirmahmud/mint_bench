module curve_w392_20260111_003159_attempt6 (
  input wire clk_i,
  input wire data_i,

  // Four distinct reset signals, each to be used with conflicting polarities
  input wire rst_a_i,
  input wire rst_b_i,
  input wire rst_c_i,
  input wire rst_d_i,

  // Outputs for each conflicting reset pair
  output reg q_a_pos_o,
  output reg q_a_neg_o,
  output reg q_b_pos_o,
  output reg q_b_neg_o,
  output reg q_c_pos_o,
  output reg q_c_neg_o,
  output reg q_d_pos_o,
  output reg q_d_neg_o
);

  // --- Conflict for rst_a_i (Causes W392 #1) ---
  // This block uses 'rst_a_i' as an asynchronous active-high reset
  always @(posedge clk_i or posedge rst_a_i) begin
    if (rst_a_i) begin // 'rst_a_i' resets when high
      q_a_pos_o <= 1'b0;
    end else begin
      q_a_pos_o <= data_i;
    end
  end

  // This block uses 'rst_a_i' as an asynchronous active-low reset
  always @(posedge clk_i or negedge rst_a_i) begin
    if (!rst_a_i) begin // 'rst_a_i' resets when low
      q_a_neg_o <= 1'b1;
    end else begin
      q_a_neg_o <= data_i;
    
    end
  end

  // --- Conflict for rst_b_i (Causes W392 #2) ---
  // This block uses 'rst_b_i' as an asynchronous active-high reset
  always @(posedge clk_i or posedge rst_b_i) begin
    if (rst_b_i) begin
      q_b_pos_o <= 1'b0;
    end else begin
      q_b_pos_o <= data_i;
    end
  end

  // This block uses 'rst_b_i' as an asynchronous active-low reset
  always @(posedge clk_i or negedge rst_b_i) begin
    if (!rst_b_i) begin
      q_b_neg_o <= 1'b1;
    end else begin
      q_b_neg_o <= data_i;
    end
  end

  // --- Conflict for rst_c_i (Causes W392 #3) ---
  // This block uses 'rst_c_i' as an asynchronous active-high reset
  always @(posedge clk_i or posedge rst_c_i) begin
    if (rst_c_i) begin
      q_c_pos_o <= 1'b0;
    end else begin
      q_c_pos_o <= data_i;
    end
  end

  // This block uses 'rst_c_i' as an asynchronous active-low reset
  always @(posedge clk_i or negedge rst_c_i) begin
    if (!rst_c_i) begin
      q_c_neg_o <= 1'b1;
    end else begin
      q_c_neg_o <= data_i;
    end
  end

  // --- Conflict for rst_d_i (Causes W392 #4) ---
  // This block uses 'rst_d_i' as an asynchronous active-high reset
  always @(posedge clk_i or posedge rst_d_i) begin
    if (rst_d_i) begin
      q_d_pos_o <= 1'b0;
    end else begin
      q_d_pos_o <= data_i;
    end
  end

  // This block uses 'rst_d_i' as an asynchronous active-low reset
  always @(posedge clk_i or negedge rst_d_i) begin
    if (!rst_d_i) begin
      q_d_neg_o <= 1'b1;
    end else begin
      q_d_neg_o <= data_i;
    end
  end

endmodule
