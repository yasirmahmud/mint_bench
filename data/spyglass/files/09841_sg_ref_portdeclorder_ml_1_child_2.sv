module PortDeclOrder_ML_ex1 (a, b);
 input b;
 input a;

 (* DONT_TOUCH = "TRUE" *) wire dummy_a_val; // Dummy wire to consume input 'a'
 (* DONT_TOUCH = "TRUE" *) wire dummy_b_val; // Dummy wire to consume input 'b'

 // Assign inputs to dummy wires to resolve W240 (inputs declared but not read)
 assign dummy_a_val = a;
 assign dummy_b_val = b;

endmodule
