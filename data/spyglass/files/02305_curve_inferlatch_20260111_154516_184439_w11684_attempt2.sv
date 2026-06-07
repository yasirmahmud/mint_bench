module lemming (
  input wire [1:0] control_sel,
  input wire [2:0] data_val,
  output wire [2:0] latched_out
);

  // This internal register will infer a latch
  reg [2:0] ns;

  always @(control_sel or data_val) begin
    case (control_sel)
      2'b00: begin
        ns = data_val;
      end
      2'b01: begin
        ns = data_val + 3'd1;
      end
      // For 'control_sel' values 2'b10 and 2'b11, 'ns' is not assigned.
      // This implies 'ns' holds its previous value, thus inferring a latch.
    endcase
  end

  assign latched_out = ns;

endmodule
