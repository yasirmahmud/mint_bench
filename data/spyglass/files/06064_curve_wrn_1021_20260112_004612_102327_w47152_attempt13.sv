module curve_wrn_1021_20260112_004612_102327_w47152_attempt13 ();

    // Declare a register array with a permissible range of [0:3]
    reg [7:0] data_storage[0:3];

    // Declare a dummy register to consume a valid array element
    // and avoid 'unused signal' warnings for the array itself.
    reg [7:0] dummy_output;

    initial begin
        // Initialize a valid array element. This ensures the array itself is 'used'
        // and prevents potential X-propagation warnings if dummy_output were a real output.
        data_storage[0] = 8'h0A;

        // First WRN_1021 violation: Array index 4 is out-of-bounds for the declared range [0:3].
        data_storage[4] = 8'hAA;

        // Second WRN_1021 violation: Array index 5 is out-of-bounds for the declared range [0:3].
        // Using a different out-of-bounds index ensures two distinct WRN_1021 violations
        // without generating multiple driver warnings on the same element.
        data_storage[5] = 8'hBB;

        // Assign a valid array element to the dummy register to ensure it is considered 'used'.
        dummy_output = data_storage[0];
    end

endmodule
