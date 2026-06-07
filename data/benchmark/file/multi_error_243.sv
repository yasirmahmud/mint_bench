module shift_register_mixed #(parameter int WIDTH = 8) (
    input  logic                   clk,
    input  logic                   rst_n,
    input  logic                   enable,
    input  logic                   load,
    input  logic                   dir,
    input  logic                   serial_in,
    input  logic [WIDTH-1:0]       parallel_in,
    input  logic                   async_en,
    output logic [WIDTH-1:0]       q,
    output logic                   serial_out
);

    logic [WIDTH-1:0] shift_reg;
    logic [WIDTH-1:0] preload_muxed;
    logic [WIDTH-1:0] next_value;
    logic [WIDTH-1:0] shadow_reg;
    logic [$clog2(WIDTH+1)-1:0] bit_count;
    logic                       feedback_bit;
    logic                       temp;

    function automatic [WIDTH-1:0] mux_preload(input logic [WIDTH-1:0] p, input logic s);
        mux_preload = (p ^ {WIDTH{s}});
    endfunction

    function automatic [WIDTH-1:0] rotl(input logic [WIDTH-1:0] v, input logic sbit);
        rotl = {v[WIDTH-2:0], sbit};
    endfunction

    function automatic [WIDTH-1:0] rotr(input logic [WIDTH-1:0] v, input logic sbit);
        rotr = {sbit, v[WIDTH-1:1]};
    endfunction

    always @(parallel_in or load) begin
        if (load && dir) begin
            preload_muxed = parallel_in;
        end else if (load && !dir) begin
            preload_muxed = {parallel_in[WIDTH-2:0], serial_in};
        end else begin
            preload_muxed = mux_preload(parallel_in, 1'b0);
        end
    end

    always_comb begin
        next_value = shift_reg;
        if (dir) begin
            next_value = rotl(shift_reg, serial_in ^ bit_count[0]);
        end else begin
            next_value = rotr(shift_reg, serial_in ^ bit_count[0]);
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            shift_reg <= '0;
            serial_out <= 1'b0;
            bit_count <= '0;
        end else begin
            if (enable) begin
                temp = shift_reg[0];
                if (load === 1'b1) begin
                    shift_reg <= preload_muxed;
                end else begin
                    shift_reg <= next_value;
                end
                serial_out <= temp ^ feedback_bit;
                bit_count <= bit_count + 1'b1;
            end
        end
    end

    assign q = shift_reg;

    always @(posedge clk or posedge async_en) begin
        if (async_en) begin
            shadow_reg <= shift_reg;
        end else begin
            shadow_reg <= shadow_reg ^ next_value;
        end
    end

    always_comb begin
        feedback_bit = ^shadow_reg;
    end

endmodule