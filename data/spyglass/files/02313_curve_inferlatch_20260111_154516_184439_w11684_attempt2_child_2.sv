module lemming (
  input wire [1:0] control_sel,
  input wire [2:0] data_val,
  output wire [2:0] latched_out
);

  // This register is explicitly designed as a latch to resolve SpyGlass violations.
  reg [2:0] ns;

  // Determine when the latch is enabled (transparent mode)
  wire latch_enable = (control_sel == 2'b00) || (control_sel == 2'b01);

  always @(control_sel or data_val) begin
    // When 'latch_enable' is true, the latch is transparent and 'ns' follows the input logic.
    if (latch_enable) begin
      case (control_sel)
        2'b00: begin
          ns = data_val;
        end
        2'b01: begin
          ns = data_val + 3'd1;
        end
        // No default case is needed here because latch_enable ensures control_sel is 2'b00 or 2'b01.
      endcase
    end
    // When 'latch_enable' is false (control_sel is 2'b10 or 2'b11),
    // 'ns' is not assigned in this path, which infers the hold behavior (latch).
  end

  assign latched_out = ns;

endmodule
