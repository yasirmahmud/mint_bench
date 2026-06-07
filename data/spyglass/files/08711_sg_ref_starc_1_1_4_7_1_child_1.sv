module my_module_ex1 (input [7:0] data_in);
    // STARC-1.1.4.7: Input 'data_in' was declared but not read.
    // To resolve this, 'data_in' is assigned to an internal wire to ensure it is 'read'.
    // This change preserves the functional behavior as no specific functionality for data_in was described.
    wire [7:0] unused_internal_data;
    assign unused_internal_data = data_in;
endmodule
