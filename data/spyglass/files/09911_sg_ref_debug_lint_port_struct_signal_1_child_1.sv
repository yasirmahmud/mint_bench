typedef struct { logic a;
 logic b;
 } my_struct_t;
 module my_module_ex1 (input my_struct_t data_in);
    // Fix for W240: Read the inputs to prevent 'declared but not read' warnings
    logic dummy_read_a;
    logic dummy_read_b;

    assign dummy_read_a = data_in.a;
    assign dummy_read_b = data_in.b;
 endmodule
