module curve_w263_20260111_231505_145845_w32456_attempt11 (
    input wire [2:0] control_sig,
    output reg        status_flag
);

  // This always block generates a combinational output.
  always @(*) begin
    // Default assignment to avoid inferring a latch.
    status_flag = 1'b0;

    // W263: Case label width does not match selector width.
    // The selector 'control_sig' is 3 bits wide (defined as [2:0]).
    // The case label '4'd5' has a width of 4 bits,
    // which does not match the selector width of 3 bits.
    // This intentional mismatch triggers exactly one W263 violation.
    case (control_sig)
      4'd5: begin // Case label (4 bits) vs selector (3 bits) triggers W263
        status_flag = 1'b1;
      end
      3'd2: begin // This label matches the selector width (3 bits)
        status_flag = 1'b0;
      end
      default: begin
        status_flag = 1'b0;
      end
    endcase
  end

endmodule
