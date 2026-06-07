typedef struct { logic a;
 logic b;
 } my_struct_t;
 module my_module_ex1 (input my_struct_t data_in);
    // The previous 'dummy_read_a' and 'dummy_read_b' signals were introduced
    // to address a potential 'declared but not read' warning for 'data_in.a' and 'data_in.b'.
    // However, these dummy signals themselves were 'set but not read', leading to W528 violations.
    // Removing these unused internal signals directly resolves the W528 violations
    // without altering the functional behavior of the module, as they had no functional purpose.
 endmodule
