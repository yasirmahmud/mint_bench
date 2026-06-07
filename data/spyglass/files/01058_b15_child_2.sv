module b15(BE_n, Address, W_R_n, D_C_n, M_IO_n, ADS_n, Datai, Datao, CLOCK, NA_n, BS16_n, READY_n, HOLD, RESET);

input CLOCK;
input RESET;
input NA_n;
input BS16_n;
input READY_n;
input HOLD;
input [31:0] Datai;

output reg [3:0] BE_n;
output reg [31:0] Address;
output reg W_R_n;
output reg D_C_n;
output reg M_IO_n;
output reg ADS_n;
output reg [31:0] Datao;




wire signed [31:0] sDatai = Datai;	


reg StateBS16;
reg RequestPending;
parameter Pending = 1'b1;
parameter NotPending = 1'b0;
//reg NonAligned; // Removed: Unused
reg ReadRequest;
reg MemoryFetch;
reg CodeFetch;
reg [3:0] ByteEnable;
reg [31:0] DataWidth;
parameter WidthByte = 32'd0;
parameter WidthWord = 32'd1;
parameter WidthDword = 32'd2;

reg [3:0] State;

parameter StateInit = 4'd0;
parameter StateTi = 4'd1;
parameter StateT1 = 4'd2;
parameter StateT2 = 4'd3;
parameter StateT1P = 4'd4;
parameter StateTh = 4'd5;
parameter StateT2P = 4'd6;
parameter StateT2I = 4'd7;

parameter ZERO = 2'd0;
parameter ONE = 2'd1;
parameter TWO = 2'd2;
parameter THREE = 2'd3;

reg signed[31:0] EAX;
reg signed[31:0] EBX;
reg signed[31:0] rEIP;

parameter REP = 8'HF3;
parameter REPNE = 8'HF2;
parameter LOCK = 8'HF0;

parameter CSsop = 8'H2E;
parameter SSsop = 8'H36;
parameter DSsop = 8'H3E;
parameter ESsop = 8'H26;
parameter FSsop = 8'H64;
parameter GSsop = 8'H65;
parameter OPsop = 8'H66;
parameter ADsop = 8'H67;

parameter MOV_al_b = 8'HB0;
parameter MOV_eax_dw = 8'HB8;
parameter MOV_ebx_dw = 8'HBB;
parameter MOV_ebx_eax = 8'H89;
parameter MOV_eax_ebx = 8'H8B;
parameter IN_al = 8'HE4;
parameter OUT_al = 8'HE6;
parameter ADD_al_b = 8'H04;
parameter ADD_ax_w = 8'H05;
parameter ROL_eax_b = 8'HD1;
parameter ROL_al_1 = 8'HD0;
parameter ROL_al_n = 8'HC0;
parameter INC_eax = 8'H40;
parameter INC_ebx = 8'H43;
parameter JMP_rel_short = 8'HEB;
parameter JMP_rel_near = 8'HE9;
parameter JMP_intseg_immed = 8'HEA;
parameter HLT = 8'HF4;
parameter WAITx = 8'H9B;
parameter NOP = 8'H90;
parameter queue_size = 16;
parameter InstQueueLimit = queue_size-1;
parameter Si = 4'd0;
parameter S1 = 4'd1;
parameter S2 = 4'd2;
parameter S3 = 4'd3;
parameter S4 = 4'd4;
parameter S5 = 4'd5;
parameter S6 = 4'd6;
parameter S7 = 4'd7;
parameter S8 = 4'd8;
parameter S9 = 4'd9;
//moved from 234

parameter FALSE = 1'b0;
parameter TRUE = 1'b1;

reg [31:0]InstQueue [0:queue_size-1];
reg [31:0] InstQueueRd_Addr;
reg [31:0] InstQueueWr_Addr;
reg signed [31:0] InstAddrPointer;
reg signed[31:0] PhyAddrPointer;
//reg signed[31:0] TEMPORARY;//removed: Replaced with local variables for combinatorial operations
//reg Extended; // Removed: Unused
reg More;
reg Flush;
reg [31:0] lWord;
reg [31:0] uWord;
reg signed[31:0] fWord;
reg [3:0] State2;


reg [8*31:1] string_value; 

always @(posedge CLOCK, posedge RESET) begin
    reg [31:0] temp_addr_calc; // Added to fix STX_VE_481
    if(RESET == 1'b1) begin	
		BE_n <= 4'b0000;
		Address <= 0;
		W_R_n <= 1'b0;
		D_C_n <= 1'b0;
		M_IO_n <= 1'b0;
		ADS_n <= 1'b0;
		State <= StateInit;
		//StateNA <= 1'b0; // Removed: Unused
		StateBS16 <= 1'b0;
		DataWidth <= 0;
		end else begin
		case(State)
			StateInit : begin
				D_C_n <= 1'b1;
				ADS_n <= 1'b1;
				State <= StateTi;
				//StateNA <= 1'b1; // Removed: Unused
				StateBS16 <= 1'b1;
				DataWidth <= WidthDword;
				// Redundant assignment removed: State <= StateTi;
			end
			StateTi : begin
				if(RequestPending == Pending) begin
					State <= StateT1;
				end
				else if(HOLD == 1'b1) begin
					State <= StateTh;
				end
				else begin
					State <= StateTi;
				end
				end
			StateT1 : begin
				// Address <= rEIP/4;
				// fs 062299
				temp_addr_calc = rEIP / 4; // Fix for STX_VE_481
				Address <= temp_addr_calc [29:0]; // Fix for STX_VE_481
				BE_n <= ByteEnable;
				M_IO_n <= MemoryFetch;
				if(ReadRequest == Pending) begin
					W_R_n <= 1'b0;
				end
				else begin
					W_R_n <= 1'b1;
				end
				if(CodeFetch == Pending) begin					
					D_C_n <= 1'b0;
				end
				else begin
					D_C_n <= 1'b1;
				end
				ADS_n <= 1'b0;
				State <= StateT2;
				end
			StateT2 : begin
				if(READY_n == 1'b0 && HOLD == 1'b0 && RequestPending == Pending) begin
					State <= StateT1;
				end
				else if(READY_n == 1'b1 && NA_n == 1'b1) begin
					// No state change, stay in T2, outputs remain as is.
				end
				else if((RequestPending == Pending || HOLD == 1'b1) && (READY_n == 1'b1 && NA_n == 1'b0)) begin
					State <= StateT2I;
				end
				else if(RequestPending == Pending && HOLD == 1'b0 && READY_n == 1'b1 && NA_n == 1'b0) begin
					State <= StateT2P;
				end
				else if(RequestPending == NotPending && HOLD == 1'b0 && READY_n == 1'b0) begin
					State <= StateTi;
				end
				else if(HOLD == 1'b1 && READY_n == 1'b1) begin
					State <= StateTh;
				end
				else begin
					State <= StateT2;
				end
				StateBS16 <= BS16_n;
				if(BS16_n == 1'b0) begin
					DataWidth <= WidthWord;
				end
				else begin
					DataWidth <= WidthDword;
				end
				//StateNA <= NA_n; // Removed: Unused
				ADS_n <= 1'b1;
				end
			StateT1P : begin
				if(NA_n == 1'b0 && HOLD == 1'b0 && RequestPending == Pending) begin
					State <= StateT2P;
				end
				else if(NA_n == 1'b0 && (HOLD == 1'b1 || RequestPending == NotPending)) begin
					State <= StateT2I;
				end
				else if(NA_n == 1'b1) begin
					State <= StateT2;
				end
				else begin
					State <= StateT1P;
				end
				StateBS16 <= BS16_n;
				if(BS16_n == 1'b0) begin
					DataWidth <= WidthWord;
				end
				else begin
					DataWidth <= WidthDword;
				end
				//StateNA <= NA_n; // Removed: Unused
				ADS_n <= 1'b1;
				end
			StateTh : begin
				if(HOLD == 1'b0 && RequestPending == Pending) begin
					State <= StateT1;
				end
				else if(HOLD == 1'b0 && RequestPending == NotPending) begin
					State <= StateTi;
				end
				else begin
					State <= StateTh;
				end
				end
			StateT2P : begin
				// Address <= rEIP/2;
				// fs 990629
				temp_addr_calc = rEIP / 2; // Fix for STX_VE_481
				Address <= temp_addr_calc [29:0]; // Fix for STX_VE_481
				BE_n <= ByteEnable;
				M_IO_n <= MemoryFetch;
				if(ReadRequest == Pending) begin
				W_R_n <= 1'b0;
				end
				else begin
					W_R_n <= 1'b1;
				end
				if(CodeFetch == Pending) begin
					D_C_n <= 1'b0;
				end
				else begin
					D_C_n <= 1'b1;
				end
				ADS_n <= 1'b0;
				if(READY_n == 1'b0) begin
					State <= StateT1P;
				end
				else begin
					State <= StateT2P;
				end
				end
			StateT2I : begin
				if(READY_n == 1'b1 && RequestPending == Pending && HOLD == 1'b0) begin
					State <= StateT2P;
				end
				else if(READY_n == 1'b0 && HOLD == 1'b1) begin
					State <= StateTh;
				end
				else if(READY_n == 1'b0 && HOLD == 1'b0 && RequestPending == Pending) begin
					State <= StateT1;
				end
				else if(READY_n == 1'b0 && HOLD == 1'b0 && RequestPending == NotPending) begin
					State <= StateTi;
				end
				else begin
					State <= StateT2I;
				end
				end
			endcase
		end
end
integer i;
always @(posedge CLOCK, posedge RESET) begin : P1
	reg signed [31:0] local_temporary_calc; // Fix for STX_VE_606, STX_VE_606, STX_VE_481 (changed 'logic' to 'reg', moved to top of block)
	reg [31:0] temp_data_extract; // Added to fix STX_VE_481

	
    if(RESET == 1'b1) begin
		State2 <= Si;
		//InstQueue := (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
		for(i = 0; i<queue_size; i =i +1) begin
			InstQueue[i] <= 0;
		end
		InstQueueRd_Addr <= 0;
		InstQueueWr_Addr <= 0;
		InstAddrPointer <= 0;
		PhyAddrPointer <= 0;
		//Extended <= FALSE; // Removed: Unused
		More <= FALSE;
		Flush <= FALSE;
		lWord <= 0;
		uWord <= 0;
		fWord <= 0;
		CodeFetch <= 1'b0;
		Datao <= 0;
		EAX <= 0;
		EBX <= 0;
		rEIP <= 0;
		ReadRequest <= 1'b0;
		MemoryFetch <= 1'b0;
		RequestPending <= 1'b0;
		end else begin
		case(State2)
			Si : begin
				PhyAddrPointer <= rEIP;
				InstAddrPointer <= PhyAddrPointer;
				State2 <= S1;
				rEIP <= 'HFFFF0;
				ReadRequest <= 1'b1;
				MemoryFetch <= 1'b1;
				RequestPending <= 1'b1;
			end
			S1 : begin
				RequestPending <= Pending;
				ReadRequest <= Pending;
				MemoryFetch <= Pending;
				CodeFetch <= Pending;
				if(READY_n == 1'b0) begin
					State2 <= S2;
				end
				else begin
					State2 <= S1;
				end
			end
			S2 : begin
				integer local_InstQueueWr_Addr; // Use local integer for combinatorial calculation
				RequestPending <= NotPending;

				local_InstQueueWr_Addr = InstQueueWr_Addr; // Start from current register value
				InstQueue[local_InstQueueWr_Addr] <= Datai % (2 ** 8);
				local_InstQueueWr_Addr = (local_InstQueueWr_Addr + 1) % queue_size;

				//            InstQueue(InstQueueWr_Addr) := (Datai / (2**8)) mod (2**8);
				InstQueue[local_InstQueueWr_Addr] <= (Datai / (2**8)) % (2**8); // Using local_InstQueueWr_Addr for next index
				local_InstQueueWr_Addr = (local_InstQueueWr_Addr + 1) % queue_size;

				if(StateBS16 == 1'b1) begin
					temp_data_extract = (sDatai / (2 ** 16)); // Fix for STX_VE_481
					InstQueue[local_InstQueueWr_Addr] <= temp_data_extract [7:0]; // Fix for STX_VE_481
					local_InstQueueWr_Addr = (local_InstQueueWr_Addr + 1) % queue_size;
					temp_data_extract = (sDatai / (2 ** 24)); // Fix for STX_VE_481
					InstQueue[local_InstQueueWr_Addr] <= temp_data_extract [7:0]; // Fix for STX_VE_481
					local_InstQueueWr_Addr = (local_InstQueueWr_Addr + 1) % queue_size;
					PhyAddrPointer <= PhyAddrPointer + 4;
					State2 <= S5;
				end
				else begin
					PhyAddrPointer <= PhyAddrPointer + 2;
					if((PhyAddrPointer < 0)) begin
						rEIP <= -PhyAddrPointer;
					end
					else begin
						rEIP <= PhyAddrPointer;
					end
					State2 <= S3;
				end
				InstQueueWr_Addr <= local_InstQueueWr_Addr; // Update actual register non-blockingly
			end
			S3 : begin
				RequestPending <= Pending;
				if(READY_n == 1'b0) begin
					State2 <= S4;
				end
				else begin
					State2 <= S3;
				end
			end
			S4 : begin
				integer local_InstQueueWr_Addr; // Use local integer for combinatorial calculation
				RequestPending <= NotPending;

				local_InstQueueWr_Addr = InstQueueWr_Addr; // Start from current register value
				InstQueue[local_InstQueueWr_Addr] <= Datai % (2 ** 8);
				local_InstQueueWr_Addr = (local_InstQueueWr_Addr + 1) % queue_size;

				InstQueue[local_InstQueueWr_Addr] <= (Datai / (2**8)) % (2**8); // Using local_InstQueueWr_Addr for next index (fix based on prev. comment)
				local_InstQueueWr_Addr = (local_InstQueueWr_Addr + 1) % queue_size;

				PhyAddrPointer <= PhyAddrPointer + 2;
				State2 <= S5;
				InstQueueWr_Addr <= local_InstQueueWr_Addr; // Update actual register non-blockingly
			end
			S5 : begin
				// local_temporary_calc is now declared at the top of the 'P1' block.
				
				case(InstQueue[InstQueueRd_Addr][7:0]) // Use [7:0] slice for opcode comparison
					NOP : begin
						InstAddrPointer <= InstAddrPointer + 1;
						InstQueueRd_Addr <= (InstQueueRd_Addr + 1) % queue_size;
						Flush <= FALSE;
						More <= FALSE;
					end
					OPsop : begin
						InstAddrPointer <= InstAddrPointer + 1;
						InstQueueRd_Addr <= (InstQueueRd_Addr + 1) % queue_size;
						//Extended <= TRUE; // Removed: Unused
						Flush <= FALSE;
						More <= FALSE;
					end
					JMP_rel_short : begin
						local_temporary_calc = InstQueueWr_Addr - InstQueueRd_Addr;
						if(local_temporary_calc >= 3) begin
							//if((InstQueueWr_Addr - InstQueueRd_Addr) >= 3) begin
							if((InstQueue[(InstQueueRd_Addr + 1)% queue_size]) > 127) begin
								//IF InstQueue((InstQueueRd_Addr +1) mod 16) > 127 THEN
							PhyAddrPointer <= InstAddrPointer + 1 - ((16'HFF - InstQueue[(InstQueueRd_Addr + 1)%queue_size]));
								//PhyAddrPointer := InstAddrPointer + 1 - (16#FF# - InstQueue((InstQueueRd_Addr +1) mod 16));
							InstAddrPointer <= PhyAddrPointer;
							end
							else begin
							PhyAddrPointer <= InstAddrPointer + 2 + (InstQueue[(InstQueueRd_Addr + 1)%queue_size]);//edited
								//PhyAddrPointer := InstAddrPointer + 2 + InstQueue((InstQueueRd_Addr +1)mod 16);
							InstAddrPointer <= PhyAddrPointer;
							end
							Flush <= TRUE;
							More <= FALSE;
						end
							else begin
							Flush <= FALSE;
							More <= TRUE;
						end
					end
					JMP_rel_near : begin
						local_temporary_calc = InstQueueWr_Addr - InstQueueRd_Addr;
						if(local_temporary_calc >= 5) begin
							//if((InstQueueWr_Addr - InstQueueRd_Addr) >= 5) begin
							PhyAddrPointer <= InstAddrPointer + 5 + (InstQueue[(InstQueueRd_Addr + 1)%queue_size]);//edited
							//PhyAddrPointer := InstAddrPointer + 5 + InstQueue((InstQueueRd_Addr +1)mod 16);
							InstAddrPointer <= PhyAddrPointer;
							Flush <= TRUE;
							More <= FALSE;
						end
							else begin
							Flush <= FALSE;
							More <= TRUE;
						end
					end
					JMP_intseg_immed : begin
						InstAddrPointer <= InstAddrPointer + 1;
						InstQueueRd_Addr <= (InstQueueRd_Addr + 1) % queue_size;
						Flush <= FALSE;
						More <= FALSE; 
					end
					MOV_al_b : begin
						InstAddrPointer <= InstAddrPointer + 1;
						InstQueueRd_Addr <= (InstQueueRd_Addr + 1) % queue_size; 
						Flush <= FALSE;
						More <= FALSE;
					end
					MOV_eax_dw : begin
						local_temporary_calc = InstQueueWr_Addr - InstQueueRd_Addr;
						if(local_temporary_calc >= 5) begin//if((InstQueueWr_Addr - InstQueueRd_Addr) >= 5) begin
						EAX <= (InstQueue[(InstQueueRd_Addr + 4)%queue_size]) * (2 ** 23) + (InstQueue[(InstQueueRd_Addr + 3)%queue_size]) * (2 ** queue_size) + (InstQueue[(InstQueueRd_Addr + 2)%queue_size]) * (2 ** 8) + (InstQueue[(InstQueueRd_Addr + 1)%queue_size]);//edited
							//EAX <= InstQueue((InstQueueRd_Addr +4)mod 16)*(2**23) + InstQueue((InstQueueRd_Addr +3) mod 16)*(2**16) + InstQueue((InstQueueRd_Addr +2) mod 16)*(2**8) + InstQueue((InstQueueRd_Addr+1)mod 16);
							More <= FALSE;
							Flush <= FALSE;
							InstAddrPointer <= InstAddrPointer + 5;
							InstQueueRd_Addr <= (InstQueueRd_Addr + 5) % queue_size;
						end
							else begin
							Flush <= FALSE;
							More <= TRUE;
						end
					end
					MOV_ebx_dw : begin
						local_temporary_calc = InstQueueWr_Addr - InstQueueRd_Addr;
						if(local_temporary_calc >= 5) begin
							//if((InstQueueWr_Addr - InstQueueRd_Addr) >= 5) begin
							EBX <= (InstQueue[(InstQueueRd_Addr + 4)% 16]) * (2 ** 23) + (InstQueue[(InstQueueRd_Addr + 3)%16]) * (2 ** queue_size) + (InstQueue[(InstQueueRd_Addr + 2)%queue_size]) * (2 ** 8) + (InstQueue[(InstQueueRd_Addr + 1)%1]);//edited
							//EBX <= InstQueue((InstQueueRd_Addr+4) mod 16)*(2**23) + InstQueue((InstQueueRd_Addr +3) mod 16)*(2**16) + InstQueue((InstQueueRd_Addr +2) mod 16)*(2**8) + InstQueue((InstQueueRd_Addr +1) mod 1);
							More <= FALSE;
							Flush <= FALSE;
							InstAddrPointer <= InstAddrPointer + 5;
							InstQueueRd_Addr <= (InstQueueRd_Addr + 5) % queue_size;
						end
							else begin
							Flush <= FALSE;
							More <= TRUE;
						end
					end
					MOV_eax_ebx : begin
						local_temporary_calc = InstQueueWr_Addr - InstQueueRd_Addr;
						if(local_temporary_calc >= 2) begin
							//if((InstQueueWr_Addr - InstQueueRd_Addr) >= 2) begin
							if((PhyAddrPointer < 0)) begin
								rEIP <= -EBX; // This uses EBX from current cycle
							end
							else begin
								rEIP <= EBX; // This uses EBX from current cycle
							end
							RequestPending <= Pending;
							ReadRequest <= Pending;
							MemoryFetch <= Pending;
							CodeFetch <= NotPending;
							if(READY_n == 1'b0) begin
								RequestPending <= NotPending;
								uWord <= Datai % (2 ** 15);
								if(StateBS16 == 1'b1) begin
									// lWord := Datai/(2**16);
									// fs 062299
									lWord <= Datai % (2 ** 16);
									end
									else begin
									rEIP <= rEIP + 2;
									RequestPending <= Pending;
									if(READY_n == 1'b0) begin
										RequestPending <= NotPending;
										lWord <= Datai % (2 ** 16);
									end
									end
								if(READY_n == 1'b0) begin
									EAX <= uWord * (2 ** 16) + lWord;
									More <= FALSE;
									Flush <= FALSE;
									InstAddrPointer <= InstAddrPointer + 2;
									InstQueueRd_Addr <= (InstQueueRd_Addr + 2) % queue_size; 
								end
								end
						end
							else begin
							Flush <= FALSE;
							More <= TRUE;
						end
					end
					MOV_ebx_eax : begin
						local_temporary_calc = InstQueueWr_Addr - InstQueueRd_Addr;
						if(local_temporary_calc >= 2) begin
							//if((InstQueueWr_Addr - InstQueueRd_Addr) >= 2) begin
							if(EBX < 0) begin
								rEIP <= EBX;
							end
							else begin
								rEIP <= EBX;
							end
							lWord <= EAX [15:0];
							//lWord = EAX % (2 ** 16);
							temp_data_extract = (EAX / (2 ** 16)); // Fix for STX_VE_481
							uWord <= temp_data_extract [14:0]; // Fix for STX_VE_481
							//uWord = (EAX / (2 ** 16)) % (2 ** 15);
							RequestPending <= Pending;
							ReadRequest <= NotPending;
							MemoryFetch <= Pending;
							CodeFetch <= NotPending;
							if(State == StateT1 || State == StateT1P) begin
								Datao <= uWord * (2 ** 16) + lWord;
								if(READY_n == 1'b0) begin
									RequestPending <= NotPending;
									if(StateBS16 == 1'b0) begin
										rEIP <= rEIP + 2;
										RequestPending <= Pending;
										ReadRequest <= NotPending;
										MemoryFetch <= Pending;
										CodeFetch <= NotPending;
										State2 <= S6;
									end
									More <= FALSE;
									Flush <= FALSE;
									InstAddrPointer <= InstAddrPointer + 2; 
									InstQueueRd_Addr <= (InstQueueRd_Addr + 2) % queue_size;
								end
								end
						end
							else begin
							Flush <= FALSE;
							More <= TRUE;
						end
					end
					IN_al : begin
						local_temporary_calc = InstQueueWr_Addr - InstQueueRd_Addr;
						if(local_temporary_calc >= 2) begin
							//if((InstQueueWr_Addr - InstQueueRd_Addr) >= 2) begin
							rEIP <= InstQueueRd_Addr + 1;
							RequestPending <= Pending;
							ReadRequest <= Pending;
							MemoryFetch <= NotPending;
							CodeFetch <= NotPending;
							if(READY_n == 1'b0) begin
								RequestPending <= NotPending;
								EAX <= Datai;
								InstAddrPointer <= InstAddrPointer + 2;
								InstQueueRd_Addr <= InstQueueRd_Addr + 2;
								Flush <= FALSE;
								More <= FALSE;
							end
						end
							else begin
							Flush <= FALSE;
							More <= TRUE;
						end
					end
					OUT_al : begin
						local_temporary_calc = InstQueueWr_Addr - InstQueueRd_Addr;
						if(local_temporary_calc >= 2) begin
							//if((InstQueueWr_Addr - InstQueueRd_Addr) >= 2) begin
							rEIP <= InstQueueRd_Addr + 1;
							RequestPending <= Pending;
							ReadRequest <= NotPending;
							MemoryFetch <= NotPending;
							CodeFetch <= NotPending;
							if(State == StateT1 || State == StateT1P) begin
								fWord <= EAX [15:0]; 
								Datao <= fWord;
								if(READY_n == 1'b0) begin
									RequestPending <= NotPending;
									InstAddrPointer <= InstAddrPointer + 2;
									InstQueueRd_Addr <= (InstQueueRd_Addr + 2) % queue_size; 
									Flush <= FALSE;
									More <= FALSE;
								end
								end
						end
							else begin
							Flush <= FALSE;
							More <= TRUE;
						end
						end
					ADD_al_b : begin
						InstAddrPointer <= InstAddrPointer + 1;
						InstQueueRd_Addr <= (InstQueueRd_Addr + 1) % queue_size; 
						Flush <= FALSE;
						More <= FALSE;
					end
					ADD_ax_w : begin
						InstAddrPointer <= InstAddrPointer + 1;
						InstQueueRd_Addr <= (InstQueueRd_Addr + 1) % queue_size; 
						Flush <= FALSE;
						More <= FALSE;
					end
					ROL_al_1 : begin
						InstAddrPointer <= InstAddrPointer + 2;
						InstQueueRd_Addr <= (InstQueueRd_Addr + 2) % queue_size; 
						Flush <= FALSE;
						More <= FALSE;
					end
					ROL_al_n : begin
						InstAddrPointer <= InstAddrPointer + 2;
						InstQueueRd_Addr <= (InstQueueRd_Addr + 2) % queue_size; 
						Flush <= FALSE;
						More <= FALSE;
					end
					INC_eax : begin
						EAX <= EAX + 1;
						InstAddrPointer <= InstAddrPointer + 1;
						InstQueueRd_Addr <= (InstQueueRd_Addr + 1) % queue_size; 
						Flush <= FALSE;
						More <= FALSE;
					end
					INC_ebx : begin
						EBX <= EBX + 1;
						InstAddrPointer <= InstAddrPointer + 1;
						InstQueueRd_Addr <= (InstQueueRd_Addr + 1) % queue_size; 
						Flush <= FALSE;
						More <= FALSE;
					end
					default : begin
						InstAddrPointer <= InstAddrPointer + 1;
						InstQueueRd_Addr <= (InstQueueRd_Addr + 1) % queue_size; 
						Flush <= FALSE;
						More <= FALSE;
					end
				endcase
				if(!(InstQueueRd_Addr < InstQueueWr_Addr) || (((InstQueueLimit - InstQueueRd_Addr) < 4) || Flush || More)) begin
					//if not (InstQueueRd_Addr < InstQueueWr_Addr) or (((InstQueueLimit - InstQueueRd_Addr) < 4) OR Flush OR More) then 
					State2 <= S7;
				end
			end
			S6 : begin
				Datao <= uWord * (2 ** 16) + lWord;
				if(READY_n == 1'b0) begin
					RequestPending <= NotPending;
					State2 <= S5;
				end
			end
			S7 : begin
				if(Flush) begin
					//if Flush then
					InstQueueRd_Addr <= 1;
					InstQueueWr_Addr <= 1;
					if((InstAddrPointer < 0)) begin
						fWord <= -InstAddrPointer;
						end
					else begin
						fWord <= InstAddrPointer;
						end
					if((fWord % 2) == 1) begin
						InstQueueRd_Addr <= (InstQueueRd_Addr + (fWord % 4)) % queue_size; 
						end
					end
					if((InstQueueLimit - InstQueueRd_Addr) < 3) begin
						State2 <= S8;
						InstQueueWr_Addr <= 0;
					end
					else begin
						State2 <= S9;
					end
			end
			S8 : begin
				if(InstQueueRd_Addr <= InstQueueLimit) begin// was <=, adjusted for proper array access
					InstQueue[InstQueueWr_Addr] <= InstQueue[InstQueueRd_Addr];
					InstQueueRd_Addr <= (InstQueueRd_Addr + 1) % queue_size;
					InstQueueWr_Addr <= (InstQueueWr_Addr + 1) % queue_size;
					State2 <= S8;
				end
				else begin
					InstQueueRd_Addr <= 0; 
					State2 <= S9;
				end
			end
			S9 : begin
				rEIP <= PhyAddrPointer;
				State2 <= S1;
			end
		endcase
		end
end

always @(posedge CLOCK, posedge RESET) begin
    if(RESET == 1'b1) begin
		ByteEnable <= 4'b0000;
		//NonAligned <= 1'b0; // Removed: Unused
		end else begin
		case(DataWidth)
			WidthByte : begin
				case (rEIP [1:0])
				//case(rEIP % 4)
					//CASE rEIP mod 4 is
					ZERO : begin
						ByteEnable <= 4'b1110;
						end
					ONE : begin
						ByteEnable <= 4'b1101;
						end
					TWO : begin
						ByteEnable <= 4'b1011;
						end
					THREE : begin
						ByteEnable <= 4'b0111;
						end
					default : begin
						ByteEnable <= 4'b0000; // Added default for completeness
					end
				endcase
			end
			WidthWord : begin
				case (rEIP [1:0])
				//case(rEIP % 4)
					//CASE rEIP mod 4 is
					ZERO : begin
						ByteEnable <= 4'b1100;
						//NonAligned <= NotPending; // Removed: Unused
						end
					ONE : begin
						ByteEnable <= 4'b1001;
						//NonAligned <= NotPending; // Removed: Unused
						end
					TWO : begin
						ByteEnable <= 4'b0011;
						//NonAligned <= NotPending; // Removed: Unused
						end
					THREE : begin
						ByteEnable <= 4'b0111;
						//NonAligned <= Pending; // Removed: Unused
						end
					default : begin
						ByteEnable <= 4'b0000; // Added default for completeness
						end
				endcase
			end
			WidthDword : begin
				case (rEIP [1:0])
				//case(rEIP % 4)
					//CASE rEIP mod 4 is
					ZERO : begin
						ByteEnable <= 4'b0000;
						//NonAligned <= NotPending; // Removed: Unused
						end
					ONE : begin
						ByteEnable <= 4'b0001;
						//NonAligned <= Pending; // Removed: Unused
						end
					TWO : begin
						//NonAligned <= Pending; // Removed: Unused
						ByteEnable <= 4'b0011;
						end
					THREE : begin
						//NonAligned <= Pending; // Removed: Unused
						ByteEnable <= 4'b0111;
						end
					default : begin
						ByteEnable <= 4'b0000; // Added default for completeness
						end
				endcase
			end
			default : begin
				ByteEnable <= 4'b0000; // Added default for completeness
			end
		endcase
		end
end


endmodule
