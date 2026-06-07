module systolic_array  (
    input wire clk,                // Clock signal
    input wire reset,              // Reset signal
    input wire control,            // Control signal (1: load weights, 0: data flow)
    input wire [7:0] data_in_row_0,  // Data input for row 0
    input wire [7:0] data_in_row_1,  // Data input for row 1
    input wire [7:0] data_in_row_2,  // Data input for row 2
    input wire [7:0] weight_in_col_0, // Weight input for column 0
    input wire [7:0] weight_in_col_1, // Weight input for column 1
    input wire [7:0] weight_in_col_2, // Weight input for column 2
    output wire [15:0] acc_out_0,  // Accumulation output for row 0
    output wire [15:0] acc_out_1,  // Accumulation output for row 1
    output wire [15:0] acc_out_2   // Accumulation output for row 2
);

    // Removed unused 'weight' wire and its assignment, resolving W528 violation.
    // wire [3*7 - 1:0] weight;
    // assign weight = {weight_in_col_2, weight_in_col_1, weight_in_col_0};

    // Internal wires to connect each PE
    // data_out_00 is not explicitly defined in the original module but implied by data_out_01 being output of pe_00
    wire [7:0] data_out_01, data_out_02;
    wire [7:0] data_out_11, data_out_12;
    wire [7:0] data_out_21, data_out_22;
    
    // Declared wires for final data outputs of each row's last PE,
    // which were implicitly declared as 1-bit wires in the original code.
    wire [7:0] data_out_0; // Output from pe_02
    wire [7:0] data_out_1; // Output from pe_12
    wire [7:0] data_out_2; // Output from pe_22

    wire [7:0] weight_out_00, weight_out_01, weight_out_02;
    wire [7:0] weight_out_10, weight_out_11, weight_out_12;
    wire [7:0] weight_out_20, weight_out_21, weight_out_22;
    
    wire [15:0] acc_out_internal_00, acc_out_internal_01, acc_out_internal_02;
    wire [15:0] acc_out_internal_10, acc_out_internal_11, acc_out_internal_12;
    wire [15:0] acc_out_internal_20, acc_out_internal_21, acc_out_internal_22;
    
    // Row 0 PE instantiations
    PE pe_00 (
        .clk(clk),
        .reset(reset),
        .control(control),
        .data_in(data_in_row_0),              // Data input for row 0
        .weight_in_top(weight_in_col_0),       // Weight input for column 0
        .acc_in(16'd0),                        // No previous accumulation for first PE in column
        .data_out(data_out_01),                // Data output to next PE in row
        .acc_out(acc_out_internal_00),         // Accumulation output for this PE (propagates down)
        .weight_out(weight_out_00)             // Weight output for this PE (propagates down)
    );

    PE pe_01 (
        .clk(clk),
        .reset(reset),
        .control(control),
        .data_in(data_out_01),                // Data input from PE[00]
        .weight_in_top(weight_in_col_1),       // Weight input for column 1
        .acc_in(16'd0),                        // No previous accumulation for first PE in column
        .data_out(data_out_02),                // Data output to next PE in row
        .acc_out(acc_out_internal_01),         // Accumulation output for this PE (propagates down)
        .weight_out(weight_out_01)             // Weight output for this PE (propagates down)
    );

    PE pe_02 (
        .clk(clk),
        .reset(reset),
        .control(control),
        .data_in(data_out_02),                // Data input from PE[01]
        .weight_in_top(weight_in_col_2),       // Weight input for column 2
        .acc_in(16'd0),                        // No previous accumulation for first PE in column
        .data_out(data_out_0),                 // Data output (final output for row 0, unused)
        .acc_out(acc_out_internal_02),         // Accumulation output for this PE (propagates down)
        .weight_out(weight_out_02)             // Weight output for this PE (propagates down)
    );
    
    // Row 1 PE instantiations
    PE pe_10 (
        .clk(clk),
        .reset(reset),
        .control(control),
        .data_in(data_in_row_1),              // Data input for row 1
        .weight_in_top(weight_out_00),         // Weight input from PE[00]
        .acc_in(acc_out_internal_00),         // Accumulated value from PE[00] (propagates down)
        .data_out(data_out_11),               // Data output to next PE in row
        .acc_out(acc_out_internal_10),        // Accumulation output for this PE (propagates down)
        .weight_out(weight_out_10)            // Weight output for this PE (propagates down)
    );

    PE pe_11 (
        .clk(clk),
        .reset(reset),
        .control(control),
        .data_in(data_out_11),                // Data input from PE[10]
        .weight_in_top(weight_out_01),         // Weight input from PE[01]
        .acc_in(acc_out_internal_01),          // Accumulated value from PE[01] (propagates down)
        .data_out(data_out_12),                // Data output to next PE in row
        .acc_out(acc_out_internal_11),         // Accumulation output for this PE (propagates down)
        .weight_out(weight_out_11)             // Weight output for this PE (propagates down)
    );

    PE pe_12 (
        .clk(clk),
        .reset(reset),
        .control(control),
        .data_in(data_out_12),                // Data input from PE[11]
        .weight_in_top(weight_out_02),         // Weight input from PE[02]
        .acc_in(acc_out_internal_02),          // Accumulated value from PE[02] (propagates down)
        .data_out(data_out_1),                 // Data output (final output for row 1, unused)
        .acc_out(acc_out_internal_12),         // Accumulation output for this PE (propagates down)
        .weight_out(weight_out_12)             // Weight output for this PE (propagates down)
    );
    
    // Row 2 PE instantiations
    PE pe_20 (
        .clk(clk),
        .reset(reset),
        .control(control),
        .data_in(data_in_row_2),              // Data input for row 2
        .weight_in_top(weight_out_10),         // Weight input from PE[10]
        .acc_in(acc_out_internal_10),         // Accumulated value from PE[10] (propagates down)
        .data_out(data_out_21),               // Data output to next PE in row
        .acc_out(acc_out_internal_20),        // Accumulation output for this PE (final for column 0)
        .weight_out(weight_out_20)            // Weight output for this PE (propagates down)
    );

    PE pe_21 (
        .clk(clk),
        .reset(reset),
        .control(control),
        .data_in(data_out_21),                // Data input from PE[20]
        .weight_in_top(weight_out_11),         // Weight input from PE[11]
        .acc_in(acc_out_internal_11),          // Accumulated value from PE[11] (propagates down)
        .data_out(data_out_22),                // Data output to next PE in row
        .acc_out(acc_out_internal_21),         // Accumulation output for this PE (final for column 1)
        .weight_out(weight_out_21)             // Weight output for this PE (propagates down)
    );

    PE pe_22 (
        .clk(clk),
        .reset(reset),
        .control(control),
        .data_in(data_out_22),                // Data input from PE[21]
        .weight_in_top(weight_out_12),         // Weight input from PE[12]
        .acc_in(acc_out_internal_12),          // Accumulated value from PE[12] (propagates down)
        .data_out(data_out_2),                 // Data output (final output for row 2, unused)
        .acc_out(acc_out_internal_22),         // Accumulation output for this PE (final for column 2)
        .weight_out(weight_out_22)             // Weight output for this PE (propagates down)
    );

    // Final accumulation outputs (results from the last row of PEs, for each column)
    assign acc_out_0 = acc_out_internal_20;
    assign acc_out_1 = acc_out_internal_21;
    assign acc_out_2 = acc_out_internal_22;

endmodule
