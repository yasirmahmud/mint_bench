module tx_8bit_fifo_phy #(
	parameter PHASE = 0,    // CPOL: 0=low, 1=high
	parameter ACTIVE = 0    // CPHA: 0=change on 1st edge, 1=change on 2nd edge
)(
	input				sck,
	input				cs_n,
	output				miso,
	input				clock,
	input				rst_n,
	output				send_flag,
	input	[23:0]		send_momment,
	input	[7:0]		send_data,
	input				send_valid,
	output				empty
);
    reg [7:0]   tx_data_reg;
    reg [2:0]   bit_counter_reg;
    reg         tx_active_reg;       // indicates data is being transmitted
    reg         tx_data_ready_reg;   // indicates tx_data_reg has valid data to transmit
    reg         sck_r;
    reg         miso_reg;
    reg         send_flag_reg;
    reg [23:0]  momment_counter_reg; // Internal counter for send_momment

    // Logic to determine when to shift data out on MISO
    // This edge depends on PHASE and ACTIVE (CPOL/CPHA)
    wire            sck_tx_edge;
    assign sck_tx_edge = (
        (PHASE == 0 && ACTIVE == 0 && (sck_r == 1'b0 && sck == 1'b1)) || // CPOL=0, CPHA=0: posedge sck
        (PHASE == 0 && ACTIVE == 1 && (sck_r == 1'b1 && sck == 1'b0)) || // CPOL=0, CPHA=1: negedge sck
        (PHASE == 1 && ACTIVE == 0 && (sck_r == 1'b1 && sck == 1'b0)) || // CPOL=1, CPHA=0: negedge sck
        (PHASE == 1 && ACTIVE == 1 && (sck_r == 1'b0 && sck == 1'b1))    // CPOL=1, CPHA=1: posedge sck
    );

    always @(posedge clock or negedge rst_n) begin
        if (!rst_n) begin
            tx_data_reg <= 8'h00;
            bit_counter_reg <= 3'b000;
            tx_active_reg <= 1'b0;
            tx_data_ready_reg <= 1'b0; // Buffer is empty
            sck_r <= 1'b0;
            miso_reg <= 1'b0;
            send_flag_reg <= 1'b0;
            momment_counter_reg <= 24'h0;
        end else begin
            sck_r <= sck;
            send_flag_reg <= 1'b0; // Clear by default

            // Load new data if send_valid is high and buffer is not ready (empty)
            if (send_valid && !tx_data_ready_reg) begin
                tx_data_reg <= send_data;
                tx_data_ready_reg <= 1'b1; // Data is ready to be sent
                bit_counter_reg <= 3'd0;    // Reset bit counter for new transmission
                momment_counter_reg <= send_momment; // Load momment value with new data
            end

            // Transmission logic
            if (cs_n == 1'b0) begin // Chip Select asserted, active transmission possible
                if (tx_data_ready_reg && !tx_active_reg) begin // Start new transmission if data is ready and not already active
                    tx_active_reg <= 1'b1; // Begin transmission
                end

                if (tx_active_reg) begin
                    if (sck_tx_edge) begin // On the appropriate SCK edge to change MISO
                        if (bit_counter_reg < 3'd8) begin
                            miso_reg <= tx_data_reg[7 - bit_counter_reg]; // Shift out MSB first
                            bit_counter_reg <= bit_counter_reg + 1'b1;
                        end

                        // When all 8 bits are shifted out (after the 7th bit, which is the 8th overall, is sent)
                        if (bit_counter_reg == 3'd7) begin
                            tx_active_reg <= 1'b0;        // Transmission done for this byte
                            tx_data_ready_reg <= 1'b0;    // Buffer is now empty/available for new data
                            
                            if (momment_counter_reg > 24'h0) begin
                                momment_counter_reg <= momment_counter_reg - 1'b1; // Example usage: decrement momment
                            end
                            // If momment reaches 0 (or was 0), assert send_flag
                            if (momment_counter_reg == 24'h1) begin // If it was 1 before decrementing
                                send_flag_reg <= 1'b1;
                            end
                        end
                    end
                end
            end else begin // CS_N is high, not active transmission
                tx_active_reg <= 1'b0; // Stop any ongoing transmission
                bit_counter_reg <= 3'd0; // Reset bit counter
                miso_reg <= 1'b0; // Drive MISO low when inactive (or high-Z)
            end
        end
    end

    assign miso = miso_reg;
    assign send_flag = send_flag_reg;
    assign empty = !tx_data_ready_reg; // Empty when no data is ready to be sent
endmodule
