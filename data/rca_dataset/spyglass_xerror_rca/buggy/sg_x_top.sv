module sg_x_top #(
    parameter int DATA_W = 8,
    parameter int DEPTH  = 8
) (
    input  logic              clk,
    input  logic              rst_n,
    input  logic              enable,
    output logic [DATA_W-1:0]  result,
    output logic              ctrl_flag
);
    localparam int ADDR_W = (DEPTH <= 1) ? 1 : $clog2(DEPTH);

    logic [ADDR_W-1:0] addr;
    logic [DATA_W-1:0] mem_rdata;
    logic [      1:0]  op_sel;
    logic              use_alt;
    logic [      3:0]  shift_amt;
    logic [DATA_W-1:0] datapath_out;
    logic              ctrl_flag_raw;
    logic              addr_ok;

    sg_x_counter #(
        .DEPTH(DEPTH)
    ) u_counter (
        .clk   (clk),
        .rst_n (rst_n),
        .enable(enable),
        .addr  (addr)
    );

    sg_x_control #(
        .DEPTH(DEPTH)
    ) u_control (
        .addr     (addr),
        .op_sel   (op_sel),
        .use_alt  (use_alt),
        .shift_amt(shift_amt),
        .ctrl_flag(ctrl_flag_raw)
    );

    sg_x_mem #(
        .DATA_W(DATA_W),
        .DEPTH (DEPTH)
    ) u_mem (
        .clk  (clk),
        .rst_n(rst_n),
        .addr (addr),
        .rdata(mem_rdata)
    );

    sg_x_datapath #(
        .DATA_W(DATA_W),
        .DEPTH (DEPTH)
    ) u_datapath (
        .clk     (clk),
        .rst_n   (rst_n),
        .mem_rdata(mem_rdata),
        .addr     (addr),
        .op_sel   (op_sel),
        .use_alt  (use_alt),
        .shift_amt(shift_amt),
        .out      (datapath_out)
    );

    sg_x_checker #(
        .DEPTH(DEPTH)
    ) u_checker (
        .clk   (clk),
        .rst_n (rst_n),
        .addr  (addr),
        .enable(enable),
        .addr_ok(addr_ok)
    );

    assign result = datapath_out;
    assign ctrl_flag = ctrl_flag_raw & addr_ok;
endmodule
