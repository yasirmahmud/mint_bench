module request_resolver #(parameter N = 10) (
    input clk,
    input rst_n,
    input [N:1] buttons,
    input [N-1:1] up_button,
    input [N:2] dwn_button,
    input [N:1] floor_status,
    input up,
    input down,
    input open,
    output reg [N:1] req
);


reg [N:1] reg_buttons;
reg [N-1:1] reg_up_rqs;
reg [N:2] reg_dwn_rqs;

reg reg_up_status, reg_dwn_status;

wire assume_up_status;

wire [N:1] requests, up_requests, down_requests;
wire [N:1] down_requests_reversed, reversed_down_floor, down_floor;

wire up_requests_flag, down_requests_flag, same_floor_request_flag;
wire up_flag, down_flag, stay_idle_flag, open_the_door_flag;

wire [N+1:1] temp_floor_status;

integer i;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        reg_buttons <= 0;
        reg_up_rqs <= 0;
        reg_dwn_rqs <= 0;
        reg_up_status <= 0;
        reg_dwn_status <= 0;
    end else begin
        for (i = 1; i <= N; i = i + 1) begin
            if (floor_status[i] && open) {
                reg_buttons[i] <= 1'b0;
            } else if(!reg_buttons[i] && buttons[i]) {
                reg_buttons[i] <= buttons[i];
            }
        end

        for (i = 1; i <= N-1; i = i + 1) begin
            if (floor_status[i] && open) {
                reg_up_rqs[i] <= 1'b0;
            } else if (!reg_up_rqs[i] && up_button[i]) {
                reg_up_rqs[i] <= up_button[i];
            }

            if (floor_status[i+1] && open) {
                reg_dwn_rqs[i+1] <= 1'b0;
            } else if (!reg_dwn_rqs[i+1] && dwn_button[i+1]) {
                reg_dwn_rqs[i+1] <= dwn_button[i+1];
            }
        end

        if(!open) begin
            reg_up_status <= up;
            reg_dwn_status <= down;
        end
    end
end

// Add an intermediate wire to break the combinational loop for 'requests'
wire [N:1] current_reg_requests;
assign current_reg_requests = reg_buttons | {1'b0, reg_up_rqs} | {reg_dwn_rqs, 1'b0};

// Fixed combinational loop: 'requests' no longer refers to itself.
// It now either reflects the registered requests, or a masked version if 'open' is high.
assign requests = (open == 1'b1) ? (current_reg_requests & ~(floor_status)) : current_reg_requests;

assign temp_floor_status = ~({floor_status, 1'b0} - 1);
assign up_requests = requests & temp_floor_status[N:1];
assign up_requests_flag = |up_requests;

assign down_requests = requests & ({floor_status} - 1);
assign down_requests_flag = |down_requests;

assign same_floor_request_flag = |(requests & floor_status);

assign assume_up_status = (floor_status >= (N / 2)) ? 1'b1 : 1'b0;

assign up_flag = (reg_up_status & up_requests_flag) |
                (reg_dwn_status & !down_requests_flag & up_requests_flag) |
                (!reg_up_status & !reg_dwn_status & assume_up_status & up_requests_flag) |
                (!reg_up_status & !reg_dwn_status & !assume_up_status & up_requests_flag & !down_requests_flag);

assign down_flag = (reg_dwn_status & down_requests_flag) |
                   (reg_up_status & !up_requests_flag & down_requests_flag) |
                   (!reg_up_status & !reg_dwn_status & !assume_up_status & down_requests_flag) |
                   (!reg_up_status & !reg_dwn_status & assume_up_status & !up_requests_flag & down_requests_flag);

assign open_the_door_flag = !reg_up_status & !reg_dwn_status & same_floor_request_flag;

// Removed 'stay_idle_flag' as it was set but never read.
// assign stay_idle_flag = !up_requests_flag & !down_requests_flag & !same_floor_request_flag;

genvar k;

generate
    for (k = 0; k < N; k = k + 1) begin : gen_down_requests_reversed // Named generate block
        assign down_requests_reversed[k+1] = down_requests[N-k];
    end
endgenerate

assign reversed_down_floor = down_requests_reversed & (~(down_requests_reversed) + 1);

generate
    for (k = 0; k < N; k = k + 1) begin : gen_down_floor_output // Named generate block
        assign down_floor[k+1] = reversed_down_floor[N-k];
    end
endgenerate


always @(*) begin
    if(open_the_door_flag) begin
        req = floor_status;
    end else if(up_flag) begin
        req = up_requests & (~up_requests + 1);
    end else if (down_flag) begin
        req = down_floor;
    end else begin
        req = {N{1'b0}};
    end
end


endmodule
