module PortDeclOrder_ML_ex1 (a, b);
 input b;
 input a;

 (* DONT_TOUCH = "TRUE" *) reg dummy_a_val; // Dummy register to consume input 'a'
 (* DONT_TOUCH = "TRUE" *) reg dummy_b_val; // Dummy register to consume input 'b'

 // Assign inputs to dummy registers to resolve W240 (inputs declared but not read)
 always @(*) begin
  dummy_a_val = a;
  dummy_b_val = b;
 end

endmodule
