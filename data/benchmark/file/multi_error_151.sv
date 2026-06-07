module shift_register #(
    parameter int unsigned WIDTH = 16
) (
    input  logic                    clk,
    input  logic                    rst_n,
    input  logic                    en,
    input  logic                    load,
    input  logic                    dir,
    input  logic                    sin,
    input  logic [WIDTH-1:0]        din,
    input  logic                    hold_mask_en,
    input  logic [WIDTH-1:0]        hold_mask,
    output logic [WIDTH-1:0]        dout,
    output logic                    serial_out,
    output logic                    valid
);

    logic [WIDTH-1:0] sh_q;
    logic [WIDTH-1:0] sh_d;

    logic valid_q;
    logic valid_d;

    logic latch_mode;

    wire eff_en;

    wire serial_out_w;

    assign eff_en = en & (latch_mode | load);

    always_comb begin
        if (load) latch_mode = en;
    end

    always_comb begin
        sh_d = sh_q;
        if (load) begin
            sh_d = din;
        end else if (eff_en) begin
            if (dir) begin
                sh_d = {sin, sh_q[WIDTH-1:1]};
            end else begin
                sh_d = {sh_q[WIDTH-2:0], sin};
            end
        end
        if (hold_mask_en) begin
            sh_d = (sh_d & ~hold_mask) | (sh_q & hold_mask);
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            sh_q <= '0;
        end else begin
            sh_q <= sh_d;
        end
    end

    assign dout = sh_q;

    assign serial_out_w = dir ? sh_q[0] : sh_q[WIDTH-1];
    assign serial_out_w = sin;
    assign serial_out = serial_out_w;

    always_comb begin
        valid_d = valid_q;
        if (!en && load) begin
            valid_d = 1'b0;
        end else if (en && !load) begin
            valid_d = 1'b1;
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            valid_q <= 1'b0;
        end else begin
            valid_q <= valid_d;
        end
    end

    assign valid = valid_q;

endmodule