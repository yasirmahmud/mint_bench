module cross_bar
(
    input           PCLK,
    input           PRESETN,

    // masters i/o
    input               master_1_req,
    input               master_1_cmd,
    input [31:0]        master_1_addr,
    input [31:0]        master_1_wdata,
    output reg          master_1_ack,
    output reg [31:0]   master_1_rdata,

    input               master_2_req,
    input               master_2_cmd,
    input [31:0]        master_2_addr,
    input [31:0]        master_2_wdata,
    output reg          master_2_ack,
    output reg [31:0]   master_2_rdata,

    // slaves i/o
    input               slave_1_ack,
    input [31:0]        slave_1_rdata,
    output reg          slave_1_req,
    output reg          slave_1_cmd,
    output reg [31:0]   slave_1_addr,
    output reg [31:0]   slave_1_wdata,

    input               slave_2_ack,
    input [31:0]        slave_2_rdata,
    output reg          slave_2_req,
    output reg          slave_2_cmd,
    output reg [31:0]   slave_2_addr,
    output reg [31:0]   slave_2_wdata
);

// Registered FSM state and associated registers
reg slave_1_arbitr_reg;
reg slave_2_arbitr_reg;
reg slave_1_cmd_r_reg;
reg slave_1_current_master_ID_reg;
reg [2:0] slave_1_state_reg;
reg slave_1_ack_q_reg;

reg slave_2_cmd_r_reg;
reg slave_2_current_master_ID_reg;
reg [2:0] slave_2_state_reg;
reg slave_2_ack_q_reg;

// Combinational next-state and next-register values
wire slave_1_arbitr_next;
wire slave_2_arbitr_next;
wire slave_1_cmd_r_next;
wire slave_1_current_master_ID_next;
wire [2:0] slave_1_state_next;

wire slave_2_cmd_r_next;
wire slave_2_current_master_ID_next;
wire [2:0] slave_2_state_next;

// Combinational logic for master outputs
wire master_1_ack_comb;
wire master_2_ack_comb;
wire [31:0] master_1_rdata_comb;
wire [31:0] master_2_rdata_comb;

localparam IDLE = 3'b001,
           SET  = 3'b010,
           ACK  = 3'b100;

// Arbitration and request signals (wires, purely combinational)
wire slave_1_arbitr_req = (!master_1_addr[31] & master_1_req) && (!master_2_addr[31] & master_2_req);
wire slave_2_arbitr_req = (master_1_addr[31] & master_1_req) && (master_2_addr[31] & master_2_req);

wire slave_1_ask = (!master_1_addr[31] & master_1_req) || (!master_2_addr[31] & master_2_req);
wire slave_2_ask = (master_1_addr[31] & master_1_req) || (master_2_addr[31] & master_2_req);

wire slave_1_master_sel = slave_1_arbitr_req ? slave_1_arbitr_reg : (!master_2_addr[31] & master_2_req);
wire slave_2_master_sel = slave_2_arbitr_req ? slave_2_arbitr_reg : (master_2_addr[31] & master_2_req);

// --- Slave 1 combinational output mux ---
always @(*) begin // Changed from always_comb to always @(*) for broader tool compatibility
    slave_1_req = 0;
    slave_1_cmd = 0;
    slave_1_addr = 0;
    slave_1_wdata = 0;
    if(slave_1_state_reg == SET) begin // Use registered state
        slave_1_req = slave_1_current_master_ID_reg ? master_2_req : master_1_req;
        slave_1_cmd = slave_1_current_master_ID_reg ? master_2_cmd : master_1_cmd;
        slave_1_addr = slave_1_current_master_ID_reg ? master_2_addr : master_1_addr;
        slave_1_wdata = slave_1_current_master_ID_reg ? master_2_wdata : master_1_wdata;
    end
    else if(slave_1_ask && (slave_1_state_reg == IDLE)) begin // Use registered state
        slave_1_req = slave_1_master_sel ? master_2_req : master_1_req;
        slave_1_cmd = slave_1_master_sel ? master_2_cmd : master_1_cmd;
        slave_1_addr = slave_1_master_sel ? master_2_addr : master_1_addr;
        slave_1_wdata = slave_1_master_sel ? master_2_wdata : master_1_wdata;
    end
end

// --- Slave 2 combinational output mux ---
always @(*) begin // Changed from always_comb to always @(*) for broader tool compatibility
    slave_2_req = 0;
    slave_2_cmd = 0;
    slave_2_addr = 0;
    slave_2_wdata = 0;
    if(slave_2_state_reg == SET) begin // Use registered state
        slave_2_req = slave_2_current_master_ID_reg ? master_2_req : master_1_req;
        slave_2_cmd = slave_2_current_master_ID_reg ? master_2_cmd : master_1_cmd;
        slave_2_addr = slave_2_current_master_ID_reg ? master_2_addr : master_1_addr;
        slave_2_wdata = slave_2_current_master_ID_reg ? master_2_wdata : master_1_wdata;
    end
    else if(slave_2_ask && (slave_2_state_reg == IDLE)) begin // Use registered state
        slave_2_req = slave_2_master_sel ? master_2_req : master_1_req;
        slave_2_cmd = slave_2_master_sel ? master_2_cmd : master_1_cmd;
        slave_2_addr = slave_2_master_sel ? master_2_addr : master_1_addr;
        slave_2_wdata = slave_2_master_sel ? master_2_wdata : master_1_wdata;
    }
end

// --- Slave 1 FSM next state and next register combinational logic ---
always @(*) begin // Changed from always_comb to always @(*) for broader tool compatibility
    slave_1_state_next = slave_1_state_reg; // Default: stay in current state
    slave_1_arbitr_next = slave_1_arbitr_reg; // Default: hold current value
    slave_1_current_master_ID_next = slave_1_current_master_ID_reg; // Default: hold current value
    slave_1_cmd_r_next = slave_1_cmd_r_reg; // Default: hold current value

    case(slave_1_state_reg)
        IDLE:begin
            if(slave_1_ask) begin
                if(slave_1_arbitr_req)
                    slave_1_arbitr_next = !slave_1_arbitr_reg;
                slave_1_current_master_ID_next = slave_1_master_sel;
                slave_1_cmd_r_next = slave_1_master_sel ? master_2_cmd : master_1_cmd;
                slave_1_state_next = SET;
            end
        end
        SET:begin
            if(!slave_1_ack_q_reg && slave_1_ack) begin
                slave_1_state_next = ACK;
            end
            else if(!slave_1_ask) begin // Transaction aborted, or master deasserted req
                slave_1_state_next = IDLE;
            end
        end
        ACK:begin
            slave_1_state_next = IDLE;
        end
    endcase
end

// --- Slave 2 FSM next state and next register combinational logic ---
always @(*) begin // Changed from always_comb to always @(*) for broader tool compatibility
    slave_2_state_next = slave_2_state_reg; // Default: stay in current state
    slave_2_arbitr_next = slave_2_arbitr_reg; // Default: hold current value
    slave_2_current_master_ID_next = slave_2_current_master_ID_reg; // Default: hold current value
    slave_2_cmd_r_next = slave_2_cmd_r_reg; // Default: hold current value

    case(slave_2_state_reg)
        IDLE:begin
            if(slave_2_ask) begin
                if(slave_2_arbitr_req)
                    slave_2_arbitr_next = !slave_2_arbitr_reg;
                slave_2_current_master_ID_next = slave_2_master_sel;
                slave_2_cmd_r_next = slave_2_master_sel ? master_2_cmd : master_1_cmd;
                slave_2_state_next = SET;
            end
        end
        SET:begin
            if(!slave_2_ack_q_reg && slave_2_ack) begin
                slave_2_state_next = ACK;
            end
            else if(!slave_2_ask) begin // Transaction aborted, or master deasserted req
                slave_2_state_next = IDLE;
            end
        end
        ACK:begin
            slave_2_state_next = IDLE;
        end
    endcase
end

// --- Master ACK and RDATA combinational logic ---
always @(*) begin // Changed from always_comb to always @(*) for broader tool compatibility
    master_1_ack_comb = 1'b0; // Default to 0 (pulse)
    master_2_ack_comb = 1'b0; // Default to 0 (pulse)
    master_1_rdata_comb = 32'b0; // Default to 0
    master_2_rdata_comb = 32'b0; // Default to 0

    // Master 1 ACK logic
    if (slave_1_state_reg == SET && !slave_1_ack_q_reg && slave_1_ack && !slave_1_current_master_ID_reg) begin
        master_1_ack_comb = 1'b1;
    end
    if (slave_2_state_reg == SET && !slave_2_ack_q_reg && slave_2_ack && !slave_2_current_master_ID_reg) begin
        // By design, a master targets only one slave based on address, so these conditions are mutually exclusive.
        // If not, a logical OR would be needed: master_1_ack_comb = master_1_ack_comb | 1'b1;
        master_1_ack_comb = 1'b1;
    end

    // Master 2 ACK logic
    if (slave_1_state_reg == SET && !slave_1_ack_q_reg && slave_1_ack && slave_1_current_master_ID_reg) begin
        master_2_ack_comb = 1'b1;
    end
    if (slave_2_state_reg == SET && !slave_2_ack_q_reg && slave_2_ack && slave_2_current_master_ID_reg) begin
        master_2_ack_comb = 1'b1;
    end // Fixed '}' to 'end'

    // Master 1 RDATA logic
    if (slave_1_state_reg == ACK && !slave_1_cmd_r_reg && !slave_1_current_master_ID_reg) begin
        master_1_rdata_comb = slave_1_rdata;
    end
    if (slave_2_state_reg == ACK && !slave_2_cmd_r_reg && !slave_2_current_master_ID_reg) begin
        // By design, a master targets only one slave for read. Prioritizing one source is implicit.
        // If a master can read from both, a priority encoder (e.g., if-else if) would be appropriate.
        // Here, it's effectively an overwrite if both conditions somehow were true (which they shouldn't be).
        master_1_rdata_comb = slave_2_rdata;
    end

    // Master 2 RDATA logic
    if (slave_1_state_reg == ACK && !slave_1_cmd_r_reg && slave_1_current_master_ID_reg) begin
        master_2_rdata_comb = slave_1_rdata;
    end // Fixed '}' to 'end'
    if (slave_2_state_reg == ACK && !slave_2_cmd_r_reg && slave_2_current_master_ID_reg) begin
        master_2_rdata_comb = slave_2_rdata;
    end
end


// --- Sequential logic (registered updates) ---
always @(posedge PCLK or negedge PRESETN) begin // Changed from always_ff to always @(...) for broader tool compatibility
    if(!PRESETN) begin
        // Reset all registered outputs and FSM elements
        master_1_ack <= 0;
        master_2_ack <= 0;
        master_1_rdata <= 0;
        master_2_rdata <= 0;

        slave_1_ack_q_reg <= 0;
        slave_2_ack_q_reg <= 0;
        slave_1_arbitr_reg <= 0;
        slave_2_arbitr_reg <= 0;
        slave_1_current_master_ID_reg <= 0;
        slave_2_current_master_ID_reg <= 0;
        slave_1_cmd_r_reg <= 0;
        slave_2_cmd_r_reg <= 0;
        slave_1_state_reg <= IDLE;
        slave_2_state_reg <= IDLE;
    end
    else begin
        // Update all registered FSM elements from their combinational 'next' values
        slave_1_state_reg <= slave_1_state_next;
        slave_2_state_reg <= slave_2_state_next;
        slave_1_arbitr_reg <= slave_1_arbitr_next;
        slave_2_arbitr_reg <= slave_2_arbitr_next;
        slave_1_current_master_ID_reg <= slave_1_current_master_ID_next;
        slave_2_current_master_ID_reg <= slave_2_current_master_ID_next;
        slave_1_cmd_r_reg <= slave_1_cmd_r_next;
        slave_2_cmd_r_reg <= slave_2_cmd_r_next;

        // Update ACK pipeline registers
        slave_1_ack_q_reg <= slave_1_ack;
        slave_2_ack_q_reg <= slave_2_ack;

        // Update master outputs from combinational 'comb' values
        master_1_ack <= master_1_ack_comb;
        master_2_ack <= master_2_ack_comb;
        master_1_rdata <= master_1_rdata_comb;
        master_2_rdata <= master_2_rdata_comb;
    end
end

endmodule
