`timescale 1ns/1ps
`default_nettype none

module cpu1_core (
    input  wire        clk,
    input  wire        rst_n,
    input  wire        irq,
    output wire        io_valid,
    output wire        io_write,
    output wire [15:0] io_addr,
    output wire [31:0] io_wdata,
    output wire [3:0]  io_wstrb,
    input  wire [31:0] io_rdata,
    input  wire        io_ready,
    output wire [15:0] trace_pc,
    output wire [31:0] trace_instr,
    output wire [31:0] trace_result,
    output wire        trap,
    output wire [31:0] cycle_count,
    output wire [31:0] instr_count,
    output wire [31:0] debug_state
);
    wire [15:0] pc_q;
    wire [15:0] pc_plus2;
    wire [31:0] instr;
    wire        fetch_valid;

    wire [3:0]  opcode;
    wire [2:0]  rd;
    wire [2:0]  rs1;
    wire [2:0]  rs2;
    wire [31:0] imm_ext;
    wire [2:0]  func;

    wire [3:0]  alu_op;
    wire        src_imm;
    wire        reg_write_ctl;
    wire        mem_read;
    wire        mem_write;
    wire        branch;
    wire        jump;
    wire        csr_write;
    wire [1:0]  wb_sel;
    wire        illegal_instr;

    wire [31:0] rs1_value;
    wire [31:0] rs2_value;
    wire [31:0] alu_b;
    wire [31:0] alu_result;
    wire        alu_zero;
    wire        alu_negative;
    wire        alu_carry;
    wire        alu_overflow;

    wire        branch_take;
    wire [15:0] branch_target;
    wire [31:0] load_data;
    wire        lsu_stall;
    wire        lsu_fault;
    wire [31:0] csr_data;
    wire        irq_pending;
    wire [15:0] trap_vector;
    wire [31:0] csr_status_word;
    wire [31:0] wb_data;
    wire        trap_request;
    wire        redirect_valid;
    wire [15:0] redirect_pc;
    wire        retire;
    wire        rf_write_en;
    wire [31:0] load_count;
    wire [31:0] store_count;
    wire [31:0] branch_count;

    assign trace_pc = pc_q;
    assign trace_instr = instr;
    assign trace_result = wb_data;
    assign trap = trap_request;
    assign alu_b = src_imm ? imm_ext : rs2_value;
    assign trap_request = illegal_instr | lsu_fault;
    assign redirect_valid = (branch_take | trap_request) & !lsu_stall;
    assign redirect_pc = trap_request ? trap_vector : branch_target;
    assign retire = fetch_valid & !lsu_stall;
    assign rf_write_en = reg_write_ctl & retire & !trap_request;
    assign debug_state = csr_status_word ^ load_count ^ store_count ^ branch_count;

    cpu1_pc u_pc (
        .clk(clk),
        .rst_n(rst_n),
        .stall(lsu_stall),
        .redirect_valid(redirect_valid),
        .redirect_pc(redirect_pc),
        .pc_q(pc_q),
        .pc_plus2(pc_plus2)
    );

    cpu1_fetch u_fetch (
        .pc(pc_q),
        .instr(instr),
        .valid(fetch_valid)
    );

    cpu1_decode u_decode (
        .instr(instr),
        .opcode(opcode),
        .rd(rd),
        .rs1(rs1),
        .rs2(rs2),
        .imm_ext(imm_ext),
        .func(func)
    );

    cpu1_control u_control (
        .decode_valid(fetch_valid),
        .opcode(opcode),
        .func(func),
        .irq_pending(irq_pending),
        .alu_op(alu_op),
        .src_imm(src_imm),
        .reg_write(reg_write_ctl),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .branch(branch),
        .jump(jump),
        .csr_write(csr_write),
        .wb_sel(wb_sel),
        .illegal_instr(illegal_instr)
    );

    cpu1_regfile u_regfile (
        .clk(clk),
        .rst_n(rst_n),
        .write_en(rf_write_en),
        .raddr1(rs1),
        .raddr2(rs2),
        .waddr(rd),
        .wdata(wb_data),
        .rdata1(rs1_value),
        .rdata2(rs2_value)
    );

    cpu1_alu u_alu (
        .op(alu_op),
        .a(rs1_value),
        .b(alu_b),
        .y(alu_result),
        .zero(alu_zero),
        .negative(alu_negative),
        .carry(alu_carry),
        .overflow(alu_overflow)
    );

    cpu1_branch u_branch (
        .branch(branch),
        .jump(jump),
        .func(func),
        .pc(pc_q),
        .imm(imm_ext),
        .rs1_value(rs1_value),
        .rs2_value(rs2_value),
        .zero(alu_zero),
        .negative(alu_negative),
        .carry(alu_carry),
        .overflow(alu_overflow),
        .take(branch_take),
        .target(branch_target)
    );

    cpu1_lsu u_lsu (
        .mem_read(mem_read),
        .mem_write(mem_write),
        .addr_base(rs1_value),
        .store_data(rs2_value),
        .imm(imm_ext),
        .io_rdata(io_rdata),
        .io_ready(io_ready),
        .io_addr(io_addr),
        .io_wdata(io_wdata),
        .io_wstrb(io_wstrb),
        .io_valid(io_valid),
        .io_write(io_write),
        .load_data(load_data),
        .stall(lsu_stall),
        .fault(lsu_fault)
    );

    cpu1_csr u_csr (
        .clk(clk),
        .rst_n(rst_n),
        .irq(irq),
        .trap_req(trap_request),
        .retire(retire),
        .pc(pc_q),
        .instr(instr),
        .write_en(csr_write & retire),
        .csr_addr(imm_ext[2:0]),
        .write_data(rs1_value),
        .irq_pending(irq_pending),
        .read_data(csr_data),
        .trap_vector(trap_vector),
        .status_word(csr_status_word)
    );

    cpu1_writeback u_writeback (
        .wb_sel(wb_sel),
        .alu_result(alu_result),
        .load_data(load_data),
        .csr_data(csr_data),
        .pc_next(pc_plus2),
        .wb_data(wb_data)
    );

    cpu1_perf u_perf (
        .clk(clk),
        .rst_n(rst_n),
        .stall(lsu_stall),
        .retire(retire),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .branch_taken(branch_take),
        .cycle_count(cycle_count),
        .instr_count(instr_count),
        .load_count(load_count),
        .store_count(store_count),
        .branch_count(branch_count)
    );
endmodule

`default_nettype wire
