module curve_w392_20260111_222149_668514_w28836_attempt12 (
  input wire sys_clk,
  input wire rst_n_sig, // This signal will be used with mixed polarities
  input wire [3:0] input_data,
  output reg [3:0] out_reg_ph1, // 'ph' for posedge reset, high assertion
  output reg [3:0] out_reg_ph2,
  output reg [3:0] out_reg_nl1, // 'nl' for negedge reset, low assertion
  output reg [3:0] out_reg_nl2
);

  // Introduce an inverted reset signal to resolve mixed-polarity usage of rst_n_sig
  // rst_n_sig_inverted will be high when rst_n_sig is low, and low when rst_n_sig is high.
  // This allows us to use negedge for both derived reset signals while preserving original functionality.
  wire rst_n_sig_inverted = ~rst_n_sig;

  // Block 1: Uses rst_n_sig as an asynchronous active-high reset (now using rst_n_sig_inverted as active-low)
  always @(posedge sys_clk or negedge rst_n_sig_inverted) begin
    if (!rst_n_sig_inverted) begin // When rst_n_sig_inverted is low, rst_n_sig was high (active-high reset assertion)
      out_reg_ph1 <= 4'h0; // Reset to 0
    end else begin
      out_reg_ph1 <= input_data;
    end
  end

  // Block 2: Also uses rst_n_sig as an asynchronous active-high reset (now using rst_n_sig_inverted as active-low)
  always @(posedge sys_clk or negedge rst_n_sig_inverted) begin
    if (!rst_n_sig_inverted) begin // When rst_n_sig_inverted is low, rst_n_sig was high (active-high reset assertion)
      out_reg_ph2 <= 4'hF; // Reset to all ones
    end else begin
      out_reg_ph2 <= input_data + 4'h1; // Different data path logic
    end
  end

  // Block 3: Uses the *same* rst_n_sig signal as an asynchronous active-low reset
  always @(posedge sys_clk or negedge rst_n_sig) begin
    if (!rst_n_sig) begin // Active-low reset assertion
      out_reg_nl1 <= 4'hA; // Reset to a specific value
    end else begin
      out_reg_nl1 <= input_data;
    end
  end

  // Block 4: Also uses the *same* rst_n_sig signal as an asynchronous active-low reset
  always @(posedge sys_clk or negedge rst_n_sig) begin
    if (!rst_n_sig) begin // Active-low reset assertion
      out_reg_nl2 <= 4'h5; // Reset to another specific value
    end else begin
      out_reg_nl2 <= input_data - 4'h1; // Another different data path logic
    end
  end

endmodule
