module topModuleV2(     
    in_start_conv, clk, 			// the signal for begining and clk
	in_cfg_ci, in_cfg_co, 			// the number of channels, and the number of kernels,
	in_wdata0, in_wdata1, in_wdata2, in_wdata3, in_wdata4, in_wdata5, in_wdata6, in_wdata7,  // weights data and feature map data
	in_fdata0, in_fdata1, in_fdata2, in_fdata3, in_fdata4, in_fdata5, in_fdata6, in_fdata7,  
	out_data0, out_data1,			// output data
	out_readw_ctl,out_readi_ctl,	// the signal to get fmap or weights
	out_write_ctl,					// the signal to write output
	out_end_conv					// the signal for ending
);
	// ======== 1. The part for setting parameters
    parameter lenOfInput=8;    		//the number of input-data bits 
    parameter lenOfOutput=25;  		//the number of output-data bits
    parameter numOfPerKnl=16; 		//the number of kernel value
	parameter numOfPerOutFmp=61*61; 	//the number of values in out-fMap
     
	// ======== 2. The part for declaring input or output variables of this module. And getting control information from testbench.
    // input data
	input clk, in_start_conv;
	input [2:0] in_cfg_ci;  		//the number of channels,  		0 means 8, 1 means 16, 3 means 24, 3 means 32
	input [2:0] in_cfg_co;      	//the number of kernels,         0 means 8, 1 means 16, 3 means 24, 3 means 32
    input signed [lenOfInput-1:0] in_wdata0, in_wdata1, in_wdata2, in_wdata3, in_wdata4, in_wdata5, in_wdata6, in_wdata7;
	input signed [lenOfInput-1:0] in_fdata0, in_fdata1, in_fdata2, in_fdata3, in_fdata4, in_fdata5, in_fdata6, in_fdata7;
	//output data
    output signed [lenOfOutput-1:0] out_data0, out_data1;
	output out_readw_ctl,out_readi_ctl;		// the signals to get fmap and weights, 1 is yes
    output out_write_ctl; 			// the signal we are going to output data, 1 is yes.
	output out_end_conv;   			//the finish signal of CONV, 1 means finish
	
	// ======== 3. The part for setting register for every output variables.
	// reg for out_data0, out_data1;
	reg signed [lenOfOutput-1:0] reg_out_data0, reg_out_data1;
	assign out_data0=reg_out_data0;
	assign out_data1=reg_out_data1;
	
	//set one reg to connect out_readw_ctl and out_readi_ctl
	reg reg_out_readw_ctl;
	assign out_readw_ctl=reg_out_readw_ctl;
	reg reg_out_readi_ctl;
	assign out_readi_ctl=reg_out_readi_ctl;
	
	//set one reg to connect out_writeCtl and out_end_conv
	reg reg_out_write_ctl;
	assign out_write_ctl=reg_out_write_ctl;
	
	//set one reg to connect out_end_conv and reg_out_end_conv
	reg reg_out_end_conv;
	assign out_end_conv=reg_out_end_conv;
	
	
	// ======== 4. The part for declaring our variables for calculation, such as kernel and data array.
    //kernel 4*4, store the value of a kernel, 4*4
    reg signed [lenOfInput-1:0] kernel00, kernel01, kernel02, kernel03, 
			kernel10, kernel11, kernel12, kernel13, 
			kernel20, kernel21, kernel22, kernel23, 
			kernel30, kernel31, kernel32, kernel33;
	
	//data 4*4, store the value of a data, 4*4
	reg signed [lenOfInput-1:0] data00, data01, data02, data03, 
			data10, data11, data12, data13, 
			data20, data21, data22, data23, 
			data30, data31, data32, data33;
	
	// ======== 5. The part for declaring our variables for CONV modules.
	// the data should be shifting 2 bits.
	reg signed [lenOfInput-1:0] tmpData0,tmpData1,tmpData2,tmpData3;
	//wire for recieving the data from CONVs
	wire signed [lenOfOutput-1:0] convOut0,convOut1; //the output of conv0 and conv1.
	
	// set two CONV modules. One for the first CONV, and two for consecutive CONVs
	convMod #(.lenOfInput(lenOfInput), .lenOfOutput(lenOfOutput)) conv0(
		.in00(tmpData0), .in01(data00), .in02(data01), .in03(data02),
		.in10(tmpData1), .in11(data10), .in12(data11), .in13(data12),
		.in20(tmpData2), .in21(data20), .in22(data21), .in23(data22),
		.in30(tmpData3), .in31(data30), .in32(data31), .in33(data32),
		.k00(kernel00), .k01(kernel01), .k02(kernel02), .k03(kernel03),
		.k10(kernel10), .k11(kernel11), .k12(kernel12), .k13(kernel13),
		.k20(kernel20), .k21(kernel21), .k22(kernel22), .k23(kernel23),
		.k30(kernel30), .k31(kernel31), .k32(kernel32), .k33(kernel33),
		.convOut(convOut0)
	);
	
	convMod #(.lenOfInput(lenOfInput), .lenOfOutput(lenOfOutput)) conv1(
		.in00(data00), .in01(data01), .in02(data02), .in03(data03),
		.in10(data10), .in11(data11), .in12(data12), .in13(data13),
		.in20(data20), .in21(data21), .in22(data22), .in23(data23),
		.in30(data30), .in31(data31), .in32(data32), .in33(data33),
		.k00(kernel00), .k01(kernel01), .k02(kernel02), .k03(kernel03),
		.k10(kernel10), .k11(kernel11), .k12(kernel12), .k13(kernel13),
		.k20(kernel20), .k21(kernel21), .k22(kernel22), .k23(kernel23),
		.k30(kernel30), .k31(kernel31), .k32(kernel32), .k33(kernel33),
		.convOut(convOut1)
	);
	
	// ======== 6. The part for Memory variables for storing results.
	// Set the control information from the crontrol signal
	integer numOfKernels;
	integer numOfChannels;
	// the memory for results.
	reg signed [lenOfOutput-1:0] convResults [numOfPerOutFmp-1:0];
	integer i_conv;
	
	// ======== 7. The part for getting data from testbench and doing calculation.
	integer kernelCounter; 	// to count the id of this kernel
	integer channelCounter; 	// to count the id of this channel
	integer rowCounter;		// to count the id of the beginning row of data in this CONV, the row position of FMap
	integer cycleCounter; //the number of cycles during CONV
    // begin to recieve data and count the cycle
	integer temp; //temporary variable
	
	reg reset_memory;
	
    // Next state variables to avoid multiple assignments to the same 'reg' in non-mutually exclusive blocks
    // and to combine assignments from separate 'always' blocks.
    reg next_reset_memory;
    integer next_numOfChannels; 
    integer next_numOfKernels;  
    reg next_reg_out_readw_ctl, next_reg_out_readi_ctl;
    reg next_reg_out_write_ctl;
    reg next_reg_out_end_conv;
    integer next_kernelCounter, next_channelCounter, next_rowCounter, next_cycleCounter;
    integer next_temp;

    reg signed [lenOfOutput-1:0] next_reg_out_data0, next_reg_out_data1;

    always @(posedge clk) begin
        // Default assignments (no change unless explicitly updated later in the block)
        next_reset_memory = reset_memory;
        next_numOfChannels = numOfChannels;
        next_numOfKernels = numOfKernels;
        next_reg_out_readw_ctl = reg_out_readw_ctl;
        next_reg_out_readi_ctl = reg_out_readi_ctl;
        next_reg_out_write_ctl = reg_out_write_ctl;
        next_reg_out_end_conv = reg_out_end_conv;
        next_kernelCounter = kernelCounter;
        next_channelCounter = channelCounter;
        next_rowCounter = rowCounter;
        next_cycleCounter = cycleCounter;
        next_temp = temp;
        next_reg_out_data0 = 0; // Default output data to 0 when not actively writing
        next_reg_out_data1 = 0;

        // Logic to clear convolution results memory when reset_memory is asserted
        if (reset_memory == 1) begin
            for(i_conv=0;i_conv<numOfPerOutFmp;i_conv=i_conv+1) begin
                convResults[i_conv]<=0;
            end
            next_reset_memory = 0; // Clear the reset_memory flag after memory is reset
        end
	
		if(in_start_conv==0) begin	//the initial value of variables
			// Set numOfChannels
			case(in_cfg_ci) 
				3'b000: next_numOfChannels = 8;
				3'b001: next_numOfChannels = 16;
				3'b010: next_numOfChannels = 24;
				3'b011: next_numOfChannels = 32;
                default: next_numOfChannels = 8; // Safely handle undefined inputs
			endcase;
			// Set numOfKernels
			case(in_cfg_co) 
				3'b000: next_numOfKernels = 8;
				3'b001: next_numOfKernels = 16;
				3'b010: next_numOfKernels = 24;
				3'b011: next_numOfKernels = 32;
                default: next_numOfKernels = 8; // Safely handle undefined inputs
			endcase;
			
			next_reg_out_readw_ctl = 1;
			next_reg_out_readi_ctl = 1;
			next_reg_out_write_ctl = 0;
			next_reg_out_end_conv = 0;
			
			next_reset_memory = 0; // Ensure memory reset flag is low during initial state
			
			next_kernelCounter = 0;
			next_channelCounter = 0;
			next_rowCounter = 0;
			next_cycleCounter = 0;
			next_temp = 0;

            // Also reset output data when in initial state
            next_reg_out_data0 = 0;
            next_reg_out_data1 = 0;

		end
		else begin // in_start_conv==1, beginning working!
			if(cycleCounter==0) begin			//get kernel of a channel: 0-1st row; get fmap: 0-1st column.
				if(reg_out_readw_ctl==1) begin	// Use current control signal for data read
					kernel00<=in_wdata0;
					kernel01<=in_wdata1;
					kernel02<=in_wdata2;
					kernel03<=in_wdata3;
					
					kernel10<=in_wdata4;
					kernel11<=in_wdata5;
					kernel12<=in_wdata6;
					kernel13<=in_wdata7;
				end
				if(reg_out_readi_ctl==1) begin // Use current control signal for data read
					data00<=in_fdata0;
					data10<=in_fdata1;
					data20<=in_fdata2;
					data30<=in_fdata3;
					
					data01<=in_fdata4;
					data11<=in_fdata5;
					data21<=in_fdata6;
					data31<=in_fdata7;
				end
			end
			else if(cycleCounter==1) begin		//get kernel of a channel: 2nd-3rd row; get fmap: 2nd-3rd column.
				if(reg_out_readw_ctl==1) begin
					kernel20<=in_wdata0;
					kernel21<=in_wdata1;
					kernel22<=in_wdata2;
					kernel23<=in_wdata3;
					
					kernel30<=in_wdata4;
					kernel31<=in_wdata5;
					kernel32<=in_wdata6;
					kernel33<=in_wdata7;
					
					next_reg_out_readw_ctl = 0; // close the signal of getting kernel.
				end
				if(reg_out_readi_ctl==1) begin
					data02<=in_fdata0;
					data12<=in_fdata1;
					data22<=in_fdata2;
					data32<=in_fdata3;
					
					data03<=in_fdata4;
					data13<=in_fdata5;
					data23<=in_fdata6;
					data33<=in_fdata7;
				end
			end
			else if(cycleCounter==2) begin  	//get last result of 1 CONV and move 2 column fmap (getting new fmap).
				//get last result of 1 CONV
				convResults[temp] <= convResults[temp]+convOut1;
				next_temp = temp+1;
				
				// Left move 2 column
				tmpData0<=data01;
				tmpData1<=data11;
				tmpData2<=data21;
				tmpData3<=data31;
				
				data00<=data02;
				data10<=data12;
				data20<=data22;
				data30<=data32;
				
				data01<=data03;
				data11<=data13;
				data21<=data23;
				data31<=data33;
				
				data02<=in_fdata0;
				data12<=in_fdata1;
				data22<=in_fdata2;
				data32<=in_fdata3;
								
				data03<=in_fdata4;
				data13<=in_fdata5;
				data23<=in_fdata6;
				data33<=in_fdata7;
			end
			else if(cycleCounter>=3 && cycleCounter<=31) begin		//get last result of 2 CONV and move 2 column fmap (getting new fmap).
				//get last result of 2 CONV
				convResults[temp] <= convResults[temp]+convOut0; 		// doing CONV once
				convResults[temp+1] <= convResults[temp+1]+convOut1;	// doing CONV twice	
				next_temp = temp+2;
				
				// Left move 2 column
				tmpData0<=data01;
				tmpData1<=data11;
				tmpData2<=data21;
				tmpData3<=data31;
				
				data00<=data02;
				data10<=data12;
				data20<=data22;
				data30<=data32;
				
				data01<=data03;
				data11<=data13;
				data21<=data23;
				data31<=data33;
				
				data02<=in_fdata0;
				data12<=in_fdata1;
				data22<=in_fdata2;
				data32<=in_fdata3;
								
				data03<=in_fdata4;
				data13<=in_fdata5;
				data23<=in_fdata6;
				data33<=in_fdata7;
				
				if(cycleCounter==31) next_reg_out_readi_ctl = 0;	//close the signal of getting fmap
			end 
			else if(cycleCounter==32) begin 	//get last result of 2 CONV.			
				//get last result of 2 CONV
				convResults[temp] <= convResults[temp]+convOut0;
				convResults[temp+1] <= convResults[temp+1]+convOut1;
				next_temp = temp+2;
			end
			else if(cycleCounter==33) begin
				next_reg_out_readi_ctl = 1;	//open the signal of getting fmap
            end
			
			//cycleCounter: 32 is for sending data and closing output-signal
			if(cycleCounter!=33) begin
				next_cycleCounter = cycleCounter+1;
            end
			else begin								// new row
				next_cycleCounter = 0;
				if(rowCounter!=60) begin
					next_rowCounter = rowCounter+1;
                end
				else begin 								// new channel
					next_rowCounter = 0;
					next_temp = 0;
					next_reg_out_readw_ctl = 1; 				// open the signal of getting kernel
					if(channelCounter!=numOfChannels-1) begin
						next_channelCounter = channelCounter+1;
                    end
					else begin								// new kernel
						next_reset_memory = 1; // Assert reset_memory to initial the MEMORY in the next cycle!!!
						next_channelCounter = 0;
						if(kernelCounter!=numOfKernels-1) begin
							next_kernelCounter = kernelCounter+1;				
						end
						else begin // last kernel, all works done!
                            next_kernelCounter = 0; // Reset kernel counter for potential restart
							next_reg_out_end_conv = 1;
                        end
					end
				end
			end

            // Output data logic
            if(channelCounter==numOfChannels-1) begin
                if(cycleCounter==2) begin
                    next_reg_out_write_ctl = 1; //open the output-signal
                    next_reg_out_data0 = (convResults[temp]+convOut1)<0?0:(convResults[temp]+convOut1);
                    next_reg_out_data1 = -1;
                end
                else if(cycleCounter>=3 && cycleCounter<=32) begin // Consolidated output during active cycles
                    next_reg_out_write_ctl = 1; // Keep output-signal high
                    next_reg_out_data0 = (convResults[temp]+convOut0)<0?0:(convResults[temp]+convOut0);
                    next_reg_out_data1 = (convResults[temp+1]+convOut1)<0?0:(convResults[temp+1]+convOut1);
                end
                else if(cycleCounter==33) begin
                    next_reg_out_write_ctl = 0; //closing the output-signal
                    // reg_out_end_conv is handled in the main counter logic above
                end
            end
            else begin // Not in the last channel, outputs should be off
                next_reg_out_write_ctl = 0;
            end
		end // end else if(in_start_conv==1)

        // Apply all next state values to their respective registers
        reset_memory <= next_reset_memory;
        numOfChannels <= next_numOfChannels;
        numOfKernels <= next_numOfKernels;
        reg_out_readw_ctl <= next_reg_out_readw_ctl;
        reg_out_readi_ctl <= next_reg_out_readi_ctl;
        reg_out_write_ctl <= next_reg_out_write_ctl;
        reg_out_end_conv <= next_reg_out_end_conv;
        kernelCounter <= next_kernelCounter;
        channelCounter <= next_channelCounter;
        rowCounter <= next_rowCounter;
        cycleCounter <= next_cycleCounter;
        temp <= next_temp;
        reg_out_data0 <= next_reg_out_data0;
        reg_out_data1 <= next_reg_out_data1;
    end // end always @(posedge clk)
		
endmodule
