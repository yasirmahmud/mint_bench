module altddio_out1  (
	datain_h,
	datain_l,
	outclock,
	dataout);


	input	[0:0]  datain_h;
	input	[0:0]  datain_l;
	input	  outclock;
	output	reg [0:0]  dataout;

    // Implement double data rate output driver
    // dataout updates on both clock edges using datain_h on positive edge
    // and datain_l on negative edge.
    always @(posedge outclock or negedge outclock) begin
        if (outclock) begin
            dataout <= datain_h; // Assign high data on positive edge/when clock is high
        end else begin
            dataout <= datain_l; // Assign low data on negative edge/when clock is low
        end
    end

endmodule
