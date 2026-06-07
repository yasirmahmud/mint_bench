module b08(CLOCK, RESET, START, I, O);

input CLOCK;
input RESET;
input START;
input [7:0] I;

output reg [3:0] O;

// State parameters, explicitly widened to match STATO [2:0]
parameter [2:0] start_st = 3'd0;
parameter [2:0] init = 3'd1;
parameter [2:0] loop_st = 3'd2;
parameter [2:0] the_end = 3'd3;

reg [7:0] IN_R;
reg [3:0] OUT_R;
reg [7:0] MAR;
reg [2:0] STATO;

// Intermediate combinational signals declared as wires
wire [7:0] ROM_1;
wire [7:0] ROM_2;
wire [3:0] ROM_OR;

// Synthesizable ROM definition using a function
function [19:0] get_rom_entry;
    input [2:0] addr; // ROM address is 0-7, so 3 bits
    begin
        case(addr) // Explicitly cover all 8 ROM entries
            3'd0: get_rom_entry = 20'b01111111100101111010;
            3'd1: get_rom_entry = 20'b00111001110101100010;
            3'd2: get_rom_entry = 20'b10101000111111111111;
            3'd3: get_rom_entry = 20'b11111111011010111010;
            3'd4: get_rom_entry = 20'b11111111111101101110;
            3'd5: get_rom_entry = 20'b11111111101110101000;
            3'd6: get_rom_entry = 20'b11001010011101011011;
            3'd7: get_rom_entry = 20'b00101111111111110100;
            default: get_rom_entry = 20'b0; // Default for robustness, although MAR[2:0] is expected to be 0-7
        endcase
    end
endfunction

// Combinational logic to extract segments from the ROM entry
wire [19:0] current_rom_data = get_rom_entry(MAR[2:0]); // MAR[2:0] used as ROM address
assign ROM_1 = current_rom_data[19:12];
assign ROM_2 = current_rom_data[11:4];
assign ROM_OR = current_rom_data[3:0];

always @(posedge CLOCK, posedge RESET) begin
    if(RESET == 1'b1) begin
        STATO <= start_st;
        MAR <= 8'b0;
        IN_R <= 8'b0;
        OUT_R <= 4'b0;
        O <= 4'b0;
    end else begin
        case(STATO)
            start_st : begin
                if(START == 1'b1) begin
                    STATO <= init;
                end
            end
            init : begin
                IN_R <= I;
                OUT_R <= 4'b0;
                MAR <= 8'b0; // Initialize MAR here
                STATO <= loop_st;
            end
            loop_st : begin
                // ROM_1, ROM_2, ROM_OR are wires and change combinatorially with MAR and IN_R
                // No blocking assignments needed here
                if(((ROM_2 &  ~IN_R) | (ROM_1 & IN_R) | (ROM_2 & ROM_1)) == 8'b11111111) begin
                    OUT_R <= OUT_R | ROM_OR; // Non-blocking assignment
                end
                STATO <= the_end;
            end
            the_end : begin
                if(MAR != 7) begin // If not all ROM entries processed
                    MAR <= MAR + 1;
                    STATO <= loop_st;
                end
                else if(START == 1'b0) begin // All ROM entries processed and START is low
                    O <= OUT_R;
                    STATO <= start_st;
                end
            end
        endcase
    end
end

endmodule
