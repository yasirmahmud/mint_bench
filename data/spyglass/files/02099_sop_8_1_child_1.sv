module sop_8_1(input a,b,c,d,output y);
  // Implement the 8-to-1 multiplexer directly to resolve the black-box violation.
  // The select lines are {a, b, c} where 'a' is MSB and 'c' is LSB.
  // The inputs are mapped as per the original mux8_1 instantiation.
  wire [2:0] sel = {a, b, c};

  assign y = (sel == 3'b000) ? d :
             (sel == 3'b001) ? d :
             (sel == 3'b010) ? (~d) :
             (sel == 3'b011) ? 1'b0 :
             (sel == 3'b100) ? 1'b0 :
             (sel == 3'b101) ? d :
             (sel == 3'b110) ? 1'b1 :
             (sel == 3'b111) ? 1'b1 :
             1'bx; // Default to 'x' for completeness, though all select cases are covered.

endmodule
