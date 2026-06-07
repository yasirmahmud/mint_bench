module enum_range_ex1 (
  output logic out
);
  typedef enum { A, B } my_enum_t;
  my_enum_t state; 
  
  initial begin
    state = A; // Initialize 'state' to resolve 'read but never set' for 'state[0]' (ID 3) and make it synthesizable.
  end
  
  // 'out' is now an output port to resolve 'set but not read' (ID 4).
  // Assignment changed from 'state[0]' to 'state' to resolve EnumTypeUsedWithRange-ML (ID 2)
  // and remove the bit-select on an enum type.
  assign out = state;
endmodule
