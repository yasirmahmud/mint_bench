module duplicate_port_ex2 (idle);
 input [1:0] idle;

 // The previous fix for W240 introduced W528 for '_unused_idle_read_bus_fix_'.
 // Removing the unused wire and its assignment resolves W528 without affecting functional behavior.
 // If W240 reappears for 'idle', it should be addressed using SpyGlass directives or by 
 // removing the 'idle' port if it's truly redundant per 'DuplicatePort-ML' context, 
 // but that is outside the scope of fixing the current W528.

 endmodule
