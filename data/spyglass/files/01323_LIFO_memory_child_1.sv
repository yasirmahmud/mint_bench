module LIFO_memory #(
    parameter DATA_WIDTH = 8,
    parameter LIFO_DEPTH = 16
)(
    input Clk,
    input Rst,
    input PUSH,
    input POP,
    input [DATA_WIDTH-1:0] dataIn,
    output reg [DATA_WIDTH-1:0] dataOut,
    output EMPTY,
    output FULL
);

    // Calculate stack pointer width: needs to hold values from 0 to LIFO_DEPTH (inclusive)
    localparam SP_WIDTH = $clog2(LIFO_DEPTH + 1);

    reg [DATA_WIDTH-1:0] LIFO [0:LIFO_DEPTH-1];
    reg [SP_WIDTH-1:0] stackPointer; // Fix for SYNTH_89: Removed initial assignment. Reset handled by Rst.

    // Wires for next state logic (to resolve multiple assignments in sequential block)
    reg [SP_WIDTH-1:0] next_stackPointer;
    reg [DATA_WIDTH-1:0] next_dataOut;
    reg push_active;
    reg pop_active;

    // Combinational logic for EMPTY and FULL outputs
    assign EMPTY = (stackPointer == 0);
    assign FULL = (stackPointer == LIFO_DEPTH);

    // Combinational logic to determine the next state of stackPointer and dataOut
    // This ensures only one assignment path for next_stackPointer and next_dataOut.
    always_comb begin
        // Default: retain current value if no operation or reset
        next_stackPointer = stackPointer;
        next_dataOut = dataOut;

        // Determine effective push/pop conditions, considering full/empty states
        push_active = PUSH && !FULL;
        pop_active = POP && !EMPTY;

        // Priority encoder for operations: PUSH-only, POP-only, or simultaneous PUSH/POP
        // The original code's net effect for simultaneous PUSH/POP was that stackPointer remained
        // unchanged, and dataOut received the dataIn (effectively a pass-through).
        if (push_active && !pop_active) begin // Only PUSH operation
            next_stackPointer = stackPointer + 1;
            // dataOut is not affected by PUSH
        end else if (!push_active && pop_active) begin // Only POP operation
            next_stackPointer = stackPointer - 1;
            next_dataOut = LIFO[stackPointer]; // Read data from stack before decrementing pointer
        end else if (push_active && pop_active) begin // Simultaneous PUSH and POP operation
            // Preserve original behavior: stackPointer remains unchanged, dataOut gets dataIn
            next_stackPointer = stackPointer; // Stack pointer does not change
            next_dataOut = dataIn;            // Data pushed is immediately available on dataOut
        end
        // If neither push_active nor pop_active, next_stackPointer and next_dataOut retain their current values
    end

    // Sequential logic for state updates and LIFO array writes
    // Fix for STARC05-1.3.1.3: Changed to synchronous reset. All flip-flops are now reset synchronously.
    always @(posedge Clk) begin
        if (Rst) begin // Synchronous reset
            stackPointer <= 0;
            dataOut <= 0;
            // LIFO array elements are typically not cleared on reset in memory IPs.
            // Maintaining original behavior where LIFO array contents are not explicitly reset.
        end else begin
            // Write to LIFO array if a push operation is active
            if (push_active) begin // Covers both PUSH-only and simultaneous PUSH/POP cases
                LIFO[stackPointer] <= dataIn;
            end

            // Update stackPointer and dataOut using the calculated next values
            // Fix for STARC05-2.2.3.3 and W415a: stackPointer and dataOut are assigned only once per clock cycle.
            stackPointer <= next_stackPointer;
            dataOut <= next_dataOut;
        end
    end

endmodule
