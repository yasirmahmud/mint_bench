module UncoveredEnumCase_ex1;
 typedef enum {STATE_A, STATE_B, STATE_C} my_state_t;
 reg my_state_t current_state; // Declare current_state as reg to allow assignment

 // Assign an initial value to 'current_state' to resolve the "read but never set" violation.
 // This provides a defined starting state without altering the combinational logic structure.
 initial begin
  current_state = STATE_A;
 end

 always @(*) begin
  case (current_state)
   STATE_A: ;
   STATE_B: ;
   STATE_C: ; // Added STATE_C to cover all enumerated cases and resolve UncoveredEnumCase-ML
   default: ; // Added a default case for robustness and to cover any unexpected values
  endcase
 end
endmodule
