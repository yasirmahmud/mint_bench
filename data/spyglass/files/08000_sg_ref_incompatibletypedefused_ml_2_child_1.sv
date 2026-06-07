typedef struct packed { reg [7:0] a;
 reg [7:0] b;
 } my_struct_type1;
 typedef struct packed { reg [15:0] c;
 } my_struct_type2;
 module incompatible_typedef_ex2;
 my_struct_type1 var1;
 my_struct_type2 var2;

 initial begin
   // Initialize var1 members to resolve "read but never set" violations
   var1.a = 8'hAA;
   var1.b = 8'hBB;
 end

 // Explicitly assign the concatenated bits of var1 to var2.c
 // This resolves the "IncompatibleTypedefUsed-ML" issue by avoiding direct struct-to-struct assignment
 // of different types and ensures type compatibility for the assignment.
 assign var2.c = {var1.a, var1.b};

 // Add a dummy read for var2.c to resolve the "set but not read" violation
 logic [15:0] var2_monitor_dummy_read; // Declare a local signal to consume the value
 assign var2_monitor_dummy_read = var2.c; // Assign var2.c to a signal that is 'read'

 endmodule
