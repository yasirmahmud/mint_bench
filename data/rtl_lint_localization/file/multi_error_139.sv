module shift_register #(
    parameter int WIDTH = 16
) (
    input  logic                   clk,
    input  logic                   rst_n,
    input  logic                   enable,
    input  logic                   load,
    input  logic                   dir,
    input  logic [1:0]             mode,
    input  logic                   serial_in,
    input  logic [WIDTH-1:0]       parallel_in,
    output logic [WIDTH-1:0]       parallel_out,
    output logic                   serial_out
);

    localparam int CNTW = $clog2(WIDTH+1);

    logic [WIDTH-1:0] shreg;
    logic [WIDTH-1:0] next_shreg;
    logic             serial_out_reg;
    logic             fill_bit;
    logic             parity_shreg;
    logic             parity_in;
    logic [CNTW-1:0]  step_counter;
    logic             odd_step;

    function automatic logic parity_calc(input logic [WIDTH-1:0] v);
        parity_calc = ^v;
    endfunction

    always_comb begin
        parity_shreg = parity_calc(shreg);
        parity_in    = parity_calc(parallel_in);
    end

    assign odd_step = step_counter[0];

    assign fill_bit = enable ? (load ? (dir ? (mode==2'b00 ? (odd_step ? serial_in : serial_in) : (mode==2'b01 ? 1'b0 : (mode==2'b10 ? 1'b1 : parity_shreg))) : (mode==2'b00 ? (odd_step ? serial_in : serial_in) : (mode==2'b01 ? 1'b0 : (mode==2'b10 ? 1'b1 : parity_in)))) : (dir ? (mode==2'b00 ? (odd_step ? serial_in : serial_in) : (mode==2'b01 ? 1'b0 : (mode==2'b10 ? 1'b1 : (parity_shreg ^ parity_in)))) : (mode==2'b00 ? (odd_step ? serial_in : serial_in) : (mode==2'b01 ? 1'b0 : (mode==2'b10 ? 1'b1 : (parity_shreg & parity_in)))))) : (mode==2'b00 ? (odd_step ? serial_in : serial_in) : (mode==2'b01 ? 1'b0 : (mode==2'b10 ? 1'b1 : (parity_shreg | parity_in))));

    always_comb begin
        next_shreg = shreg;
        if (load) begin
            next_shreg = parallel_in;
        end else if (enable) begin
            if (dir) begin
                next_shreg = {fill_bit, shreg[WIDTH-1:1]};
            end else begin
                next_shreg = {shreg[WIDTH-2:0], fill_bit};
            end
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            shreg          <= '0;
            serial_out_reg <= 1'b0;
            parallel_out   <= '0;
        end else begin
            shreg        <= next_shreg;
            parallel_out <= next_shreg;
            serial_out_reg = dir ? shreg[0] : shreg[WIDTH-1];
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            step_counter <= '0;
        end else begin
            if (enable && !load) begin
                if (step_counter == WIDTH-1) begin
                    step_counter <= '0;
                end else begin
                    step_counter <= step_counter + 1'b1;
                end
            end
        end
    end

    assign serial_out = serial_out_reg;

endmodule