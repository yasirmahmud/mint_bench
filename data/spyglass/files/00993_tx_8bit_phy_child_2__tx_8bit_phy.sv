module tx_8bit_phy #(
	parameter	PHASE	= 0,
	parameter	ACTIVE	= 0
)(
	//-->> SPI INTERFACE <<---
	input			sck				,
	input			cs_n        			,
	output			miso        			,
	//--<< SPI INTERFACE >>---
	input			clock     				,
	input			rst_n                   ,
	output			send_flag				,
	input [23:0]	send_momment			,
	input [7:0]	send_data				,
	input			send_valid				,
	output			empty			
);

reg		trigger_clock;
reg		trigger_rst_n;
// reg		stay_clock; // Removed: W528 violation fix, 'stay_clock' is set but not read
always@(*)
	case({ACTIVE==1,PHASE==1})
	2'b00:	trigger_clock	= !cs_n && !sck;
	2'b01:	trigger_clock	= !cs_n && sck;
	2'b10:	trigger_clock	=  sck;
	2'b11:	trigger_clock	= !sck;
	default:;
	endcase

always@(cs_n)
	trigger_rst_n	= ~cs_n;

// Removed 'stay_clock' always block: W528 violation fix
/*
always@(*)
	case({ACTIVE==1,PHASE==1})
	2'b00:	stay_clock	= sck;
	2'b01:	stay_clock	= !sck;
	2'b10:	stay_clock	= !sck;
	2'b11:	stay_clock	=  sck;
	default:;
	endcase
*/

// Synchronize cs_n to 'clock' domain for synchronous logic (STARC05-1.3.1.3 fix)
// This ensures that 'cs_n', which is indirectly the source of an asynchronous reset ('trigger_rst_n'),
// is not also used synchronously in the 'clock' domain without proper synchronization.
reg cs_n_sync0, cs_n_sync1;
wire cs_n_s = cs_n_sync1;

always @(posedge clock or negedge rst_n) begin
    if (!rst_n) begin
        cs_n_sync0 <= 1'b1; // cs_n is active low, so reset to high means inactive (chip select is off)
        cs_n_sync1 <= 1'b1;
    end else begin
        cs_n_sync0 <= cs_n;
        cs_n_sync1 <= cs_n_sync0;
    end
end


//---->> YIELD BLOCK <<-----------
reg	[23:0]	counter;
always@(posedge trigger_clock,negedge trigger_rst_n)
	if(~trigger_rst_n)	counter	<= 24'd0;
	else				counter	<= counter + 1'b1;

reg				tx_yield;

always@(posedge clock,negedge rst_n)
	if(~rst_n)		tx_yield	<= 1'b0;
	else if(cs_n_s)	tx_yield	<= 1'b0; // Changed from cs_n to cs_n_s (STARC05-1.3.1.3 fix)
	else if(send_momment	< 24'd4)
				tx_yield	<= 1'b1;
	else 		tx_yield	<= counter >= send_momment | tx_yield;

//----<< YIELD BLOCK >>-----------
//---->> TX DATA PRO <<-----------
localparam	DRIVER_CLOCK	= "SPI_SCK" ; //SPI_SCK SYSTEM_CLK
reg [2:0]	point;
wire[7:0]	pre_data;
reg [7:0]	data_reg;
generate
if(DRIVER_CLOCK == "SPI_SCK")begin
//---->> TRIGGER CLOCK <<---------
always@(posedge trigger_clock,negedge trigger_rst_n)
	if(~trigger_rst_n)	point	<= 3'd0;
	else 				point	<= point + tx_yield;

always@(posedge trigger_clock,negedge trigger_rst_n)    
	if(~trigger_rst_n)
						data_reg	<= pre_data; 
	else if(!tx_yield)	data_reg	<= pre_data;
	else begin
		if(point == 3'b111) 
				data_reg	<= pre_data;
		else	data_reg	<= data_reg;
	end
//----<< TRIGGER CLOCK >>---------
end else begin
//---->> SYSTEM CLOCK <<---------
wire	sck_raising;
wire	sck_falling;

edge_generator #(
	.MODE		("FAST"		)   // FAST NORMAL BEST
)edge_generator_inst(
	.clk		(clock			),
	.rst_n      (rst_n			),
	.in         (trigger_clock	),
	.raising    (sck_raising	),
	.falling    (sck_falling	)
);
always@(posedge clock,negedge rst_n)
	if(~rst_n)		point	<= 3'd0;
	else if(cs_n_s)	point	<= 3'd0; // Changed from cs_n to cs_n_s (STARC05-1.3.1.3 fix)
	else if(sck_raising)
					point	<= point + tx_yield;
	else			point	<= point;
always@(posedge clock,negedge rst_n)
	if(~rst_n)	data_reg	<= pre_data; 
	else if(cs_n_s) // Changed from cs_n to cs_n_s (STARC05-1.3.1.3 fix)
				data_reg	<= pre_data;
	else if(!tx_yield)	data_reg	<= pre_data;
	else begin
		if(point == 3'b111 && sck_raising) 
				data_reg	<= pre_data;
		else	data_reg	<= data_reg;
	end
//----<< SYSTEM CLOCK >>---------
end
endgenerate


reg tx_reg;
always@(posedge trigger_clock,negedge trigger_rst_n)
	if(~trigger_rst_n)	tx_reg	<= 1'b0; 
	else begin
		case(point)
		3'b000:	tx_reg	<= data_reg[7]; // Changed to non-blocking (SYNTH_77, W336, W505 fix)
		3'b001:	tx_reg	<= data_reg[6]; // Changed to non-blocking
		3'b010:	tx_reg	<= data_reg[5]; // Changed to non-blocking
		3'b011:	tx_reg	<= data_reg[4]; // Changed to non-blocking
		3'b100:	tx_reg	<= data_reg[3]; // Changed to non-blocking
		3'b101:	tx_reg	<= data_reg[2]; // Changed to non-blocking
		3'b110:	tx_reg	<= data_reg[1]; // Changed to non-blocking
		3'b111:	tx_reg	<= data_reg[0]; // Changed to non-blocking
		// All 3-bit cases for 'point' are covered, no default needed.
		endcase
	end

//----<< TX DATA PRO >>-----------
reg				reload;
always@(posedge trigger_clock,negedge trigger_rst_n)
	if(~trigger_rst_n)	reload	<= 1'b0; 
	else begin
		if(point == 3'b111)
				reload	<= 1'b1;
		else	reload	<= 1'b0;
	end

reg				reloadQ;
always@(posedge trigger_clock,negedge trigger_rst_n)
	if(~trigger_rst_n)	reloadQ	<= 1'b0; 
	else 				reloadQ	<= reload;

wire			reloadQ_raising;

edge_generator #(
	.MODE		("BEST")   // FAST NORMAL BEST
)reloadQ_edge(
	.clk		(clock				),
	.rst_n      (rst_n          	),
	.in         (reloadQ        	),
	.raising    (reloadQ_raising    ),
	.falling    () // Fixed W287b: 'falling' is not connected
);

cross_clk_sync #(
	.LAT			(2		),
	.DSIZE			(1      )
)latency_inst(
	.clk			(clock					),
	.rst_n          (rst_n                  ),
	.d              (!cs_n_s        		), // Fixed STARC05-1.3.1.3: Used synchronized cs_n_s
	.q              (send_flag				)
);

wire	cs_raising;

edge_generator #(
	.MODE		("BEST")   // FAST NORMAL BEST
)cs_edge(
	.clk		(clock				),
	.rst_n      (rst_n          	),
	.in         (!send_flag	       	),
	.raising    (cs_raising		    ),
	.falling    () // Fixed W287b: 'falling' is not connected
);

wire			tx_yield_raising;
edge_generator #(
	.MODE		("BEST")   // FAST NORMAL BEST
)tx_yield_edge(
	.clk		(clock				),
	.rst_n      (rst_n          	),
	.in         (tx_yield	       	),
	.raising    (tx_yield_raising   ),
	.falling    () // Fixed W287b: 'falling' is not connected
);

reg				low_empty;

always@(posedge clock,negedge rst_n)
	if(~rst_n)	low_empty	<= 1'b1;
	else begin
		if(reloadQ_raising)
				low_empty	<= 1'b1;
		else if(cs_raising)
				low_empty	<= 1'b1;
		else if(tx_yield_raising)
				low_empty	<= 1'b1;
		else if(!tx_yield)
			if(low_empty)
					low_empty	<= !send_valid;
			else	low_empty	<= 1'b0;
		else		low_empty	<= 1'b0;
	end	

// Removed 'wire pre_vld;' declaration for W528 fix
wire			pre_empty;
wire			pre_reload;
wire            dummy_sum_empty; // Added to resolve W287b for 'sum_empty'

pipe_reg #(
	.DSIZE				(8)
)pre_data_inst(
/*	input				*/	.clock			(clock			),	
/*	input				*/	.rst_n      	(rst_n          ),
/*	input				*/	.wr_en      	(send_valid     ),
/*	input [DSIZE-1:0]	*/	.indata     	(send_data      ),
/*	input				*/	.low_empty  	(low_empty      ),
/*	outdata				*/	.valid      	(), // Fixed W528: 'pre_vld' was set but not read, now unconnected
/*	outdata				*/	.curr_empty 	(pre_empty      ),
/*	outdata				*/	.sum_empty  	(dummy_sum_empty), // Fixed W287b: 'sum_empty' is not connected
/*	outdata[DSIZE-1:0]	*/	.outdata    	(pre_data       ),
							.high_reload	(pre_reload		)
);


assign	empty	= pre_reload || pre_empty;
assign	miso	= tx_reg;

endmodule
