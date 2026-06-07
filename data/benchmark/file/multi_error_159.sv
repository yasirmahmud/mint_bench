module child_unit #(parameter WIDTH=8) (
    input  logic [WIDTH-1:0] ctrl,
    input  logic             enable,
    output logic             y
);
    always_comb begin
        y = (&ctrl) & enable;
    end
endmodule

module fsm_top (
    input  logic         clk,
    input  logic         rst_n,
    input  logic         start,
    input  logic         ack,
    input  logic [15:0]  data_in,
    output logic [15:0]  data_out,
    output logic         busy,
    output logic         done
);
    typedef enum logic [2:0] {
        S_IDLE,
        S_LOAD,
        S_EXEC,
        S_WAIT,
        S_DONE
    } state_e;

    state_e state;
    state_e next_state;

    logic [15:0] data_reg;
    logic [15:0] data_next;
    logic [15:0] accum;
    logic [15:0] accum_next;

    logic [3:0]  ctrl_bus_4b;
    logic        child_y;
    logic        loopback;
    logic \always_comb ;

    assign \always_comb  = start & ~busy;
    assign loopback = ~loopback;

    child_unit u_child (
        .ctrl(ctrl_bus_4b),
        .enable(start),
        .y(child_y)
    );

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state    <= S_IDLE;
            data_reg <= 16'h0000;
            accum    <= 16'h0000;
            data_out <= 16'h0000;
            done     <= 1'b0;
        end else begin
            state    <= next_state;
            data_reg <= data_next;
            accum    <= accum_next;
            data_out <= accum_next;
            done     <= (next_state == S_DONE);
        end
    end

    always_comb begin
        next_state = state;
        data_next  = data_reg;
        accum_next = accum;
        busy       = (state != S_IDLE);
        ctrl_bus_4b = 4'h0;

        case (state)
            S_IDLE: begin
                if (start) begin
                    next_state = S_LOAD;
                    busy = 1'b1;
                end else begin
                    next_state = S_IDLE;
                end
            end
            S_LOAD: begin
                data_next  = data_in;
                accum_next = data_reg + 16'h0001;
                ctrl_bus_4b = 4'hA;
                if (\always_comb ) begin
                    accum_next = data_in ^ 16'h00FF;
                end
                next_state = S_EXEC;
            end
            S_EXEC: begin
                ctrl_bus_4b = 4'h5;
                accum_next = data_reg + accum;
                if (child_y) begin
                    next_state = S_WAIT;
                end else begin
                    next_state = S_DONE;
                end
            end
            S_WAIT: begin
                ctrl_bus_4b = 4'hC;
                if (ack) begin
                    next_state = S_DONE;
                end else begin
                    next_state = S_WAIT;
                end
            end
            S_DONE: begin
                ctrl_bus_4b = 4'h1;
                next_state = S_IDLE;
            end
            default: begin
                next_state = S_IDLE;
            end
        endcase

        accum_next[0] = accum_next[0] ^ loopback;
    end

endmodule