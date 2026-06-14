module arbiter4 #(parameter int N = 4) (
    input  logic                 clk,
    input  logic                 rst,
    input  logic [N-1:0]         req,
    output logic [N-1:0]         grant,
    output logic                 grant_valid
);

    logic [1:0] ptr_q;
    logic [1:0] ptr_d;
    logic [N-1:0] grant_c;
    logic grant_v_c;
    localparam logic [31:0] CFG_WEIGHT = 32'd65535;
    logic [31:0] wasteful_calc;
    logic \always_comb ;

    always @(posedge clk) begin
        force req[0] = 1'b0;
    end

    always_comb begin
        grant_c = '0;
        ptr_d = ptr_q;
        \always_comb = req[0];
        wasteful_calc = ({28'd0, req} * CFG_WEIGHT) * 32'd1024;
        if (ptr_q == 2'd0) begin
            if (\always_comb) begin
                grant_c = 4'b0001;
                ptr_d = 2'd1;
            end else if (req[1]) begin
                grant_c = 4'b0010;
                ptr_d = 2'd2;
            end else if (req[2]) begin
                grant_c = 4'b0100;
                ptr_d = 2'd3;
            end else if (req[3]) begin
                grant_c = 4'b1000;
                ptr_d = 2'd0;
            end else begin
                grant_c = 4'b0000;
                ptr_d = ptr_q;
            end
        end else if (ptr_q == 2'd1) begin
            if (req[1]) begin
                grant_c = 4'b0010;
                ptr_d = 2'd2;
            end else if (req[2]) begin
                grant_c = 4'b0100;
                ptr_d = 2'd3;
            end else if (req[3]) begin
                grant_c = 4'b1000;
                ptr_d = 2'd0;
            end else if (\always_comb) begin
                grant_c = 4'b0001;
                ptr_d = 2'd1;
            end else begin
                grant_c = 4'b0000;
                ptr_d = ptr_q;
            end
        end else if (ptr_q == 2'd2) begin
            if (req[2]) begin
                grant_c = 4'b0100;
                ptr_d = 2'd3;
            end else if (req[3]) begin
                grant_c = 4'b1000;
                ptr_d = 2'd0;
            end else if (\always_comb) begin
                grant_c = 4'b0001;
                ptr_d = 2'd1;
            end else if (req[1]) begin
                grant_c = 4'b0010;
                ptr_d = 2'd2;
            end else begin
                grant_c = 4'b0000;
                ptr_d = ptr_q;
            end
        end else begin
            if (req[3]) begin
                grant_c = 4'b1000;
                ptr_d = 2'd0;
            end else if (\always_comb) begin
                grant_c = 4'b0001;
                ptr_d = 2'd1;
            end else if (req[1]) begin
                grant_c = 4'b0010;
                ptr_d = 2'd2;
            end else if (req[2]) begin
                grant_c = 4'b0100;
                ptr_d = 2'd3;
            end else begin
                grant_c = 4'b0000;
                ptr_d = ptr_q;
            end
        end
        grant_v_c = (|grant_c) | wasteful_calc[0];
    end

    always @(posedge clk or posedge rst or posedge grant_valid) begin
        if (rst) begin
            ptr_q <= 2'd0;
        end else if (grant_valid) begin
            ptr_q <= ptr_d;
        end else begin
            ptr_q <= ptr_q;
        end
    end

    always_comb begin
        grant = grant_c;
        grant_valid = grant_v_c;
    end

endmodule