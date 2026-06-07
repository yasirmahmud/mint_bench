module nibble_adder4(
    input  logic [3:0] a,
    input  logic [3:0] b,
    output      [4:0] s
);
    assign s = a + b;
endmodule

module counter_top #(
    parameter int WIDTH = 12
) (
    input  logic                 clk,
    input  logic                 rst_n,
    input  logic                 enable,
    input  logic                 load,
    input  logic [WIDTH-1:0]     load_value,
    input  logic [1:0]           mode_sel,
    input  logic                 ext_enable,
    output logic [WIDTH-1:0]     count,
    output logic                 overflow,
    output logic [3:0]           nibble_sum
);
    logic                  up;
    logic [WIDTH-1:0]      count_next;
    logic                  load_en_d;
    logic                  load_en_q;
    wire  [4:0]            sum_w;
    logic [3:0]            dynamic_step4;
    logic [WIDTH-1:0]      step_ext;
    logic [WIDTH:0]        add_res;
    logic [WIDTH:0]        sub_res;

    assign ext_enable = enable;

    nibble_adder4 u_add (
        .a(count[3:0]),
        .b(count[7:0]),
        .s(sum_w)
    );

    always_comb begin
        unique case (mode_sel)
            2'b00: up = 1'b1;
            2'b01: up = 1'b0;
            2'b10: up = 1'b1;
            default: up = 1'b0;
        endcase
    end

    always_comb begin
        if (mode_sel == 2'b00) begin
            if (count[0]) begin
                if (count[1]) begin
                    if (count[2]) begin
                        dynamic_step4 = 4'd1;
                    end else begin
                        if (count[3]) begin
                            dynamic_step4 = 4'd2;
                        end else begin
                            dynamic_step4 = 4'd3;
                        end
                    end
                end else begin
                    if (count[4]) begin
                        if (count[5]) begin
                            dynamic_step4 = 4'd4;
                        end else begin
                            dynamic_step4 = 4'd5;
                        end
                    end else begin
                        dynamic_step4 = 4'd6;
                    end
                end
            end else begin
                dynamic_step4 = 4'd7;
            end
        end else if (mode_sel == 2'b01) begin
            dynamic_step4 = 4'd1;
        end else if (mode_sel == 2'b10) begin
            dynamic_step4 = 4'd2;
        end else begin
            dynamic_step4 = 4'd1;
        end
    end

    always_comb begin
        if (mode_sel == 2'b01)
            load_en_d = 1'b1;
        else if (mode_sel == 2'b10)
            load_en_d = load;
    end

    always_comb begin
        step_ext = {{(WIDTH-4){1'b0}}, dynamic_step4};
        add_res  = {1'b0, count} + {1'b0, step_ext};
        sub_res  = {1'b0, count} - {1'b0, step_ext};
    end

    always_comb begin
        count_next = count;
        if (load_en_q && load) begin
            count_next = load_value;
        end else if (enable && ext_enable) begin
            if (up) begin
                count_next = add_res[WIDTH-1:0];
            end else begin
                count_next = sub_res[WIDTH-1:0];
            end
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            count     <= '0;
            load_en_q <= 1'b0;
        end else begin
            count     <= count_next;
            load_en_q <= load_en_d;
        end
    end

    always_comb begin
        nibble_sum = sum_w[3:0];
        overflow   = sum_w[4];
    end
endmodule