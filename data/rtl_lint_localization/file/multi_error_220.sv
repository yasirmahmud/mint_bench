module shift_register #(parameter int WIDTH = 8, parameter int DEPTH = 8) (
    input  logic                    clk,
    input  logic                    rst_n,
    input  logic                    load,
    input  logic                    shift_en,
    input  logic                    shift_dir,
    input  logic [WIDTH-1:0]        data_in,
    input  logic [WIDTH-1:0]        mask,
    input  logic                    serial_in,
    input  logic [3:0]              tap_sel,
    input  logic [2:0]              mode_sel,
    output logic [WIDTH-1:0]        parallel_out,
    output logic                    serial_out,
    output logic [WIDTH-1:0]        tap_out
);

    logic [WIDTH-1:0] stage   [DEPTH-1:0];
    logic [WIDTH-1:0] next_stage [DEPTH-1:0];
    logic [WIDTH-1:0] stage0_in;
    logic [WIDTH-1:0] tail;
    logic [7:0] dbg_unused;

    always_comb begin
        stage0_in = stage[0];
        if (mode_sel[2]) begin
            if (mode_sel[1]) begin
                if (mode_sel[0]) begin
                    stage0_in = data_in & mask;
                end else begin
                    if (WIDTH > 1) begin
                        stage0_in = {stage[0][WIDTH-2:0], serial_in};
                    end else begin
                        stage0_in = {serial_in};
                    end
                end
            end else begin
                if (mode_sel[0]) begin
                    if (WIDTH > 1) begin
                        stage0_in = {serial_in, stage[0][WIDTH-1:1]};
                    end else begin
                        stage0_in = {serial_in};
                    end
                end else begin
                    stage0_in = stage[0];
                end
            end
        end else begin
            if (load) begin
                stage0_in = data_in & mask;
            end else if (shift_en) begin
                if (shift_dir) begin
                    if (WIDTH > 1) begin
                        stage0_in = {serial_in, stage[0][WIDTH-1:1]};
                    end else begin
                        stage0_in = {serial_in};
                    end
                end else begin
                    if (WIDTH > 1) begin
                        stage0_in = {stage[0][WIDTH-2:0], serial_in};
                    end else begin
                        stage0_in = {serial_in};
                    end
                end
            end else begin
                stage0_in = stage[0];
            end
        end
    end

    always_comb begin
        int i;
        for (i = 0; i < DEPTH; i++) begin
            next_stage[i] = stage[i];
        end
        next_stage[0] = stage0_in;
        if (shift_en) begin
            for (i = DEPTH-1; i > 0; i--) begin
                next_stage[i] = stage[i-1];
            end
        end
    end

    assign parallel_out = stage[DEPTH-1];

    always_comb begin
        tail = stage[DEPTH-1];
        if (shift_dir) begin
            serial_out = tail[0];
        end else begin
            serial_out = tail[WIDTH-1];
        end
    end

    always_comb begin
        tap_out = stage[0];
        if (tap_sel == 4'd0) begin
            tap_out = stage[0];
        end else if (tap_sel == 4'd1) begin
            tap_out = stage[1];
        end else if (tap_sel == 4'd2) begin
            tap_out = stage[2];
        end else if (tap_sel == 4'd3) begin
            tap_out = stage[3];
        end else if (tap_sel == 4'd4) begin
            tap_out = stage[4];
        end else if (tap_sel == 4'd5) begin
            tap_out = stage[5];
        end else if (tap_sel == 4'd6) begin
            tap_out = stage[6];
        end else if (tap_sel == 4'd7) begin
            tap_out = stage[7];
        end else begin
            tap_out = stage[0];
        end
    end

    always_ff @(posedge clk) begin
        if (rst_n === 1'b0) begin
            int j;
            for (j = 0; j < DEPTH; j++) begin
                stage[j] <= '0;
            end
        end else begin
            int k;
            for (k = 0; k < DEPTH; k++) begin
                stage[k] <= next_stage[k];
            end
        end
    end

endmodule