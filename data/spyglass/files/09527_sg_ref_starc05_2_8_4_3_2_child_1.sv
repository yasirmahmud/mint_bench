module star_ex2_module (input [1:0] sel, output reg out);
  always @(*) begin
    case (sel)
      2'b00: out = 1'b0;
      2'b01: out = 1'b1;
      default: begin
        // For 'default' (2'b10, 2'b11), original 'case' assigned 1'bx.
        // Original 'casex' assigned 1'b1 for 2'b1x.
        // To resolve the multiple-driver conflict, we prioritize the definite assignment from 'casex'.
        casex (sel)
          2'b1x: out = 1'b1;
          default: out = 1'bx; // Should not be hit for 2-bit sel but for completeness
        endcasex
      end
    endcase
  end
endmodule
