module UncoveredEnumCase_ex1;
 typedef enum {STATE_A, STATE_B, STATE_C} my_state_t;
 my_state_t current_state;
 always @(*) begin case (current_state) STATE_A: ;
 STATE_B: ;
 endcase end endmodule
