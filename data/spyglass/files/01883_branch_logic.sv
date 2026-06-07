module branch_logic 
		(	
		 branch_qual,
		 cmp_eq_e,
		 cmp_gt_e,
	         cmp_lt_e,
		 reissue_c,
		 sc_dcache_req,
		 kill_inst_e,
		 iu_inst_raw_e,
		 inst_valid,
		 ucode_dcu_req,
		 ucode_busy_e,
		 iu_brtaken_e,
		 branch_taken_e,
		 iu_inst_e

);


input	[4:0]	branch_qual;
input		cmp_eq_e;
input		cmp_gt_e;
input		cmp_lt_e;
input		reissue_c;
input		sc_dcache_req;
input		kill_inst_e;
input	[3:2]	iu_inst_raw_e;
input		inst_valid;
input	[1:0]	ucode_dcu_req;
input		ucode_busy_e;

output		iu_brtaken_e;
output		branch_taken_e;
output	[3:2]	iu_inst_e;

wire	[3:2]	iu_inst_raw;
wire	[3:2]	ucode_inst_e;


assign	iu_brtaken_e 	=	branch_qual[4]& cmp_eq_e |
				branch_qual[3]&!cmp_eq_e |
				branch_qual[2]& cmp_gt_e |
				branch_qual[1]& cmp_lt_e |
				branch_qual[0] |reissue_c;

assign	branch_taken_e	 =      iu_brtaken_e;

assign iu_inst_e[3]	=  (ucode_dcu_req[1] & ~ucode_dcu_req[0]|iu_inst_raw_e[3])& ~sc_dcache_req & inst_valid;
assign iu_inst_e[2]	=  (ucode_dcu_req[0]| iu_inst_raw_e[2] | sc_dcache_req )
	  	           &inst_valid;

endmodule
