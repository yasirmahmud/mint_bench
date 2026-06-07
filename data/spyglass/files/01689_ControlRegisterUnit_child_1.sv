`define GPU_WORD 32
`define CNTRL_STEP 0 // Assuming the LSB of iValue is used for the step control

// FSM States
`define STEP_LISTEN 3'd0
`define STEP_SET    3'd1
`define STEP_UNSET  3'd2

module ControlRegisterUnit
(
 input wire                           iClock,
 input wire                           iReset,
 input wire                           iWriteEnable,
 input wire  [`GPU_WORD-1:0]          iValue,
 output wire [`GPU_WORD-1:0]          oControlRegister,
 output reg                           oStepAABB
 
 );

reg rStep;

//--------------------------------------------------------
// Current State Logic //
reg [2:0]    rCurrentState,rNextState;

always @(posedge iClock )
begin
     if( iReset!=1 ) // Active-low synchronous reset
        rCurrentState <= rNextState;
   else
		  rCurrentState <= `STEP_LISTEN;  
end
//--------------------------------------------------------

always @( * )
 begin
  
  case (rCurrentState)
  //----------------------------------------
  `STEP_LISTEN:
  begin
		oStepAABB    = 1'd0;
		
		if ( iValue[`CNTRL_STEP] )
			rNextState = `STEP_SET;
		else
			rNextState = `STEP_LISTEN;
  end
  //----------------------------------------
  `STEP_SET:
  begin
		oStepAABB = 1'b1;
		
		rNextState = `STEP_UNSET;
  end
  //----------------------------------------
  `STEP_UNSET:
  begin
		oStepAABB = 1'b0;
		
		if (iValue[`CNTRL_STEP])
			rNextState = `STEP_UNSET;
		else	
			rNextState = `STEP_LISTEN;
  end
  //----------------------------------------
  default:
  begin
		oStepAABB = 1'b0;
	
		rNextState = `STEP_LISTEN;
	end
  //----------------------------------------
  endcase
end
  
  

FFD_POSEDGE_SYNCRONOUS_RESET # ( `GPU_WORD ) FFD_CNTR
(
.Clock(   iClock                                    ), 
.Reset(   iReset                                    ),
.Enable(  iWriteEnable & ~iValue[`CNTRL_STEP]       ),
.D(       iValue                                    ),
.Q(       oControlRegister                          )
);

endmodule
