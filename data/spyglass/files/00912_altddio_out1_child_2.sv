module altddio_out1  (
	datain_h,
	datain_l,
	outclock,
	dataout);


	input	[0:0]  datain_h;
	input	[0:0]  datain_l;
	input	  outclock;
	output	[0:0]  dataout; // Changed dataout from reg to wire as it's now driven by a continuous assignment

    // Internal registers to capture data on respective clock edges
    reg [0:0] data_q_pos; // Captures datain_h on positive edge
    reg [0:0] data_q_neg; // Captures datain_l on negative edge

    // Register datain_h on the positive edge of outclock
    // This resolves the 'bothedges' violation by separating clock edge logic.
    always @(posedge outclock) begin
        data_q_pos <= datain_h;
    end

    // Register datain_l on the negative edge of outclock
    // This also resolves the 'bothedges' violation.
    always @(negedge outclock) begin
        data_q_neg <= datain_l;
    end

    // Combine the registered data using a combinatorial assignment based on outclock's level.
    // When outclock is high, dataout takes data_q_pos (last updated on posedge).
    // When outclock is low, dataout takes data_q_neg (last updated on negedge).
    // This maintains the DDR output behavior and resolves W122 violations as
    // datain_h and datain_l are now correctly used in clocked sequential blocks.
    assign dataout = outclock ? data_q_pos : data_q_neg;

endmodule
