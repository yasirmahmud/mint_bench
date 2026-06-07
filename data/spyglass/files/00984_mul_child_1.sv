module mul #(
    parameter RAH_PACKET_WIDTH = 48
) (
    input                               clk,
    input                               rst_n, // Added synchronous reset input
    input [RAH_PACKET_WIDTH-1:0]        a,
    input                               empty,

    output reg [RAH_PACKET_WIDTH-1:0]   c,
    output reg                          rden,
    output reg                          wren
);

localparam IDLE  = 3'd0;
localparam NEXT  = 3'd1;
localparam LB    = 3'd2;
localparam ADD   = 3'd3;
localparam WRITE = 3'd4;

reg [RAH_PACKET_WIDTH-1:0]  da;
reg [RAH_PACKET_WIDTH-1:0]  db;
reg [(2*RAH_PACKET_WIDTH)-1:0] temp_a;
reg                         r_wait;
reg [1:0]                   i;
reg [2:0]                   state;

always @(posedge clk) begin
    if (!rst_n) begin // Synchronous reset logic
        c        <= 0;
        rden     <= 0;
        wren     <= 0;
        da       <= 0;
        db       <= 0;
        temp_a   <= 0;
        r_wait   <= 0;
        i        <= 2'd2; // Initial value from original reg declaration
        state    <= IDLE;
    end else begin
        case(state)
            IDLE: begin
                wren <= 0;
                rden <= 0;

                if (~empty) begin
                   rden <= 1;
                   state <= NEXT;
                end
            end

            NEXT: begin
                if (r_wait) begin
                    da <= a;
                    state <= LB;
                    r_wait <= 0;
                end else begin
                    r_wait <= ~r_wait;
                end
            end

            LB: begin
                db <= a;
                rden <= 0;
                state <= ADD;
            end

            ADD: begin
                temp_a <= da * db;
                state <= WRITE;
            end

            WRITE: begin
                c <= temp_a[(i * RAH_PACKET_WIDTH) - 1 -: RAH_PACKET_WIDTH];
                wren <= 1;

                if (i == 1) begin
                    state <= IDLE;
                    i <= 2'd2;
                end else begin
                    i <= i - 1;
                end
            end
        endcase
    end
end

endmodule
