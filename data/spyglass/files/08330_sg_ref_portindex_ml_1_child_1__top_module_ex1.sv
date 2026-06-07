module top_module_ex1 ();
    // Fix W156: Bus net 'data_in' is connected in reverse.
    // Change bit ordering of my_data to match data_in.
    // Fix UndrivenInTerm-ML & W287a: Detected undriven input terminal.
    wire [3:0] my_data;

    // Drive my_data to resolve undriven input warnings/errors.
    assign my_data = 4'h0;

    sub_module_ex1 u_sub (.data_in(my_data));
endmodule
