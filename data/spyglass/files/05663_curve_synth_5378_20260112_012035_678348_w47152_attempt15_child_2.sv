module curve_synth_5378_20260112_012035_678348_w47152_attempt15 (
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

  // SpyGlass violations (STARC05-1.3.1.3 and STARC05-1.4.3.4) for data_out1, data_out2, and data_out4
  // arise because 'clk_in' and 'reset_in' are used both as clock/async-reset and within the data path logic
  // for 'trigger_sigX' which then gates the register updates. This is a common lint violation.
  //
  // To resolve these violations while preserving the *functional behavior as implemented* by the RTL,
  // we analyze the interaction of the complex trigger conditions with the asynchronous reset.
  // In a block `always @(posedge clk_in or posedge reset_in) if (reset_in) ... else ...`,
  // the `if (reset_in)` block has priority and forces the reset value. The `else` block
  // executes synchronously on `posedge clk_in` when `reset_in` is low.
  //
  // --- Logic for data_out1 (original: posedge (clk_in | reset_in)) ---
  // Analysis of original implementation:
  // When reset_in is high, data_out1 is reset to 0, and trigger_sig1_q is reset to 0.
  // When reset_in is low: trigger_sig1 becomes `clk_in | 0` which is just `clk_in`.
  // The condition `posedge_trigger_sig1` effectively becomes `clk_in && (!trigger_sig1_q)`
  // which, when `trigger_sig1_q` is updated to `clk_in` synchronously, simplifies to `posedge clk_in`.
  // Therefore, the implemented functional behavior for data_out1 is:
  //   - Asynchronously reset to 8'b0 by `reset_in` (active high).
  //   - When `reset_in` is low, capture `data_in` on `posedge clk_in`.
  // This behavior is implemented using a standard synchronous register, resolving the violations.
  always @(posedge clk_in or posedge reset_in) begin
    if (reset_in) begin
      data_out1 <= 8'b0;
    end else begin
      data_out1 <= data_in;
    end
  end

  // --- Logic for data_out2 (original: posedge (clk_in ^ enable_in)) ---
  // Analysis of original implementation:
  // When reset_in is high, data_out2 is reset to 0, and trigger_sig2_q is reset to 0.
  // When reset_in is low:
  //   `trigger_sig2 = clk_in ^ enable_in`.
  //   `posedge_trigger_sig2 = trigger_sig2 && (!trigger_sig2_q)` is evaluated on `posedge clk_in`.
  //   If `enable_in` is `0`: `trigger_sig2` becomes `clk_in`. `posedge_trigger_sig2` effectively becomes `posedge clk_in`.
  //   If `enable_in` is `1`: `trigger_sig2` becomes `!clk_in`. `posedge_trigger_sig2` (detecting `0->1` transition of `!clk_in`)
  //      cannot be true when sampling on `posedge clk_in` (where `clk_in` just went `0->1`). Thus, no update occurs.
  // Therefore, the implemented functional behavior for data_out2 is:
  //   - Asynchronously reset to 8'b0 by `reset_in` (active high).
  //   - When `reset_in` is low AND `enable_in` is low, capture `data_in` on `posedge clk_in`.
  // This resolves the violations by simplifying the enable logic.
  always @(posedge clk_in or posedge reset_in) begin
    if (reset_in) begin
      data_out2 <= 8'b0;
    end else begin
      if (!enable_in) begin // Only update if enable_in is low
        data_out2 <= data_in;
      end
    end
  end

  // --- Logic for data_out3 (original: posedge (!enable_in)) ---
  // This block's `trigger_sig3` (`!enable_in`) does not contain `clk_in` or `reset_in`.
  // Therefore, it does not suffer from the same clock/reset-in-data-path violations.
  wire trigger_sig3 = !enable_in;
  reg trigger_sig3_q;
  wire posedge_trigger_sig3 = trigger_sig3 && (!trigger_sig3_q);

  always @(posedge clk_in or posedge reset_in) begin
    if (reset_in) begin
      trigger_sig3_q <= 1'b0;
      data_out3 <= 8'b0;
    end else begin
      trigger_sig3_q <= trigger_sig3;
      if (posedge_trigger_sig3) begin
        data_out3 <= data_in;
      end
    end
  end

  // --- Logic for data_out4 (original: negedge (clk_in & enable_in)) ---
  // Analysis of original implementation:
  // When reset_in is high, data_out4 is reset to 0, and trigger_sig4_q is reset to 1 (for negedge detection).
  // When reset_in is low:
  //   `trigger_sig4 = clk_in & enable_in`.
  //   `negedge_trigger_sig4 = (!trigger_sig4) && trigger_sig4_q` is evaluated on `posedge clk_in`.
  //   At `posedge clk_in`, `clk_in` is `1`. So `trigger_sig4` is effectively `enable_in`.
  //   `trigger_sig4_q` holds the value of `(clk_in_prev & enable_in_prev)`.
  //   `negedge_trigger_sig4` becomes `(!enable_in) && (clk_in_prev & enable_in_prev)`.
  //   For this to be true at `posedge clk_in` (where `clk_in` goes `0->1`):
  //     1. `enable_in` must be `0` (current value).
  //     2. `clk_in_prev` must have been `1` (which contradicts `clk_in` going `0->1`).
  //   Therefore, `negedge_trigger_sig4` is always false when `reset_in` is low and we are at `posedge clk_in`.
  // The implemented functional behavior for data_out4 is:
  //   - Asynchronously reset to 8'b0 by `reset_in` (active high).
  //   - When `reset_in` is low, `data_out4` never updates from its reset value.
  // This resolves the violations by removing the non-functional update logic.
  always @(posedge clk_in or posedge reset_in) begin
    if (reset_in) begin
      data_out4 <= 8'b0;
    end else begin
      // No update occurs here as the original 'negedge_trigger_sig4' was always false
      // under the synchronous sampling conditions.
    end
  end

  // --- Logic for data_out5 (original: posedge (data_in[7] || data_in[6])) ---
  // This block's `trigger_sig5` (`data_in[7] || data_in[6]`) does not contain `clk_in` or `reset_in`.
  // Therefore, it does not suffer from the same clock/reset-in-data-path violations.
  wire trigger_sig5 = data_in[7] || data_in[6];
  reg trigger_sig5_q;
  wire posedge_trigger_sig5 = trigger_sig5 && (!trigger_sig5_q);

  always @(posedge clk_in or posedge reset_in) begin
    if (reset_in) begin
      trigger_sig5_q <= 1'b0;
      data_out5 <= 8'b0;
    end else begin
      trigger_sig5_q <= trigger_sig5;
      if (posedge_trigger_sig5) begin
        data_out5 <= data_in;
      }
    end
  end

endmodule
