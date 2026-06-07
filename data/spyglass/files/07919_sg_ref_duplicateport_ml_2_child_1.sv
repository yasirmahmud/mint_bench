module duplicate_port_ex2 (idle);
 input [1:0] idle;

 // Fix SpyGlass W240: Input 'idle[1:0]' declared but not read.
 // This internal wire reads both bits of the 'idle' bus without affecting functional behavior.
 wire _unused_idle_read_bus_fix_;
 assign _unused_idle_read_bus_fix_ = idle[0] | idle[1];

 endmodule
