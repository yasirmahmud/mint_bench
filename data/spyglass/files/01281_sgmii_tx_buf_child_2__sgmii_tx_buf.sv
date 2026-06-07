module sgmii_tx_buf
(
    input clk_125mhz,
    input rst,

    input tbi_tx_clk,

    input sgmii_autoneg_start,
    input sgmii_autoneg_ack,
    input sgmii_autoneg_idle,
    input sgmii_autoneg_done,
    
    input [7:0] gmii_txd,
    input gmii_tx_en,
    input gmii_tx_err,
    
    output [7:0] tx_byte,
    output tx_is_k
);
    parameter LINK_TIMER = 16'd40000;
    
    //
    // TX buffer write
    //
    
    wire [8:0] fifo_in = {gmii_tx_err, gmii_txd};
    wire fifo_push = gmii_tx_en && sgmii_autoneg_done;
    wire [8:0] fifo_out;
    wire fifo_pop;
    wire fifo_empty;
    
    sgmii_fifo sgmii_fifo
    (
        .rst_in(rst),
        .clk_in(clk_125mhz),
        .clk_out(tbi_tx_clk),

        .fifo_in(fifo_in),
        .push(fifo_push),
        .full(),

        .fifo_out(fifo_out),
        .pop(fifo_pop),
        .empty(fifo_empty)
    );

    //
    // Autogen sequence
    //
    
    reg [4:0] autoneg_state;
    reg [4:0] autoneg_state_next;
    reg [15:0] autoneg_cnt;
    reg [15:0] autoneg_cnt_next;
    reg [8:0] autoneg_out;
    reg [8:0] autoneg_out_next;
    reg autoneg_done;
    reg autoneg_done_next;
    
    // Sequential logic for autoneg_state FSM
    always @ (posedge tbi_tx_clk or posedge rst) begin
        if (rst) begin
            autoneg_state <= 5'd0;
            autoneg_cnt <= 16'd0;
            autoneg_out <= 9'd0;
            autoneg_done <= 1'b0;
        end else begin
            autoneg_state <= autoneg_state_next;
            autoneg_cnt <= autoneg_cnt_next;
            autoneg_out <= autoneg_out_next;
            autoneg_done <= autoneg_done_next;
        end
    end

    // Combinational logic for autoneg_state FSM
    always @* begin // Changed from always_comb
        // Default assignments to prevent latches
        autoneg_state_next = autoneg_state; // Default to self-loop
        autoneg_cnt_next = autoneg_cnt;
        autoneg_out_next = autoneg_out; // Maintain previous output unless explicitly changed
        autoneg_done_next = autoneg_done;

        case (autoneg_state)
            // LinkTimer x CFG1/2 of zero
            5'd0: begin
                autoneg_done_next = 1'b0;
                if (!sgmii_autoneg_start) autoneg_cnt_next = 16'd0;
                autoneg_state_next = 5'd1;
                autoneg_out_next = {1'b1, 8'hBC};
            end
            5'd1: begin
                autoneg_state_next = 5'd2;
                autoneg_out_next = {1'b0, 8'hB5};
            end
            5'd2: begin
                autoneg_state_next = 5'd3;
                autoneg_out_next = {1'b0, 8'h00};
            end
            5'd3: begin
                autoneg_state_next = 5'd4;
                autoneg_out_next = {1'b0, 8'h00};
            end
            5'd4: begin
                autoneg_state_next = 5'd5;
                autoneg_out_next = {1'b1, 8'hBC};
            end
            5'd5: begin
                autoneg_state_next = 5'd6;
                autoneg_out_next = {1'b0, 8'h42};
            end
            5'd6: begin
                autoneg_state_next = 5'd7;
                autoneg_out_next = {1'b0, 8'h00};
                autoneg_cnt_next = autoneg_cnt + 16'd1;
            end
            5'd7: begin
                autoneg_state_next = (autoneg_cnt == LINK_TIMER) ? 5'd8 : 5'd0;
                autoneg_out_next = {1'b0, 8'h00};
            end

            // Send non-ACK with CONFIG_REG
            5'd8: begin
                autoneg_state_next = 5'd9;
                autoneg_out_next = {1'b1, 8'hBC};
            end
            5'd9: begin
                autoneg_state_next = 5'd10;
                autoneg_out_next = {1'b0, 8'hB5};
            end
            5'd10: begin
                autoneg_state_next = 5'd11;
                autoneg_out_next = {1'b0, 8'h01};
            end
            5'd11: begin
                autoneg_state_next = (!sgmii_autoneg_start) ? 5'd0 : 5'd12;
                autoneg_out_next = {1'b0, 8'h00};
            end
            5'd12: begin
                autoneg_state_next = 5'd13;
                autoneg_out_next = {1'b1, 8'hBC};
            end
            5'd13: begin
                autoneg_state_next = 5'd14;
                autoneg_out_next = {1'b0, 8'h42};
            end
            5'd14: begin
                autoneg_state_next = 5'd15;
                autoneg_out_next = {1'b0, 8'h01};
            end
            5'd15: begin
                autoneg_state_next = (sgmii_autoneg_ack) ? 5'd16 : 5'd8;
                autoneg_out_next = {1'b0, 8'h00};
            end
  
            // Send ACK with CONFIG_REG
            5'd16: begin
                autoneg_state_next = 5'd17;
                autoneg_out_next = {1'b1, 8'hBC};
            end
            5'd17: begin
                autoneg_state_next = 5'd18;
                autoneg_out_next = {1'b0, 8'hB5};
            end
            5'd18: begin
                autoneg_state_next = 5'd19;
                autoneg_out_next = {1'b0, 8'h01};
            end
            5'd19: begin
                autoneg_state_next = (!sgmii_autoneg_start) ? 5'd0 : 5'd20;
                autoneg_out_next = {1'b0, 8'h40};
            end
            5'd20: begin
                autoneg_state_next = 5'd21;
                autoneg_out_next = {1'b1, 8'hBC};
            end
            5'd21: begin
                autoneg_state_next = 5'd22;
                autoneg_out_next = {1'b0, 8'h42};
            end
            5'd22: begin
                autoneg_state_next = 5'd23;
                autoneg_out_next = {1'b0, 8'h01};
                autoneg_cnt_next = autoneg_cnt + 12'd1; // Original uses 12'd1, preserving functional behavior
            end
            5'd23: begin
                autoneg_state_next = (sgmii_autoneg_idle) ? 5'd24 : 5'd16;
                autoneg_out_next = {1'b0, 8'h40};
            end
 
             // Send IDLE
            5'd24: begin
                autoneg_state_next = 5'd25;
                autoneg_out_next = {1'b1, 8'hBC};
            end
            5'd25: begin
                autoneg_state_next = (!sgmii_autoneg_start) ? 5'd0 : 5'd26;
                autoneg_out_next = {1'b0, 8'hC5};
            end
            5'd26: begin
                autoneg_state_next = 5'd27;
                autoneg_out_next = {1'b1, 8'hBC};
            end
            5'd27: begin
                autoneg_state_next = 5'd28;
                autoneg_out_next = {1'b0, 8'h50};
            end
            5'd28: begin
                autoneg_done_next = 1'b1;
                // Original logic implicitly transitions to default (5'd0) if condition is false.
                // If condition is true, it also transitions to 5'd0.
                if (!sgmii_autoneg_start || !sgmii_autoneg_ack || !sgmii_autoneg_ack) // Preserving original typo
                    autoneg_state_next = 5'd0;
                else
                    autoneg_state_next = 5'd0; // Based on default transition of original code
            end
            
            default: autoneg_state_next = 5'd0; // Catch-all for undefined states
        endcase
    end


    //
    // Encapsulation
    //
    
    reg [2:0] encap_state;
    reg [2:0] encap_state_next;
    reg [8:0] encap_out;
    reg [8:0] encap_out_next;

    assign fifo_pop = (encap_state == 3'd5);
    
    // Sequential logic for encap_state FSM
    always @ (posedge tbi_tx_clk or posedge rst) begin
        if (rst) begin
            encap_state <= 3'd0;
            encap_out <= 9'd0;
        end else begin
            encap_state <= encap_state_next;
            encap_out <= encap_out_next;
        end
    end

    // Combinational logic for encap_state FSM
    always @* begin // Changed from always_comb
        // Default assignments for next state and output
        // The original default for states not explicitly handled in case was encap_state + 3'd1
        encap_state_next = encap_state + 3'd1; 
        encap_out_next = encap_out; // Maintain current output unless changed

        if (autoneg_state == 5'd27) begin
            encap_state_next = 3'd0;
        end else begin
            case (encap_state)
                3'd3: encap_state_next = (!fifo_empty) ? 3'd4 : 3'd0;
                3'd5: encap_state_next = (fifo_empty) ? 3'd6 : 3'd5;
                3'd6: encap_state_next = 3'd0;
                // States 0, 1, 2, 4 implicitly follow encap_state + 3'd1
                default: encap_state_next = encap_state + 3'd1; // Explicit default for clarity, or can be removed if handled by initial assignment.
            endcase
        end
            
        // encap_out combinational logic
        case (encap_state)
            3'd0: encap_out_next = {1'b1, 8'hBC};
            3'd1: encap_out_next = {1'b0, 8'hC5};
            3'd2: encap_out_next = {1'b1, 8'hBC};
            3'd3: encap_out_next = {1'b0, 8'h50};
            
            3'd4: encap_out_next = {1'b1, 8'hFB};
            3'd5: encap_out_next = (fifo_empty) ? {1'b1, 8'hFD} :
                                   (fifo_out[8]) ? {1'b1, 8'hFE} : {1'b0, fifo_out[7:0]};
            3'd6: encap_out_next = {1'b1, 8'hF7};
            default: encap_out_next = 9'd0;
        endcase
    end

    //
    // TBI out
    //
    
    assign tx_byte = (autoneg_done) ? encap_out[7:0] : autoneg_out[7:0];
    assign tx_is_k = (autoneg_done) ? encap_out[8] : autoneg_out[8];
    
endmodule
