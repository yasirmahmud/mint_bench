module parent_ex1_top (input [3:0] signal_a);
    // The 'unused_data_out' wire is removed as it was set but not read, resolving W528.
    child_ex1 u_child_inst (
        .data_in(signal_a), // data_in width now matches signal_a (4-bit), resolving W110
        .data_out() // Output of child_ex1 is intentionally left unconnected as it's not used by parent_ex1_top, resolving W528.
    );
endmodule
