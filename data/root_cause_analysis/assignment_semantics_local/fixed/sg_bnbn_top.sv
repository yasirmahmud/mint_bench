module sg_bnbn_top #(
    parameter int DATA_W = 8
) (
    input  logic              clk,
    input  logic              rst_n,
    input  logic              enable,
    input  logic [DATA_W-1:0]  data_in,
    output logic [DATA_W-1:0]  data_out,
    output logic [DATA_W-1:0]  status,
    output logic              signature
);
    logic [      1:0] op_sel;
    logic             use_alt;
    logic [      3:0] shift_amt;
    logic [DATA_W-1:0] ctrl_sum;
    logic [DATA_W-1:0] dp_out;
    logic [DATA_W-1:0] dp_status;
    logic [DATA_W-1:0] pipe_out;
    logic [DATA_W-1:0] pipe_tap2;

    sg_bnbn_control #(
        .DATA_W(DATA_W)
    ) u_control (
        .clk      (clk),
        .rst_n    (rst_n),
        .enable   (enable),
        .data_in  (data_in),
        .op_sel   (op_sel),
        .use_alt  (use_alt),
        .shift_amt(shift_amt),
        .ctrl_sum (ctrl_sum)
    );

    sg_bnbn_datapath #(
        .DATA_W(DATA_W)
    ) u_datapath (
        .clk      (clk),
        .rst_n    (rst_n),
        .data_in  (data_in),
        .op_sel   (op_sel),
        .use_alt  (use_alt),
        .shift_amt(shift_amt),
        .ctrl_sum (ctrl_sum),
        .data_out (dp_out),
        .status   (dp_status)
    );

    sg_bnbn_pipe #(
        .DATA_W(DATA_W)
    ) u_pipe (
        .clk     (clk),
        .rst_n   (rst_n),
        .in_data (dp_out),
        .out_data(pipe_out),
        .tap2    (pipe_tap2)
    );

    assign data_out = pipe_out;
    assign status = dp_status;
    assign signature = ^{data_out, status, pipe_tap2};
endmodule
