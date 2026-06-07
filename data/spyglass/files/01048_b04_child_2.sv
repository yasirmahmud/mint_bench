module b04(RESTART,AVERAGE,ENABLE,DATA_IN,DATA_OUT,RESET,CLOCK);

input CLOCK;
input RESET;
input RESTART;
input AVERAGE;
input ENABLE;
input signed [7:0] DATA_IN;

output [7:0] DATA_OUT;

reg signed [7:0] DATA_OUT;


parameter sA = 2'd0;
parameter sB = 2'd1;
parameter sC = 2'd2;

// FSM state registers
reg [1:0] stato;
reg [1:0] next_stato;

// Internal data registers (32-bit signed)
reg signed [31:0] RMAX, RMIN, RLAST, REG1, REG2, REG3, REG4, REGD, test;
reg signed [31:0] temp;

// Next-state versions of internal data registers
reg signed [31:0] next_RMAX, next_RMIN, next_RLAST, next_REG1, next_REG2, next_REG3, next_REG4, next_REGD, next_test;
reg signed [31:0] next_temp;

// Control signal registers (synchronously updated)
reg RES, AVE, ENA;

// Next-state versions of control signal registers
reg next_RES, next_AVE, next_ENA;

// Next-state version of DATA_OUT
reg signed [7:0] next_DATA_OUT;


// Sequential block: updates registers on clock edge or async reset
always @(posedge CLOCK, posedge RESET) begin
    if(RESET == 1'b1) begin
		stato <= sA;
		RMAX <= 0;
		RMIN <= 0;
		RLAST <= 0;
		REG1 <= 0;
		REG2 <= 0;
		REG3 <= 0;
		REG4 <= 0;
		REGD <= 127;
		temp <= 0;
		DATA_OUT <= 0;
		RES <= 0;
		ENA <= 0;
		AVE <= 0;
        test <= 0; // Fix: Asynchronous reset for 'test' register
		end else begin
		stato <= next_stato;
        RMAX <= next_RMAX;
        RMIN <= next_RMIN;
        RLAST <= next_RLAST;
        REG1 <= next_REG1;
        REG2 <= next_REG2;
        REG3 <= next_REG3;
        REG4 <= next_REG4;
        REGD <= next_REGD;
        temp <= next_temp;
        DATA_OUT <= next_DATA_OUT;
		RES <= next_RES;
		ENA <= next_ENA;
		AVE <= next_AVE;
        test <= next_test;
		end
end

// Combinational block: calculates next state and next register values
always @(*) begin
    // Default assignments to prevent latches
    next_stato = stato;
    next_RMAX = RMAX;
    next_RMIN = RMIN;
    next_RLAST = RLAST;
    next_REG1 = REG1;
    next_REG2 = REG2;
    next_REG3 = REG3;
    next_REG4 = REG4;
    next_REGD = REGD;
    next_temp = temp;
    next_DATA_OUT = DATA_OUT;
    next_RES = RES; // Default to current registered value
    next_ENA = ENA; // Default to current registered value
    next_AVE = AVE; // Default to current registered value
    next_test = test;

    // Control signals are directly from inputs (synchronously updated by the sequential block)
    next_RES = RESTART;
    next_ENA = ENABLE;
    next_AVE = AVERAGE;

    case(stato)
		sA : begin
			next_stato = sB;
		end
		sB : begin
            // Explicitly sign-extend DATA_IN from 8-bit to 32-bit
			next_RMAX = {{24{DATA_IN[7]}}, DATA_IN};
			next_RMIN = {{24{DATA_IN[7]}}, DATA_IN};
			next_REG1 = 0;
			next_REG2 = 0;
			next_REG3 = 0;
			next_REG4 = 0;
			next_RLAST = 0;
			next_DATA_OUT = 0;
			next_stato = sC;
		end
		sC : begin
            // Update RLAST
			if((next_ENA == 1'b1)) begin
                // Explicitly sign-extend DATA_IN from 8-bit to 32-bit
				next_RLAST = {{24{DATA_IN[7]}}, DATA_IN};
			end
            
            // Logic for DATA_OUT calculation
			if((next_RES == 1'b1)) begin
				next_test = (RMAX + RMIN);
                // Explicitly sign-extend 7-bit slice of next_test to 32-bit for next_REGD
				next_REGD = {{25{next_test[6]}}, next_test[6:0]};
				next_temp = RMAX + RMIN;
				if((next_temp >= 0)) begin
					next_DATA_OUT = next_REGD / 2;
				end
				else begin
					next_DATA_OUT =  -(( -next_REGD) / 2);
				end
			end
			else if((next_ENA == 1'b1)) begin
				if((next_AVE == 1'b1)) begin
					next_DATA_OUT = REG4;
				end
				else begin
                    // Explicitly sign-extend DATA_IN from 8-bit to 32-bit for arithmetic
					next_test = ({{24{DATA_IN[7]}}, DATA_IN} + REG4);
                    // Explicitly sign-extend 7-bit slice of next_test to 32-bit for next_REGD
					next_REGD = {{25{next_test[6]}}, next_test[6:0]};
					next_temp = ({{24{DATA_IN[7]}}, DATA_IN} + REG4);
					if((next_temp >= 0)) begin
						next_DATA_OUT = next_REGD / 2;
					end
					else begin
						next_DATA_OUT =  -(( -next_REGD) / 2);
					end
				end
			end
			else begin
				next_DATA_OUT = RLAST;
			end

            // Update RMAX, RMIN (independent of DATA_OUT logic)
            // Explicitly sign-extend DATA_IN for comparison and assignment
			if({{24{DATA_IN[7]}}, DATA_IN} > RMAX) begin
				next_RMAX = {{24{DATA_IN[7]}}, DATA_IN};
			end
			else if({{24{DATA_IN[7]}}, DATA_IN} < RMIN) begin
				next_RMIN = {{24{DATA_IN[7]}}, DATA_IN};
			end

            // Shift registers
			next_REG4 = REG3;
			next_REG3 = REG2;
			next_REG2 = REG1;
            // Explicitly sign-extend DATA_IN from 8-bit to 32-bit
			next_REG1 = {{24{DATA_IN[7]}}, DATA_IN};

			next_stato = sC; // Stay in state sC
		end
        default: begin
            next_stato = sA; // Undefined state, go to default/reset state
        end
		
    endcase
end


endmodule
