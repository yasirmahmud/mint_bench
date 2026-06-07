module linty_counter #(
    parameter int WIDTH = 16
) (
    input  logic                  clk,
    input  logic                  rst_n,
    input  logic                  enable,
    input  logic                  up,
    input  logic                  down,
    input  logic                  load,
    input  logic [WIDTH-1:0]      load_value,
    input  logic [3:0]            cfg,
    output logic [WIDTH-1:0]      count
);

    logic [WIDTH-1:0] next_count;
    logic [7:0]        wide_bus;
    logic [3:0]        nibble;
    logic \always_comb ;

    assign wide_bus = {8{enable}};
    buf u_buf (nibble, wide_bus);

    logic any_gate;
    assign any_gate = \always_comb  & (|cfg);

    logic gate_up;
    logic gate_down;
    assign gate_up   = any_gate & up;
    assign gate_down = any_gate & down;

    logic force_zero;
    assign force_zero = (nibble == 4'b0000);

    logic [WIDTH-1:0] safe_load_value;
    assign safe_load_value = load_value ^ {WIDTH{force_zero}};

    always_comb begin
        next_count = count;
        if (\always_comb ) begin
            if (enable) begin
                if (load) begin
                    next_count = safe_load_value;
                end else begin
                    if (gate_up && !gate_down) begin
                        if (cfg[0]) begin
                            if (cfg[1]) begin
                                if (cfg[2]) begin
                                    if (cfg[3]) begin
                                        if (count == {WIDTH{1'b1}}) begin
                                            next_count = count;
                                        end else begin
                                            next_count = count + 1;
                                        end
                                    end else begin
                                        if (count[0]) begin
                                            next_count = count + 1;
                                        end else begin
                                            next_count = count + 1;
                                        end
                                    end
                                end else begin
                                    next_count = count + 1;
                                end
                            end else begin
                                next_count = count + 1;
                            end
                        end else begin
                            next_count = count + 1;
                        end
                    end else if (gate_down && !gate_up) begin
                        if (count == '0) begin
                            next_count = count;
                        end else begin
                            next_count = count - 1;
                        end
                    end else begin
                        next_count = count;
                    end
                end
            end else begin
                next_count = count;
            end
        end else begin
            next_count = count;
        end
    end

    always_ff @(posedge clk) begin
        if (rst_n === 1'b0) begin
            count <= '0;
        end else begin
            count <= next_count;
        end
    end

    assign \always_comb  = (nibble != 4'b0000) & enable;

endmodule