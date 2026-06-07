module pcsu(
   	// OUTPUTS
	pj_clk_out,
	pj_standby_out,
	pcsu_powerdown,
        so,   
	reset_l,
       	pj_irl_sync,
	pj_nmi_sync,

	// INPUTS
	clk,
       	pj_irl,
	pj_nmi,
	dcu_in_powerdown,
	icu_in_powerdown,
	iu_powerdown_e,
        sin, 
        sm
);

output	pj_clk_out	;// free running pj_clk out to external system
output	pj_standby_out 	;// indicates PCSU is in standby mode
output	pcsu_powerdown 	;// standby mode request to the units
output	so	  	;// scan output to external system 
output	[3:0] pj_irl_sync ;// synchronized interrupt request line
output	pj_nmi_sync	;// synchronized non-maskable interrupt

input	clk		;// 
input	[3:0] pj_irl	;// interrupt request line
input	pj_nmi		;// non-maskable interrupt
input	dcu_in_powerdown;// dcu is ready for standby mode
input	icu_in_powerdown;// icu is ready for standby mode
input	iu_powerdown_e	;// ieu executes priv_shutdown instruction 
input	sin		;// scan input from external system 
input	sm		;// scan mode input from external system 
input	reset_l	;


wire	pj_clk_out	;
wire	pj_standby_out 	;
wire	pcsu_powerdown 	;
wire	so 	 	;

wire [2:0] cur_pcsu_state;
wire [2:0] next_pcsu_state;
wire [4:0] sync_int;
wire [4:0] sync_1st;
wire [3:0] pj_irl_sync;
wire       pj_nmi_sync;
wire       pcsu_wakeup;

// Consume unused inputs for linting
wire _sm_unused = sm;
assign so = sin; // Use sin and drive so

// Powerdown signals

 assign	pcsu_powerdown = iu_powerdown_e & !pcsu_wakeup;	
 
/* ****************************************************** 
 * Generation of pj_standby_out:
 *  
 * The pj_standby_out is equal to
 * cur_pcsu_state[2] delayed by one clock.  
 * It is delayed by one clock because it needs to be in
 * sync with the shutoff of pj_internal_clk.
 *
 * **************************************************** */

assign pj_standby_out = cur_pcsu_state[2] ;


// Clock outputs

assign  pj_clk_out     = clk;

/* ****************************************************** 
 * Generation of pj_internal_clk:
 *  
 * The picoJava-II core runs off a single clock source, 
 * pj_clk. The pj_clk, negated by halt_clock becomes 
 * the pj_internal_clk to all function units.
 *
 ******************************************************* */

assign  pj_irl_sync[3:0] = sync_int[4:1]; 
assign  pj_nmi_sync = sync_int[0]; 

// synchronizer

ff_s_5    sync1_reg_4_0(.out(sync_int[4:0]),
                   .din(sync_1st[4:0]),
                   .clk(clk));

ff_s_5    sync0_reg_4_0(.out(sync_1st[4:0]),
                   .din({pj_irl[3:0],pj_nmi}),
                   .clk(clk));


assign    pcsu_wakeup = |sync_int ;


/* **************************************************
 * Standby state machine:
 * 
 * The core can be put in standby mode by executing 
 * powerdown instruction. 
 *
 * When the powerdown instruction is executed the PCSU 
 * asserts pcsu_powerdown to all function units and 
 * waits until all function units are ready. It then 
 * enters the standby state and stops the clock, 
 * pj_internal_clk to all units. PCSU indicates this 
 * state to the system with the pj_standby_out pin. 
 *
 * The pj_nmi or pj_irl can make the core exit the 
 * standby mode caused by the powerdown instruction.
 *
 * The Reset can make the core exit the standby mode 
 * without any quetion.
 *
 * ************************************************* */ 

wire    ready_to_powerdown = dcu_in_powerdown & 
                             icu_in_powerdown;

assign  next_pcsu_state[2:0] =  pcsu_state(
			 	cur_pcsu_state[2:0],
 			 	ready_to_powerdown,           	
				iu_powerdown_e,
				pcsu_wakeup	
				           );

// triquest state_vector {cur_pcsu_state[2:1] cur_pcsu_state[0]} PCSU_STATE enum PCSU_STATE_ENUM
ff_sr_2	pcsu_reg_2_1(.out(cur_pcsu_state[2:1]),
                   .din(next_pcsu_state[2:1]),
                   .reset_l(reset_l),
                   .clk(clk));

ff_s    pcsu_reg_0(.out(cur_pcsu_state[0]),
                   .din(~reset_l | next_pcsu_state[0]),
                   .clk(clk));


function [2:0] 	pcsu_state ;
 
input    [2:0]  cur_state;
input           ready_to_powerdown;        
input           iu_powerdown_e;
input           pcsu_wakeup;     

reg      [2:0]  next_state;

parameter // triquest enum PCSU_STATE_ENUM

        NORMAL_MODE     = 3'b001,
        WAIT_STATE      = 3'b010,
        STANDBY_MODE    = 3'b100;

begin

  case (cur_state)

        NORMAL_MODE:	begin
			if (iu_powerdown_e&~pcsu_wakeup) 
                                 next_state = WAIT_STATE;
			else next_state = cur_state; 
        end	

        WAIT_STATE:	begin
			if (pcsu_wakeup) next_state = NORMAL_MODE;
			else if(ready_to_powerdown) next_state = STANDBY_MODE; 
			else next_state = cur_state;	
        end

        STANDBY_MODE:	begin
 			if (pcsu_wakeup)  next_state = NORMAL_MODE;
			else next_state = cur_state;	
	end

        default:        next_state = 3'bx;
 endcase

 pcsu_state = next_state;
end

endfunction

/* ******************************************************
 * Generation of halt_clock:
 *  
 * A positive-edge triggered flip-flop fed with an 
 * inverted clock is used to latch early_pj_standby_out
 * and thus keeps the pj_internal_clk from the glitch.
 *
 * **************************************************** */




endmodule
