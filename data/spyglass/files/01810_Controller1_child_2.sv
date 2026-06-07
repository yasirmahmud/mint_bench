module Controller1_child_2 ( TCLK, TRESET, MODE, rrdtag_0_ERROR,
    rrdtag_1_ERROR, rr512x5_ERROR, BIST_ADR, rrdtag_0_ENABLE, rrdtag_1_ENABLE,
    rr512x5_ENABLE, BIST_WE, INVERSE, END_SEQ, BIST_ON, ERRN_ON, NO_COMP,
    BACKGROUND, DONE, ERROR, FAIL, test_mode );

input  [1:0] MODE;
output [8:0] BIST_ADR;
input  TCLK, TRESET, rrdtag_0_ERROR, rrdtag_1_ERROR, rr512x5_ERROR, test_mode;
output rrdtag_0_ENABLE, rrdtag_1_ENABLE, rr512x5_ENABLE, BIST_WE, INVERSE,
    END_SEQ, BIST_ON, ERRN_ON, NO_COMP, BACKGROUND, DONE, ERROR, FAIL;

    // Declare outputs as 'reg' if driven by always blocks
    reg [8:0] BIST_ADR;
    reg DONE;

    // Declare internal wires for next-state logic
    wire [8:0] BIST_ADR_next;
    wire DONE_next;

    // Combinational logic for address generation and sequence completion (next state calculation)
    always_comb begin
        // Default assignments for next state
        BIST_ADR_next = BIST_ADR;
        DONE_next = DONE;

        if (test_mode) begin
            // Increment BIST_ADR_next when test_mode is active
            if (BIST_ADR == 9'd511) begin // Max address for 9-bit address bus (0-511)
                BIST_ADR_next = 9'b0; // Wrap around
                DONE_next = 1'b1;     // Signal end of sequence
            end else begin
                BIST_ADR_next = BIST_ADR + 1'b1;
                DONE_next = 1'b0;
            end
        end else begin
            BIST_ADR_next = 9'b0; // Reset address if test_mode is off
            DONE_next = 1'b0;
        end
    end

    // Sequential logic for register updates, using TCLK and TRESET
    always_ff @(posedge TCLK or posedge TRESET) begin
        if (TRESET) begin
            BIST_ADR <= 9'b0;
            DONE <= 1'b0;
        end else begin
            BIST_ADR <= BIST_ADR_next;
            DONE <= DONE_next;
        end
    end

    // Combinational logic for other outputs, using inputs and 'reg' outputs

    // Enable signals are active based on MODE and test_mode
    assign rrdtag_0_ENABLE = MODE[0] & test_mode;
    assign rrdtag_1_ENABLE = MODE[1] & test_mode;
    assign rr512x5_ENABLE = (MODE[0] | MODE[1]) & test_mode;

    // BIST_ON is directly controlled by test_mode
    assign BIST_ON = test_mode;

    // Overall ERROR signal is an OR of all individual error inputs
    assign ERROR = rrdtag_0_ERROR | rrdtag_1_ERROR | rr512x5_ERROR;

    // BIST_WE (Write Enable) is active when BIST is on and sequence is not DONE
    assign BIST_WE = BIST_ON & ~DONE;

    // INVERSE signal is driven by a combination of MODE and test_mode
    assign INVERSE = MODE[0] ^ test_mode;

    // END_SEQ signals the completion of the BIST sequence
    assign END_SEQ = DONE;

    // ERRN_ON (Error Notification On) is active if an ERROR occurs while BIST is on
    assign ERRN_ON = ERROR & BIST_ON;

    // NO_COMP (No Compare) is active based on MODE and test_mode
    assign NO_COMP = MODE[1] | test_mode;

    // BACKGROUND signal indicates active background testing when BIST is on and not DONE
    assign BACKGROUND = BIST_ON & ~DONE;

    // FAIL signal indicates a failure if an ERROR occurred and the BIST sequence is DONE while BIST_ON
    assign FAIL = ERROR & DONE & BIST_ON;

endmodule
