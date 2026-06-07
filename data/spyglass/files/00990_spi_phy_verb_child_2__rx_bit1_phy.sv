module rx_bit1_phy #(
	parameter PHASE = 0,    // CPOL: 0=low, 1=high
	parameter ACTIVE = 0    // CPHA: 0=sample 1st edge, 1=sample 2nd edge
)(
	input				sck,
	input				cs_n,
	input				mosi,
	input				clock,
	input				rst_n,
	output				start,
	output				finish,
	output				rx_data,
	output				rx_valid
);
    reg             sck_r;
    reg             cs_n_prev;
    reg             mosi_sampled;
    reg             rx_valid_reg;

    // Determine the SCK edge for sampling based on PHASE and ACTIVE
    wire            sck_sample_edge;
    assign sck_sample_edge = (
        (PHASE == 0 && ACTIVE == 0 && (sck_r == 1'b0 && sck == 1'b1)) || // CPOL=0, CPHA=0: posedge sck
        (PHASE == 0 && ACTIVE == 1 && (sck_r == 1'b1 && sck == 1'b0)) || // CPOL=0, CPHA=1: negedge sck
        (PHASE == 1 && ACTIVE == 0 && (sck_r == 1'b1 && sck == 1'b0)) || // CPOL=1, CPHA=0: negedge sck
        (PHASE == 1 && ACTIVE == 1 && (sck_r == 1'b0 && sck == 1'b1))    // CPOL=1, CPHA=1: posedge sck
    );

    always @(posedge clock or negedge rst_n) begin
        if (!rst_n) begin
            sck_r <= 1'b0;
            cs_n_prev <= 1'b1;
            mosi_sampled <= 1'b0;
            rx_valid_reg <= 1'b0;
        end else begin
            sck_r <= sck;
            cs_n_prev <= cs_n;
            rx_valid_reg <= 1'b0; // Clear by default

            if (cs_n == 1'b0) begin // Chip select asserted
                if (sck_sample_edge) begin
                    mosi_sampled <= mosi;
                    rx_valid_reg <= 1'b1;
                end
            end
        end
    end

    // Start of transaction: cs_n goes low
    assign start = (cs_n_prev == 1'b1 && cs_n == 1'b0);
    // End of transaction: cs_n goes high
    assign finish = (cs_n_prev == 1'b0 && cs_n == 1'b1);
    assign rx_data = mosi_sampled;
    assign rx_valid = rx_valid_reg;
endmodule
