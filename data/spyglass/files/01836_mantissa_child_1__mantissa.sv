module mantissa(
  a0func,a1func,a2func,rsout,lsout,a0inc,a1inc,ae_small,eadd,
  morethree_taken,expsame,altb,a2,a1,a0,b1,b0,fpout,aexpout,
  fpu_state,asign,sin,sm,so,clk,fpain,fpbin,cyc0_rdy,cyc1_rdy,
  cyc0_type,amsb,manzero,mconfunc, reset_l, fpuhold,
  nx_rsfunc_rom0, nx_rsfunc_rom1, romsel, r1out, r0out
);

  input  [31:0]  rsout,lsout,a1inc,a0inc,fpain,fpbin;
  input  [10:0]  aexpout;
  input   [2:0]  a2func,a1func,a0func,cyc0_type;
  input   [7:0]  fpu_state;
  input   [1:0]  mconfunc;
  input          ae_small,eadd,morethree_taken,expsame,altb,asign;
  input          cyc0_rdy,cyc1_rdy;
  input          sin,sm,clk, reset_l, fpuhold;
  input    [2:0]   nx_rsfunc_rom0, nx_rsfunc_rom1;
  input  [1:0]     romsel;

  output           so;
  output [31:0]  a1,a0,b1,b0,fpout;
  output         a2,amsb,manzero;
  output   [31:0] r0out, r1out;

  wire    [2:0]  a0psel;
  wire    [2:0]  fp_out_sel;
  wire    [2:0]  a1sel,a0sel;  
  wire    [1:0]  a1psel,b0sel_a,b0sel_b,b1sel;
  wire    [1:0]  cyc0_sel;
  wire           b1msbin,b1psel;
  wire           a1comp,b1comp,a0comp,b0comp,a_small;
  wire           nxa2, a1zzsel, b1_cyc0sel;

  // SpyGlass violation 2D: Design Unit 'mantissa_cntl' has no definition; black-box behavior assumed
  // Adding a stub module definition to resolve this.
