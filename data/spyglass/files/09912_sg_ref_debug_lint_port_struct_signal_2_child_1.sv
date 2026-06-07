typedef struct { bit a;
 bit b;
 } my_struct_t;
 module my_module_ex2 (input my_struct_t my_struct_port);
    // To resolve W240 warnings, read the input port members
    // The values are assigned to dummy internal signals.
    bit dummy_a;
    bit dummy_b;

    assign dummy_a = my_struct_port.a;
    assign dummy_b = my_struct_port.b;
 endmodule
