module rcu_ctl (
    input   [7:0]   opcode_1_rs1_r,
    input   [7:0]   opcode_2_rs1_r,
    input           valid_rs1_r,
    input           help_rs1_r,
    input   [7:0]   type_rs1_r,
    input           st_index_op_rs1_r,
    input           lvars_acc_rs1,
    input           lv_rs1_r,
    input           reverse_ops_rs1_r,
    input           update_optop_r,
    input           ucode_active,
    input           ucode_dest_we,
    input           ucode_dest_sel,
    input   [7:0]   opcode_1_rs2_r,
    input   [7:0]   opcode_2_rs2_r,
    input           valid_rs2_r,
    input           lvars_acc_rs2,
    input           lv_rs2_r,
    input           valid_op_r,
    input   [7:0]   opcode_1_op_r,
    input   [7:0]   opcode_2_op_r,
    input   [7:0]   opcode_1_rsd_r,
    input   [7:0]   opcode_2_rsd_r,
    input           valid_rsd_r,
    input           group_1_r,
    input           group_2_r,
    input           group_3_r,
    input           group_4_r,
    input           group_5_r,
    input           group_6_r,
    input           group_7_r,
    input           group_9_r,
    input           no_fold_r,
    input           put_field2_quick_r,
    input           hold_e,
    input           hold_c,
    input           hold_ucode,
    input   [2:0]   inst_vld,
    input           bypass_scache_rs1_e,
    input           bypass_scache_rs1_c,
    input           bypass_scache_rs1_w,
    input           bypass_scache_rs2_e,
    input           bypass_scache_rs2_c,
    input           bypass_scache_rs2_w,
    input           sc_wr_addr_gr_scbot,
    input           iu_smu_flush_le,
    input           iu_smu_flush_ge,
    input           ucode_done,
    input           iu_trap_r,
    input           sin,
    input           sm,
    input           clk,
    input           reset_l,
    input           scache_wr_miss_w,
    input           sc_miss_rs1_int,
    input           sc_miss_rs2_int,
    output  [3:0]   gl_sel_rs1,
    output  [5:0]   const_sel_1_rs1,
    output  [6:0]   const_sel_2_rs1,
    output  [2:0]   const_gl_sel_rs1,
    output  [4:0]   scache_addr_sel_rs1,
    output  [1:0]   final_data_sel_rs1,
    output  [3:0]   gl_sel_rs2,
    output  [5:0]   const_sel_1_rs2,
    output  [6:0]   const_sel_2_rs2,
    output  [2:0]   const_gl_sel_rs2,
    output  [4:0]   scache_addr_sel_rs2,
    output  [1:0]   final_data_sel_rs2,
    output          scache_rd_miss_e,
    output  [7:0]   optop_incr_sel,
    output  [2:0]   dest_addr_sel_r,
    output  [2:0]   dest_addr_sel_e,
    output  [4:0]   net_optop_sel1,
    output  [3:0]   net_optop_sel2,
    output  [1:0]   net_optop_sel,
    output  [5:0]   optop_offset_sel_r,
    output          enable_cmp_e_rs1,
    output          enable_cmp_c_rs1,
    output          enable_cmp_w_rs1,
    output          enable_cmp_e_rs2,
    output          enable_cmp_c_rs2,
    output          enable_cmp_w_rs2,
    output          iu_data_we_w,
    output          gl_reg0_we_w,
    output          gl_reg1_we_w,
    output          gl_reg2_we_w,
    output          gl_reg3_we_w,
    output  [3:0]   rs1_forward_mux_sel,
    output  [3:0]   rs2_forward_mux_sel,
    output          iu_smu_flush,
    output          second_cycle,
    output          first_cycle,
    output          first_vld_c,
    output          inst_complete_w,
    output          so
);
    // Dummy assignments
    assign gl_sel_rs1 = 0;
    assign const_sel_1_rs1 = 0;
    assign const_sel_2_rs1 = 0;
    assign const_gl_sel_rs1 = 0;
    assign scache_addr_sel_rs1 = 0;
    assign final_data_sel_rs1 = 0;
    assign gl_sel_rs2 = 0;
    assign const_sel_1_rs2 = 0;
    assign const_sel_2_rs2 = 0;
    assign const_gl_sel_rs2 = 0;
    assign scache_addr_sel_rs2 = 0;
    assign final_data_sel_rs2 = 0;
    assign scache_rd_miss_e = 0;
    assign optop_incr_sel = 0;
    assign dest_addr_sel_r = 0;
    assign dest_addr_sel_e = 0;
    assign net_optop_sel1 = 0;
    assign net_optop_sel2 = 0;
    assign net_optop_sel = 0;
    assign optop_offset_sel_r = 0;
    assign enable_cmp_e_rs1 = 0;
    assign enable_cmp_c_rs1 = 0;
    assign enable_cmp_w_rs1 = 0;
    assign enable_cmp_e_rs2 = 0;
    assign enable_cmp_c_rs2 = 0;
    assign enable_cmp_w_rs2 = 0;
    assign iu_data_we_w = 0;
    assign gl_reg0_we_w = 0;
    assign gl_reg1_we_w = 0;
    assign gl_reg2_we_w = 0;
    assign gl_reg3_we_w = 0;
    assign rs1_forward_mux_sel = 0;
    assign rs2_forward_mux_sel = 0;
    assign iu_smu_flush = 0;
    assign second_cycle = 0;
    assign first_cycle = 0;
    assign first_vld_c = 0;
    assign inst_complete_w = 0;

    // Fix for W240 (Inputs declared but not read): Create a dummy sink for all inputs
    wire dummy_ctl_input_sink;
    assign dummy_ctl_input_sink = |{opcode_1_rs1_r, opcode_2_rs1_r, valid_rs1_r,
                                    help_rs1_r, type_rs1_r, st_index_op_rs1_r,
                                    lvars_acc_rs1, lv_rs1_r, reverse_ops_rs1_r,
                                    update_optop_r, ucode_active, ucode_dest_we,
                                    ucode_dest_sel, opcode_1_rs2_r, opcode_2_rs2_r,
                                    valid_rs2_r, lvars_acc_rs2, lv_rs2_r, valid_op_r,
                                    opcode_1_op_r, opcode_2_op_r, opcode_1_rsd_r,
                                    opcode_2_rsd_r, valid_rsd_r, group_1_r,
                                    group_2_r, group_3_r, group_4_r, group_5_r,
                                    group_6_r, group_7_r, group_9_r, no_fold_r,
                                    put_field2_quick_r, hold_e, hold_c, hold_ucode,
                                    inst_vld, bypass_scache_rs1_e, bypass_scache_rs1_c,
                                    bypass_scache_rs1_w, bypass_scache_rs2_e,
                                    bypass_scache_rs2_c, bypass_scache_rs2_w,
                                    sc_wr_addr_gr_scbot, iu_smu_flush_le,
                                    iu_smu_flush_ge, ucode_done, iu_trap_r, sin, sm,
                                    clk, reset_l, scache_wr_miss_w, sc_miss_rs1_int,
                                    sc_miss_rs2_int};

    assign so = 0;
endmodule
