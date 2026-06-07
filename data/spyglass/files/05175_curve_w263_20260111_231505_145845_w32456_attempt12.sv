module curve_w263_20260111_231505_145845_w32456_attempt12 (
    input wire [3:0] address_select,
    output reg        data_valid
);

  // This always block generates a combinational output.
  always @(*) begin
    // Default assignment to avoid inferring a latch.
    data_valid = 1'b0;

    // W263: Case label width does not match selector width.
    // The selector 'address_select' is 4 bits wide (defined as [3:0]).
    // The case label '3'd2' has a width of 3 bits,
    // which does not match the selector width of 4 bits.
    // This intentional mismatch triggers exactly one W263 violation.
    case (address_select)
      3'd2: begin // Case label (3 bits) vs selector (4 bits) triggers W263
        data_valid = 1'b1;
      end
      4'd5: begin // This label matches the selector width (4 bits)
        data_valid = 1'b0;
      end
      default: begin
        data_valid = 1'b0;
      end
    endcase
  end

endmodule
