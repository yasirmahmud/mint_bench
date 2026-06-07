module debouncer2(
    input [data_width-1:0] Buttons_in,
    output reg [data_width-1:0] Buttons_out,
    input Clk
    );

	parameter depth_select = 4;  // number of clock cycles to debounce input signal
	parameter data_width = 5;  // number of inputs to debounce

   reg [depth_select-1:0] button_ff [data_width-1:0];  // temp counters to sample input
	reg [depth_select-1:0] valid_state;  // generates valid state to compare against counter value

   genvar i;
   generate
		for (i=0; i < data_width; i=i+1) 
		begin: input_registers
			always @(posedge Clk)
				if ((Buttons_in[i]) && (button_ff[i] < valid_state))
					button_ff[i] = button_ff[i] + 1 ;
				else if ((Buttons_in[i]) && (button_ff[i] == valid_state))
					button_ff[i] = button_ff[i];
				else
					button_ff[i] = 0 ;
			
			always @(posedge Clk)
				if (button_ff[i] == valid_state)
					Buttons_out[i] = 1;
				else
					Buttons_out[i] = 0 ;
		end	
	endgenerate

//	 Generate signal to compare against input counter
   genvar k;
   generate
		for (k=0; k < depth_select; k=k+1) 
		begin: valid_input_test
			always @(posedge Clk)
				valid_state <= {valid_state[depth_select-2:0], 1'b1};
      end	
	endgenerate

endmodule
