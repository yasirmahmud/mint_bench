module sub_module_ex1(input in_port);
 // Removed 'internal_wire' and its assignment as it was set but not read (W528 violation).
 // This change preserves functional behavior as the wire was unused.
 endmodule
