module parent_ex1_top (input [3:0] signal_a);
    wire [3:0] unused_data_out; // Declare a wire for the new output from child_ex1
    child_ex1 u_child_inst (
        .data_in(signal_a), // data_in width now matches signal_a (4-bit), resolving W110
        .data_out(unused_data_out) // Connect the new output to prevent other potential linting issues
    );
endmodule
