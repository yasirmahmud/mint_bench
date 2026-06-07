module automatic_washing_machine  (clk, reset, door_close, start, filled, detergent_added, cycle_timeout, drained, spin_timeout, door_lock, motor_on, fill_value_on, drain_value_on, done, soap_wash, water_wash);

	input clk, reset, door_close, start, filled, detergent_added, cycle_timeout, drained, spin_timeout;
	output reg door_lock, motor_on, fill_value_on, drain_value_on, done, soap_wash, water_wash;

	//defining the states
	parameter check_door = 3'b000;
	parameter fill_water = 3'b001;
	parameter add_detergent = 3'b010;
	parameter cycle = 3'b011;
	parameter drain_water = 3'b100;
	parameter spin = 3'b101;

	reg[2:0] current_state, next_state; // FSM state register and its next value

	// Registers for the next values of outputs (combinatorial logic)
	reg next_door_lock;
	reg next_motor_on;
	reg next_fill_value_on;
	reg next_drain_value_on;
	reg next_done;
	reg next_soap_wash;
	reg next_water_wash;

	// Combinatorial logic to determine next_state and next_outputs
	// The sensitivity list includes all inputs and current state registers that affect the next state/outputs.
	// This ensures that next_state and next_outputs are combinatorially driven, avoiding latches.
	always@(current_state or start or door_close or filled or detergent_added or drained or cycle_timeout or spin_timeout or soap_wash or water_wash)
	begin
		// Default assignments for next_state and next_outputs
		// By default, outputs hold their current registered value, and state remains the same.
		// This prevents latch inference for 'reg' types in always@* blocks.
		next_state = current_state;
		next_door_lock = door_lock;
		next_motor_on = motor_on;
		next_fill_value_on = fill_value_on;
		next_drain_value_on = drain_value_on;
		next_done = done;
		next_soap_wash = soap_wash;
		next_water_wash = water_wash;

		case(current_state)
			check_door:
				begin
					// Reset all output flags when in check_door state (unless starting)
					next_door_lock = 0; 
					next_motor_on = 0;
					next_fill_value_on = 0;
					next_drain_value_on = 0;
					next_done = 0;
					next_soap_wash = 0;
					next_water_wash = 0;
					if(start==1 && door_close==1)
					begin
						next_state = fill_water;
						next_door_lock = 1; // Lock door
					end
					// else: next_state defaults to current_state, other outputs default to 0
				end

			fill_water:
				begin
					next_door_lock = 1; // Door remains locked
					next_fill_value_on = 1; // Turn on fill valve by default
					next_motor_on = 0;
					next_drain_value_on = 0;
					next_done = 0;
					// next_soap_wash and next_water_wash hold their current values unless filled

					if (filled==1)
					begin
						next_fill_value_on = 0; // Stop filling
						if(soap_wash == 0) // Check current soap_wash flag to determine if it's the first fill
						begin
							next_state = add_detergent;
							next_soap_wash = 1; // Mark that soap has been added/is part of the cycle
							next_water_wash = 0; // Not yet a water-only rinse cycle
						end
						else // This must be the water rinse fill cycle (soap_wash == 1 and water_wash == 1 previously)
						begin
							next_state = cycle; // Proceed to the rinse cycle
							// next_soap_wash and next_water_wash will hold their values (1,1)
						end
					end
					// else: next_state defaults to current_state, next_fill_value_on remains 1
				end

			add_detergent:
				begin
					next_door_lock = 1; // Door remains locked
					next_motor_on = 0;
					next_fill_value_on = 0;
					next_drain_value_on = 0;
					next_done = 0;
					// next_soap_wash = 1; (holds from previous state)
					// next_water_wash = 0; (holds from previous state)

					if(detergent_added==1)
					begin
						next_state = cycle;
					end
					// else: next_state defaults to current_state
				end

			cycle:
				begin
					next_door_lock = 1; // Door remains locked
					next_motor_on = 1; // Motor runs during cycle
					next_fill_value_on = 0;
					next_drain_value_on = 0;
					next_done = 0;
					// next_soap_wash and next_water_wash hold from previous state

					if(cycle_timeout == 1)
					begin
						next_state = drain_water;
						next_motor_on = 0; // Stop motor after cycle
					end
					// else: next_state defaults to current_state, next_motor_on remains 1
				end

			drain_water:
				begin
					next_door_lock = 1; // Door remains locked
					next_drain_value_on = 1; // Turn on drain valve by default
					next_motor_on = 0;
					next_fill_value_on = 0;
					next_done = 0;
					// next_soap_wash and next_water_wash hold from previous state

					if(drained==1)
					begin
						next_drain_value_on = 0; // Stop draining
						if(water_wash==0) // Check current water_wash flag: if it's the soap wash phase
						begin
							next_state = fill_water; // Go back to fill for rinse cycle
							// next_soap_wash will hold 1 (still part of the wash process)
							next_water_wash = 1; // Set flag for water rinse cycle
						end
						else // This must be after the water rinse cycle (water_wash == 1 previously)
						begin
							next_state = spin; // Proceed to spin cycle
							// next_soap_wash and next_water_wash will hold their values (1,1)
						end
					end
					// else: next_state defaults to current_state, next_drain_value_on remains 1
				end

			spin:
				begin
					next_door_lock = 1; // Door remains locked during spin
					next_motor_on = 1; // Motor runs for spinning (FIXED: was 0)
					next_fill_value_on = 0;
					next_drain_value_on = 0; // No draining during spin (FIXED: was 1)
					next_done = 0;
					// next_soap_wash and next_water_wash hold from previous state

					if(spin_timeout==1)
					begin
						next_state = check_door; // Cycle complete, go back to check_door (FIXED: was door_close)
						next_motor_on = 0; // Stop motor
						next_done = 1; // Indicate completion
						next_door_lock = 0; // Unlock door
						next_soap_wash = 0; // Reset flags for next cycle
						next_water_wash = 0; // Reset flags for next cycle
					end
					// else: next_state defaults to current_state, next_motor_on remains 1
				end

			default: // In case of an unknown state, reset to check_door and all outputs to default off state.
				begin
					next_state = check_door;
					next_door_lock = 0;
					next_motor_on = 0;
					next_fill_value_on = 0;
					next_drain_value_on = 0;
					next_done = 0;
					next_soap_wash = 0;
					next_water_wash = 0;
				end
			endcase
	end

	// Sequential logic to update current_state and output registers on clock edge or reset
	// Fix for SYNTH_5192 and STARC05-2.3.1.6: Changed 'if(reset)' to 'if(~reset)'
	// to match 'negedge reset' in the sensitivity list (active-low asynchronous reset).
	always@(posedge clk or negedge reset)
	begin
		if(~reset) // Asynchronous, active-low reset
		begin
			current_state <= check_door; // Reset FSM to initial state
			door_lock <= 0; // Reset all output registers
			motor_on <= 0;
			fill_value_on <= 0;
			drain_value_on <= 0;
			done <= 0;
			soap_wash <= 0;
			water_wash <= 0;
		end
		else // Synchronous update on positive clock edge
		begin
			current_state <= next_state;
			door_lock <= next_door_lock;
			motor_on <= next_motor_on;
			fill_value_on <= next_fill_value_on;
			drain_value_on <= next_drain_value_on;
			done <= next_done;
			soap_wash <= next_soap_wash;
			water_wash <= next_water_wash;
		end
	end

endmodule
