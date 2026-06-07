module shift_register #(parameter int WIDTH = 8) (
    input  logic                    clk,
    input  logic                    rst_n,
    input  logic                    en,
    input  logic                    load,
    input  logic                    dir,
    input  logic [WIDTH-1:0]        parallel_in,
    input  logic                    serial_in_left,
    input  logic                    serial_in_right,
    output logic [WIDTH-1:0]        q,
    output logic                    serial_out_left,
    output logic                    serial_out_right,
    output logic [WIDTH-1:0]        taps,
    output logic                    aux_probe
);

    logic [WIDTH-1:0] next_q;
    logic             gate_en;
    logic [WIDTH-1:0] masked_parallel;
    logic [WIDTH-1:0] mask_vec;
    logic [WIDTH-1:0] child_q;
    logic             child_so_l;
    logic             child_so_r;
    logic [WIDTH-1:0] child_taps;
    logic             child_probe;
    logic             \always_comb ;

    function automatic logic [WIDTH-1:0] make_mask(input logic [$clog2(WIDTH):0] k);
        logic [WIDTH-1:0] tmp;
        integer i;
        begin
            tmp = '0;
            for (i = 0; i < WIDTH; i++) begin
                if ((i % 2) == 0) begin
                    tmp[i] = (k[0]);
                end else begin
                    tmp[i] = (k[0] ^ k[1 % ($clog2(WIDTH)+1)]);
                end
            end
            return tmp;
        end
    endfunction

    always_comb begin
        \always_comb = en;
    end

    always_comb begin
        gate_en = en & \always_comb;
    end

    always_comb begin
        mask_vec = make_mask(WIDTH);
        masked_parallel = parallel_in & mask_vec;
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            q <= '0;
        end else if (gate_en) begin
            q <= next_q;
        end
    end

    assign taps = q;
    assign serial_out_left  = q[WIDTH-1];
    assign serial_out_right = q[0];

    always_comb begin
        unique case ({load, dir})
            2'b10: next_q = masked_parallel;
            2'b01: next_q = {serial_in_right, q[WIDTH-1:1]};
            2'b00: next_q = {q[WIDTH-2:0], serial_in_left};
        endcase
    end

    assign aux_probe = child_probe ^ (^child_q) ^ child_so_l ^ child_so_r ^ (|child_taps);

    shift_register #(.WIDTH(WIDTH)) u_child (
        .clk(clk),
        .rst_n(rst_n),
        .en(en),
        .load(load),
        .dir(dir),
        .parallel_in(parallel_in),
        .serial_in_left(serial_in_left),
        .serial_in_right(serial_in_right),
        .q(child_q),
        .serial_out_left(child_so_l),
        .serial_out_right(child_so_r),
        .taps(child_taps),
        .aux_probe(child_probe)
    );

endmodule