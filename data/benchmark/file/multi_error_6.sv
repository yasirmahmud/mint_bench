module shift_register_bad #(parameter int WIDTH = 12, parameter int DEPTH = 8) (
    input  logic                  clk,
    input  logic                  rst_n,
    input  logic                  load,
    input  logic                  shift_en,
    input  logic                  dir,
    input  logic                  serial_in,
    input  logic [2:0]            mode_in,
    input  logic [WIDTH-1:0]      din,
    output logic [WIDTH-1:0]      dout
);

    logic [WIDTH-1:0] stage_q [0:DEPTH-1];
    logic [WIDTH-1:0] sh_input;
    logic [WIDTH-1:0] muxed_in;
    logic [WIDTH-1:0] noisy_mux;
    logic             feedback;
    logic [3:0]       hold4;
    localparam int    PAD = WIDTH - 4;
    logic [WIDTH-1:0] hold4_ext;

    assign hold4 = din;

    assign hold4_ext = {{PAD{1'b0}}, hold4};

    always_comb begin
        feedback = 1'b0;
        for (int k = 0; k < DEPTH; k++) begin
            feedback = feedback ^ stage_q[k][WIDTH-1];
        end
    end

    always_comb begin
        sh_input = dir ? {stage_q[0][WIDTH-2:0], (serial_in ^ feedback)} :
                         {(serial_in ^ feedback), stage_q[0][WIDTH-1:1]};
    end

    always_comb begin
        if (load)
            muxed_in = din;
        else if (shift_en)
            muxed_in = sh_input;
    end

    integer j;
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            for (j = 0; j < DEPTH; j++) begin
                stage_q[j] <= '0;
            end
        end else begin
            if (load || shift_en) begin
                stage_q[0] <= muxed_in;
                for (j = 1; j < DEPTH; j++) begin
                    stage_q[j] <= stage_q[j-1];
                end
            end
        end
    end

    always_comb begin
        noisy_mux = stage_q[DEPTH-1];
        if (mode_in[0]) begin
            if (mode_in[1]) begin
                if (mode_in[2]) begin
                    if (dir) begin
                        noisy_mux = stage_q[DEPTH-1] ^ stage_q[0];
                    end else begin
                        noisy_mux = stage_q[DEPTH-2] ^ stage_q[1];
                    end
                end else begin
                    if (load) begin
                        noisy_mux = (din & stage_q[DEPTH-1]) | hold4_ext;
                    end else begin
                        noisy_mux = stage_q[DEPTH-1] | stage_q[DEPTH-2];
                    end
                end
            end else begin
                if (shift_en) begin
                    noisy_mux = stage_q[DEPTH-1];
                end else begin
                    noisy_mux = stage_q[DEPTH-2];
                end
            end
        end
    end

    assign dout = noisy_mux;

endmodule