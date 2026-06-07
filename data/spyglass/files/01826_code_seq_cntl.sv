module code_seq_cntl (	reset_l, 
			valid_opcode, 
			fpuhold, 
			fpu_state, 
			opcode_look,
			nx_opcode_look,
                       	fpbusyn, 
			cyc1_rdy, 
			fpkill, 
			clk, 
			romsel, 
			morethree_taken,
                       	rsovfi, 
			rsneg, 
			amsb, 
			incovf, 
			rs2zero, 
			rs32, 
			rsge64, 
			eadd, 
			le, 
                       	manzero, 
			morethree, 
			absign, 
			fmulovf, 
			cyc0_rdy_p, 
			branch, 
			qin,
                       	qmsb, 
			a2func, 
			opcode, 
			cyc0_type, 
			top_fpbin, 
			bsignin, 
			dprec,
			nx_dprec,
			nxcode,
			so,
			sin,
			sm 
			);


  input   [7:0] opcode;
  input   [7:0] nxcode;
  input   [3:0] branch; 
  input   [2:0] a2func;
  input         reset_l, 
		valid_opcode, 
		fpuhold, 
		fpkill, 
		clk, 
		rsovfi, 
		rsneg, 
		amsb,
                incovf, 
		rs2zero, 
		rs32, 
		rsge64, 
		eadd, 
		le, 
		manzero, 
		morethree, 
		absign,
                fmulovf, 
		cyc0_rdy_p, 
		qin, 
		qmsb, 
		top_fpbin;

  input         sm, sin;
  output	so;

  output  [2:0] cyc0_type; 
  output  [1:0] romsel;
  output  [7:0] fpu_state;
  output        opcode_look, nx_opcode_look,
		fpbusyn, 
		cyc1_rdy, 
		morethree_taken, 
		bsignin, 
		dprec, nx_dprec;

//  wire    [7:0] next_fpu_state;
  wire          dp_out, mfinish, two_cycle_in, int_out, 
		long_out, addsub, rem_op, dp_outp, addsubp, 
		dprecp, int_outp, long_outp, rem_opp, conreg_enable,
		cyc0_rdy_p;	

  assign mfinish = ((branch==4'hb) && (nxcode==8'h0));

  fpu_dec fpud(		.dp_out(dp_out),
			.mfinish(mfinish),
			.reset_l(reset_l),
			.clk(clk),
			.valid_opcode(valid_opcode),
             		.two_cycle_in(two_cycle_in),
			.fpuhold(fpuhold),
			.fpkill(fpkill),
			.fpu_state(fpu_state),
			.opcode_look(opcode_look),
			.nx_opcode_look(nx_opcode_look),
             		.int_out(int_out),
			.long_out(long_out),
			.fpbusyn(fpbusyn),
			.cyc1_rdy(cyc1_rdy), 
			.sm(),.sin(),.so());


  branch_dec branchd(	.romsel(romsel),
			.morethree_taken(morethree_taken),
			.rsovfi(rsovfi),
             		.rsneg(rsneg),
			.amsb(amsb),
			.incovf(incovf),
			.rs2zero(rs2zero),
			.rs32(rs32),
             		.rsge64(rsge64),
			.eadd(eadd),
			.le(le),
			.manzero(manzero),
			.morethree(morethree),
             		.absign(absign),
			.fmulovf(fmulovf),
			.fpkill(fpkill),
			.cyc0_rdy_p(cyc0_rdy_p),
			.addsub(addsub),
			.branch(branch),
			.qin(qin),
			.qmsb(qmsb),
			.rem_op(rem_op),
			.a2func(a2func));


  opcode_dec d8(	.opcode(opcode),
			.dp_outp(dp_outp),
			.addsubp(addsubp),
			.two_cycle_in(two_cycle_in),
               		.dprecp(dprecp),
			.int_outp(int_outp),
			.long_outp(long_outp),
			.cyc0_type(cyc0_type),
                	.top_fpbin(top_fpbin),
			.bsignin(bsignin),
			.rem_opp(rem_opp));

//assign conreg_enable = (valid_opcode && opcode_look && !fpuhold);
wire [5:0] conreg_din;
assign conreg_enable = (valid_opcode && opcode_look);
mj_s_mux2_d_6 fpumux( .mx_out(conreg_din),
                        .sel(conreg_enable),
                        .in0({rem_op,long_out,int_out,dp_out,addsub,dprec}),
                        .in1({rem_opp,long_outp,int_outp,dp_outp,addsubp,dprecp}));

assign nx_dprec = (conreg_enable) ? dprecp:dprec;

mj_s_ff_snre_d_6 conreg (.out({rem_op,long_out,int_out,dp_out,addsub,dprec}),
			.din(conreg_din),
			.lenable(!fpuhold),
			.reset_l(reset_l),
			.clk(clk));
endmodule
