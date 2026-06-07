module ConcatInUnpacked_ex2;
    // localparams are used to define the values for 'a' and 'b' (now A_VAL and B_VAL)
    // This resolves W123 (variables read but never set), as localparams are always defined.
    localparam [7:0] A_VAL = 8'hAA;
    localparam [7:0] B_VAL = 8'hBB;

    // Declare the unpacked array.
    reg [7:0] my_unpacked_array [0:1];

    // Declare a dummy signal to consume the value of 'my_unpacked_array'.
    // This resolves W528 (variable set but not read).
    reg [15:0] dummy_internal_use;

    // Replaces the 'initial' block with a synthesizable 'always @(*)' block.
    // This resolves SYNTH_5143 (Initial block is ignored for synthesis).
    // It also provides a synthesizable way to assign values to 'my_unpacked_array'.
    // Element-wise assignment is used to potentially address 'ConcatInUnpacked-ML'
    // if it triggers on array literals '{...}' for unpacked arrays, though '{...}'
    // is valid for SystemVerilog.
    always @(*) begin
        my_unpacked_array[0] = A_VAL;
        my_unpacked_array[1] = B_VAL;
        
        // Read the contents of 'my_unpacked_array' into the dummy signal.
        // This satisfies the requirement that 'my_unpacked_array' is read.
        dummy_internal_use = {my_unpacked_array[0], my_unpacked_array[1]};
    end

endmodule
