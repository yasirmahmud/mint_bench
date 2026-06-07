module vga_top  (   input wire          i_clk25m,
        input wire          i_rstn_clk25m,
        
        // VGA driver signals
        output wire [9:0]   o_VGA_x,
        output wire [9:0]   o_VGA_y, 
        output wire         o_VGA_vsync,
        output wire         o_VGA_hsync, 
        output wire         o_VGA_video,
        output wire [3:0]   o_VGA_red,
        output wire [3:0]   o_VGA_green,
        output wire [3:0]   o_VGA_blue, 
        
        // VGA read from BRAM 
        input  wire [11:0] i_pix_data, 
        output reg  [18:0] o_pix_addr
    );

    
    vga_driver
    #(  .hDisp(640), 
        .hFp(16), 
        .hPulse(96), 
        .hBp(48), 
        .vDisp(480), 
        .vFp(10), 
        .vPulse(2),
        .vBp(33)                )
    u_vga_driver_inst; // Renamed instance from vga_timing_signals to avoid ELAB_3519 violation
    (
        .i_clk(i_clk25m         ),
        .i_rstn(i_rstn_clk25m   ),
        
        // VGA timing signals
        .o_x_counter(o_VGA_x    ),
        .o_y_counter(o_VGA_y    ),
        .o_video(o_VGA_video    ), 
        .o_vsync(o_VGA_vsync    ),
        .o_hsync(o_VGA_hsync    )
    );
    
    reg [3:0]   r_VGA_R;
    reg [3:0]   r_VGA_G; 
    reg [3:0]   r_VGA_B;
    
    // FSM state registers and next-state logic signals
    reg [1:0]   r_SM_state;       // Current state register
    reg [1:0]   r_SM_next_state;  // Combinational next state logic
    reg [18:0]  r_pix_addr_comb;  // Combinational next pixel address logic

    localparam [1:0]    WAIT_1  = 0,
                        WAIT_2  = 'd1,  
                        READ    = 'd2;
                          
    // Sequential part of FSM (resolves STARC05-2.11.3.1 violation)
    always @(posedge i_clk25m or negedge i_rstn_clk25m) begin
        if(!i_rstn_clk25m) begin
            r_SM_state <= WAIT_1;
            o_pix_addr <= 0; // Reset pixel address
        end else begin
            r_SM_state <= r_SM_next_state; // Update state register
            o_pix_addr <= r_pix_addr_comb; // Update pixel address register
        end
    end

    // Combinational part of FSM (resolves STARC05-2.11.3.1 violation)
    always @(*) begin
        // Default assignments to avoid latches
        r_SM_next_state = r_SM_state; // Default to staying in current state
        r_pix_addr_comb = o_pix_addr; // Default to holding current address

        case(r_SM_state)
            WAIT_1: begin
                if (o_VGA_x == 640 && o_VGA_y == 480) begin
                    r_SM_next_state = WAIT_2;
                end
                // else r_SM_next_state remains WAIT_1 (by default assignment)
            end
            WAIT_2: begin
                if (o_VGA_x == 640 && o_VGA_y == 480) begin
                    r_SM_next_state = READ;
                end
                // else r_SM_next_state remains WAIT_2 (by default assignment)
            end
            READ: begin
                // r_SM_next_state remains READ (by default assignment)
                // Pixel address logic
                if((o_VGA_y < 480) && (o_VGA_x < 639)) begin
                    r_pix_addr_comb = (o_pix_addr == 307199) ? 0 : o_pix_addr + 1'b1;
                end else begin           
                    // Next clock is active video 
                    if( (o_VGA_x == 799) && ( (o_VGA_y == 524) || (o_VGA_y < 480) ) ) begin
                        r_pix_addr_comb = o_pix_addr + 1'b1;
                    end
                    // Next clock not active video 
                    else if(o_VGA_y >= 480) begin
                        r_pix_addr_comb = 0;
                    end
                    // else r_pix_addr_comb remains o_pix_addr (by default assignment)
                end
            end 
            default: begin // Ensure all possible states are handled (for synthesizability)
                r_SM_next_state = WAIT_1;
                r_pix_addr_comb = 0;
            end
        endcase
    end
    
    // Valid Video selects between a black RGB Pixel and BRAM pixel data 
    always @(*)
        begin
            if(o_VGA_video)
                begin
                    r_VGA_R = i_pix_data[11:8]; 
                    r_VGA_G = i_pix_data[7:4];
                    r_VGA_B = i_pix_data[3:0];
                end
            else begin
                    r_VGA_R = 0; 
                    r_VGA_G = 0;
                    r_VGA_B = 0;
            end
        end 
    
    assign o_VGA_red    = r_VGA_R;
    assign o_VGA_green  = r_VGA_G;
    assign o_VGA_blue   = r_VGA_B;
    
endmodule
