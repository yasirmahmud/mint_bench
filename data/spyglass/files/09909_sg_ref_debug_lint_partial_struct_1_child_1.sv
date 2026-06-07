module partial_struct_ex1;
 typedef struct { logic a;
 logic b;
 } my_struct_t;
 my_struct_t s_var;

 // Resolved SYNTH_5143 (initial block ignored for synthesis) by using assign statements.
 // This preserves the functional intent that s_var.a is always 1'b1.
 assign s_var.a = 1'b1;

 // Resolved DEBUG_LINT_PARTIAL_STRUCT by assigning a default value to s_var.b.
 // This ensures all members of the struct s_var are driven, even if s_var.b was not explicitly used in the original design.
 assign s_var.b = 1'b0;

 // Removed 'read_a' and its assignment to resolve W528 (variable set but not read).
 // The variable 'read_a' was internal and its value was never utilized.

 endmodule
