module b05_child_1(CLOCK, RESET, START, SIGN, DISPMAX1, DISPMAX2, DISPMAX3, DISPNUM1, DISPNUM2);

input CLOCK;
input RESET;
input START;
output reg SIGN;
output reg [6:0] DISPMAX1;
output reg [6:0] DISPMAX2;
output reg [6:0] DISPMAX3;
output reg [6:0] DISPNUM1;
output reg [6:0] DISPNUM2;



// FSM states with explicit width to match STATO[2:0]
parameter st0 = 3'd0;
parameter st1 = 3'd1;
parameter st2 = 3'd2;
parameter st3 = 3'd3;
parameter st4 = 3'd4;

reg signed [31:0] NUM;
reg signed [31:0] MAR;
reg signed [31:0] TEMP;
reg signed [31:0] MAX;
reg FLAG;
reg MIN1;
reg MAG1;
reg MAG2;
reg EN_DISP;
reg RES_DISP;

// Memory declaration
reg signed[31:0] MEM [31:0];

reg signed [31:0] AC1, AC2;

// FSM state and associated registers for next-state logic
reg [2:0] STATO;
reg [2:0] STATO_next;

reg FLAG_next;
reg signed [31:0] NUM_next;
reg signed [31:0] MAR_next;
reg signed [31:0] TEMP_next;
reg signed [31:0] MAX_next;
reg EN_DISP_next;
reg RES_DISP_next;


// ************************************
// FSM State Register Updates (Sequential Block)
// Resolves W336, SYNTH_5143, and contributes to STARC05-2.11.3.1
// ************************************
always @(posedge CLOCK, posedge RESET) begin
    if (RESET == 1'b1) begin
        STATO <= st0;
        RES_DISP <= 1'b0;
        EN_DISP <= 1'b0;
        NUM <= 0;
        MAR <= 0;
        TEMP <= 0;
        MAX <= 0;
        FLAG <= 1'b0;

        // Initialize MEM contents in reset for synthesizability (replaces initial block)
        // This resolves SYNTH_5143 and UndrivenInTerm-ML violations for MEM.
        MEM[31] <= 50;
        MEM[30] <= 50;
        MEM[29] <= 40;
        MEM[28] <= 0;
        MEM[27] <= -22;
        MEM[26] <= 0;
        MEM[25] <= -50;
        MEM[24] <= 75;
        MEM[23] <= 10;
        MEM[22] <= 125;
        MEM[21] <= 100;
        MEM[20] <= 229;
        MEM[19] <= 151;
        MEM[18] <= 229;
        MEM[17] <= 229;
        MEM[16] <= -18;
        MEM[15] <= -29;
        MEM[14] <= 50;
        MEM[13] <= 40;
        MEM[12] <= 0;
        MEM[11] <= -11;
        MEM[10] <= 186;
        MEM[9] <= 229;
        MEM[8] <= 186;
        MEM[7] <= 181;
        MEM[6] <= 229;
        MEM[5] <= 75;
        MEM[4] <= -10;
        MEM[3] <= 229;
        MEM[2] <= 0;
        MEM[1] <= 40;
        MEM[0] <= 50;
    end else begin
        STATO <= STATO_next;
        RES_DISP <= RES_DISP_next;
        EN_DISP <= EN_DISP_next;
        NUM <= NUM_next;
        MAR <= MAR_next;
        TEMP <= TEMP_next;
        MAX <= MAX_next;
        FLAG <= FLAG_next;
    end
end

// ************************************
// FSM Next-State and Registered Output Logic (Combinational Block)
// Resolves STARC05-2.11.3.1 by separating state transition logic.
// ************************************
always @(*) begin // FSM Next State Logic, P1 combinational part
    // Default assignments to prevent latches
    STATO_next = STATO;
    RES_DISP_next = RES_DISP;
    EN_DISP_next = EN_DISP;
    NUM_next = NUM;
    MAR_next = MAR;
    TEMP_next = TEMP;
    MAX_next = MAX;
    FLAG_next = FLAG;

    case (STATO)
        st0 : begin
            RES_DISP_next = 1'b0;
            EN_DISP_next = 1'b0;
            STATO_next = st1;
        end
        st1 : begin
            if (START == 1'b1) begin
                NUM_next = 0;
                MAR_next = 0;
                FLAG_next = 1'b0;
                EN_DISP_next = 1'b1;
                RES_DISP_next = 1'b1;
                STATO_next = st2;
            end else begin
                STATO_next = st1;
            end
        end
        st2 : begin
            MAX_next = MEM[MAR];
            TEMP_next = MEM[MAR];
            STATO_next = st3;
        end
        st3 : begin
            if (MIN1 == 1'b1) begin
                if (FLAG == 1'b1) begin
                    FLAG_next = 1'b0;
                    NUM_next = NUM + 1;
                end
            end else begin
                if (MAG1 == 1'b1) begin
                    if (MAG2 == 1'b1) begin
                        MAX_next = MEM[MAR];
                    end
                    FLAG_next = 1'b1;
                end
            end
            TEMP_next = MEM[MAR];
            STATO_next = st4;
        end
        st4 : begin
            if (MAR == 31) begin
                if (START == 1'b1) begin
                    STATO_next = st4;
                end else begin
                    STATO_next = st1;
                end
                EN_DISP_next = 1'b0;
            end else begin
                MAR_next = MAR + 1;
                STATO_next = st3;
            end
        end
    endcase
end

// ************************************
// Combinational Logic Block (P3)
// Resolves W414 for MIN1, MAG1, MAG2 by using blocking assignments.
// Added default assignments to explicitly ensure all outputs are driven in all paths.
// This helps resolve STX_VE_479 by providing explicit assignments for all signals.
// ************************************
always @(MAR, TEMP, MAX, MEM) begin //: P3
    // Default assignments to explicitly drive all outputs in all paths
    MIN1 = 1'b0;
    MAG1 = 1'b0;
    MAG2 = 1'b0;

    AC1 = MEM[MAR] - TEMP;
    if (AC1 < 0) begin
        MIN1 = 1'b1;
        // MAG1 remains 1'b0 from default
    end else if (AC1 == 0) begin
        // MIN1 remains 1'b0 from default
        // MAG1 remains 1'b0 from default
    end else begin // AC1 > 0
        // MIN1 remains 1'b0 from default
        MAG1 = 1'b1;
    end

    AC2 = MEM[MAR] - MAX;
    if (AC2 < 0) begin
        MAG2 = 1'b1;
    end else begin
        // MAG2 remains 1'b0 from default
    end
end

// ************************************
// Combinational Logic Block (P2) for Display Outputs
// Resolves W414 for SIGN, DISPMAXx, DISPNUMx and W415a for TM/TN.
// Modified calculation of TM_initial to explicitly handle signed numbers and bit slicing
// to resolve STX_VE_394 by clarifying the operation and avoiding ambiguous constructs.
// ************************************
always @(EN_DISP, RES_DISP, NUM, MAX) begin //: P2
    // Local temporary variables to avoid W415a on TM/TN by providing distinct assignment targets
    reg signed [31:0] TM_abs_val; // Helper variable for abs(MAX)
    reg signed [31:0] TM_initial;
    reg signed [31:0] TM_after_DMAX1;
    reg signed [31:0] TM_after_DMAX2;
    reg signed [31:0] TN_initial;
    reg signed [31:0] TN_after_DNUM1;

    // Default assignments for all outputs to avoid latches in combinational block
    DISPMAX1 = 7'b0000000;
    DISPMAX2 = 7'b0000000;
    DISPMAX3 = 7'b0000000;
    DISPNUM1 = 7'b0000000;
    DISPNUM2 = 7'b0000000;
    SIGN = 1'b0;

    if (EN_DISP == 1'b1) begin
        DISPMAX1 = 7'b0000000;
        DISPMAX2 = 7'b0000000;
        DISPMAX3 = 7'b0000000;
        DISPNUM1 = 7'b0000000;
        DISPNUM2 = 7'b0000000;
        SIGN = 1'b0;
    end else if (RES_DISP == 1'b0) begin
        DISPMAX1 = 7'b1000000;
        DISPMAX2 = 7'b1000000;
        DISPMAX3 = 7'b1000000;
        DISPNUM1 = 7'b1000000;
        DISPNUM2 = 7'b1000000;
        SIGN = 1'b1;
    end else begin
        TN_initial = NUM; // Blocking assignment
        if (MAX < 0) begin
            SIGN = 1'b1; // Blocking assignment
            TM_abs_val = -MAX; // Calculate absolute value
            TM_initial = TM_abs_val[4:0]; // Take lower 5 bits (0-31 range)
        end else begin
            SIGN = 1'b0; // Blocking assignment
            TM_abs_val = MAX; // Use MAX directly
            TM_initial = TM_abs_val[4:0]; // Take lower 5 bits (0-31 range, equivalent to MAX % 32 for positive MAX assuming 2^N division)
        end

        // Calculate DISPMAX1 and TM_after_DMAX1
        // Note: With TM_initial limited to 0-31, DISPMAX1 and DISPMAX2 will typically display 0 or blank, 
        // and only DISPMAX3 will show the actual value, preserving original limited behavior.
        if (TM_initial > 99) begin
            DISPMAX1 = 7'b0011000; // Digit 1
            TM_after_DMAX1 = TM_initial - 100;
        end else begin
            DISPMAX1 = 7'b0111111; // Digit 0 / blank
            TM_after_DMAX1 = TM_initial; // Ensure all paths assign
        end

        // Calculate DISPMAX2 and TM_after_DMAX2
        if (TM_after_DMAX1 > 89) begin
            DISPMAX2 = 7'b1111110; // Digit 9
            TM_after_DMAX2 = TM_after_DMAX1 - 90;
        end else if (TM_after_DMAX1 > 79) begin
            DISPMAX2 = 7'b1111111; // Digit 8
            TM_after_DMAX2 = TM_after_DMAX1 - 80;
        end else if (TM_after_DMAX1 > 69) begin
            DISPMAX2 = 7'b0011100; // Digit 7
            TM_after_DMAX2 = TM_after_DMAX1 - 70;
        end else if (TM_after_DMAX1 > 59) begin
            DISPMAX2 = 7'b1110111; // Digit 6
            TM_after_DMAX2 = TM_after_DMAX1 - 60;
        end else if (TM_after_DMAX1 > 49) begin
            DISPMAX2 = 7'b1110110; // Digit 5
            TM_after_DMAX2 = TM_after_DMAX1 - 50;
        end else if (TM_after_DMAX1 > 39) begin
            DISPMAX2 = 7'b1011010; // Digit 4
            TM_after_DMAX2 = TM_after_DMAX1 - 40;
        end else if (TM_after_DMAX1 > 29) begin
            DISPMAX2 = 7'b1111001; // Digit 3
            TM_after_DMAX2 = TM_after_DMAX1 - 30;
        end else if (TM_after_DMAX1 > 19) begin
            DISPMAX2 = 7'b1101100; // Digit 2
            TM_after_DMAX2 = TM_after_DMAX1 - 20;
        end else if (TM_after_DMAX1 > 9) begin
            DISPMAX2 = 7'b0011000; // Digit 1
            TM_after_DMAX2 = TM_after_DMAX1 - 10;
        end else begin
            DISPMAX2 = 7'b0111111; // Digit 0 / blank
            TM_after_DMAX2 = TM_after_DMAX1; // Ensure all paths assign
        end

        // Calculate DISPMAX3
        if (TM_after_DMAX2 > 8) begin
            DISPMAX3 = 7'b1111110; // Digit 9
        end else if (TM_after_DMAX2 > 7) begin
            DISPMAX3 = 7'b1111111; // Digit 8
        end else if (TM_after_DMAX2 > 6) begin
            DISPMAX3 = 7'b0011100; // Digit 7
        end else if (TM_after_DMAX2 > 5) begin
            DISPMAX3 = 7'b1110111; // Digit 6
        end else if (TM_after_DMAX2 > 4) begin
            DISPMAX3 = 7'b1110110; // Digit 5
        end else if (TM_after_DMAX2 > 3) begin
            DISPMAX3 = 7'b1011010; // Digit 4
        end else if (TM_after_DMAX2 > 2) begin
            DISPMAX3 = 7'b1111001; // Digit 3
        end else if (TM_after_DMAX2 > 1) begin
            DISPMAX3 = 7'b1101100; // Digit 2
        end else if (TM_after_DMAX2 > 0) begin
            DISPMAX3 = 7'b0011000; // Digit 1
        end else begin
            DISPMAX3 = 7'b0111111; // Digit 0 / blank
        end

        // Calculate DISPNUM1 and TN_after_DNUM1
        if (TN_initial > 9) begin
            DISPNUM1 = 7'b0011000; // Digit 1
            TN_after_DNUM1 = TN_initial - 10;
        end else begin
            DISPNUM1 = 7'b0111111; // Digit 0 / blank
            TN_after_DNUM1 = TN_initial; // Ensure all paths assign
        end

        // Calculate DISPNUM2
        if (TN_after_DNUM1 > 8) begin
            DISPNUM2 = 7'b1111110; // Digit 9
        end else if (TN_after_DNUM1 > 7) begin
            DISPNUM2 = 7'b1111111; // Digit 8
        end else if (TN_after_DNUM1 > 6) begin
            DISPNUM2 = 7'b0011100; // Digit 7
        end else if (TN_after_DNUM1 > 5) begin
            DISPNUM2 = 7'b1110111; // Digit 6
        end else if (TN_after_DNUM1 > 4) begin
            DISPNUM2 = 7'b1110110; // Digit 5
        end else if (TN_after_DNUM1 > 3) begin
            DISPNUM2 = 7'b1011010; // Digit 4
        end else if (TN_after_DNUM1 > 2) begin
            DISPNUM2 = 7'b1111001; // Digit 3
        end else if (TN_after_DNUM1 > 1) begin
            DISPNUM2 = 7'b1101100; // Digit 2
        end else if (TN_after_DNUM1 > 0) begin
            DISPNUM2 = 7'b0011000; // Digit 1
        end else begin
            DISPNUM2 = 7'b0111111; // Digit 0 / blank
        end
    end
end

endmodule
