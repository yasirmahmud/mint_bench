module lemming (
  input wire [1:0] control_sel,
  input wire [2:0] data_val,
  output wire [2:0] latched_out
);

  // This register is explicitly designed as a latch to resolve SpyGlass violations.
  reg [2:0] ns;

  always @(control_sel or data_val or ns) begin
    // Declare a temporary variable for the next state of 'ns'.
    // By default, 'next_ns' holds the current value of 'ns', implementing the latch behavior.
    reg [2:0] next_ns = ns;

    case (control_sel)
      2'b00: begin
        next_ns = data_val;
      end
      2'b01: begin
        next_ns = data_val + 3'd1;
      end
      // For 'control_sel' values 2'b10 and 2'b11, 'next_ns' maintains its default
      // value, which is the current 'ns'. This explicitly implements the hold behavior.
      default: begin
        // Explicitly define the default case to resolve W71 violation.
        // It re-affirms that 'ns' holds its value when not actively updated.
        next_ns = ns;
      end
    endcase
    
    // Assign the determined next state to 'ns'.
    ns = next_ns;
  end

  assign latched_out = ns;

endmodule
