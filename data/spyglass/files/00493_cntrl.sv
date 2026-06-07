module cntrl  (
	input clk,
	input reset,
	input  cmp,
	input incr,
	input start,
	output reg done,
	output reg ld,
	output reg clr,
	output reg shft,
	output reg add_sub
);


parameter START= 3'b000,LOAD=3'b001,CMP=3'b010,ADD_SUB=3'b011,SHIFT=3'b100, DONE=3'b101;

reg [2:0] state, next_state;



////////////////////////////////////////////////////////
always@(posedge clk)
begin
	if(reset)  state= START;
	else       state= next_state;
end
////////////next state allocation///////////////

always@(*)
begin
  case(state)
	START:
       	begin 
	if(start)   next_state= LOAD;  
	else        next_state= START; 
	end

	LOAD: 
	begin
	                   next_state= CMP;
        end

	CMP:
	begin
	       if(cmp)     next_state= ADD_SUB;
	       else        next_state= SHIFT;
        end

	ADD_SUB:
	begin
	         	   next_state= SHIFT;
	end

        SHIFT:
	begin
		if(incr)   next_state=CMP;
		else       next_state=DONE;
	end

	DONE:
       	begin
                           next_state= START;
        end	       
	
//	default:           next_state= START;

  endcase

end

///////////////////present state signal outputs/////////////////////////
always@(state)
begin
  case(state)
    START:
    begin
        clr =1; ld=0;done=0;add_sub=0;shft=0;

    end

    LOAD:
    begin
        ld=1; clr=0;done=0;add_sub=0;shft=0;

    end

    CMP:
    begin
	 ld=0;clr=0;done=0;add_sub=0;shft=0;
    end

    ADD_SUB:
    begin
	 ld=0; clr=0; done=0;add_sub=1;shft=0;

    end
    SHIFT:
    begin
	    ld=0;clr=0;done=0; shft=1;add_sub=0;
    end

    DONE:
    begin
	    done=1;ld=0;clr=0;add_sub=0;shft=0;

    end

    default:
    begin
	     clr =1; ld=0;done=0;add_sub=0;shft=0;

    end
  endcase

end


endmodule
