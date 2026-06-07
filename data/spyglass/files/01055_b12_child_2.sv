module b12(clock, reset, start, k, nloss, nl, speaker);

input clock;
input reset;
input start;
input [3:0] k;
output reg nloss;
output reg [3:0] nl;
output reg speaker;


reg [4:0] gamma;
reg [4:0] next_gamma;

parameter RED = 0;
parameter GREEN = 1;
parameter YELLOW = 2;
parameter BLUE = 3;

parameter LED_ON = 1'b1;
parameter LED_OFF = 1'b0;

parameter PLAY_ON = 1'b1;
parameter PLAY_OFF = 1'b0;

parameter KEY_ON = 1'b1;

parameter NUM_KEY = 4;
parameter COD_COLOR = 2;
parameter COD_SOUND = 3;

// Fixed W263: Case label width for 'sound' selector (4-bit)
parameter S_WIN = 4'd4; // 2 ** COD_COLOR = 4
parameter S_LOSS = 4'd5; // S_WIN + 1 = 5

parameter SIZE_ADDRESS = 5;
parameter SIZE_MEM = 2 ** SIZE_ADDRESS;

parameter COUNT_KEY = 33;
parameter COUNT_SEQ = 33;
parameter DEC_SEQ = 1;
parameter COUNT_FIN = 8;

parameter ERROR_TONE = 1;
parameter RED_TONE = 2;
parameter GREEN_TONE = 3;
parameter YELLOW_TONE = 4;
parameter BLUE_TONE = 5;
parameter WIN_TONE = 6;

// Fixed W263: Case label width for 'gamma' selector (5-bit)
parameter G0 = 5'd0;
parameter G1 = 5'd1;
parameter G2 = 5'd2;
parameter G3 = 5'd3;
parameter G4 = 5'd4;
parameter G5 = 5'd5;
parameter G6 = 5'd6;
parameter G7 = 5'd7;
parameter G8 = 5'd8;
parameter G9 = 5'd9;
parameter G10 = 5'd10;
parameter G10a = 5'd11;
parameter G11 = 5'd12;
parameter G12 = 5'd13;
parameter Ea = 5'd14;
parameter E0 = 5'd15;
parameter E1 = 5'd16;
parameter K0 = 5'd17;
parameter K1 = 5'd18;
parameter K2 = 5'd19;
parameter K3 = 5'd20;
parameter K4 = 5'd21;
parameter K5 = 5'd22;
parameter K6 = 5'd23;
parameter W0 = 5'd24;
parameter W1 = 5'd25;

reg wr;
reg [31:0] address;
reg [3:0] data_in;
reg [3:0] data_out;
reg [3:0] num;
reg [3:0] sound;
reg play;
reg s;
reg [3:0] counterP4;
reg [(2**COD_COLOR)-1:0] count_P3;
reg [3:0] memory [0:31];
// Fixed W480: Loop index 'mar' changed to integer
integer mar;

reg [2:0] ind;
reg [31:0] scan;
reg [31:0] max;
reg [5:0] timebase;
reg [5:0] countP1;

// Add next-state/output registers for P1 FSM
reg next_nloss;
reg [3:0] next_nl;
reg next_play;
reg next_wr;
reg [31:0] next_scan;
reg [31:0] next_max;
reg [2:0] next_ind;
reg [5:0] next_timebase;
reg [3:0] next_sound;
reg [31:0] next_address;
reg [3:0] next_data_in;
reg [5:0] next_countP1;

// Fixed W263: Case label width for 'sound' selector (4-bit)
parameter zero = 4'd0;
parameter one = 4'd1;
parameter two = 4'd2;
parameter three = 4'd3;
always @(posedge clock, posedge reset) begin //: P4
   
   
    if((reset == 1'b1)) begin
      s <= 1'b0; // Fixed W336: Blocking assignment changed to non-blocking
      speaker <= 1'b0;
      counterP4 <= 0;
      end else begin
      if(play == 1'b1) begin
         case(sound)
            zero : begin
               if(counterP4 > RED_TONE) begin
                  s <=  ~s; // Fixed W336: Blocking assignment changed to non-blocking
                  speaker <= s;
                  counterP4 <= 0;
               end
               else begin
                  counterP4 <= counterP4 + 1;
               end
            end
            one : begin
               if(counterP4 > GREEN_TONE) begin
                  s <=  ~s; // Fixed W336: Blocking assignment changed to non-blocking
                  speaker <= s;
                  counterP4 <= 0;
               end
               else begin
                  counterP4 <= counterP4 + 1;
               end
            end
            two : begin
               if(counterP4 > YELLOW_TONE) begin
                  s <=  ~s; // Fixed W336: Blocking assignment changed to non-blocking
                  speaker <= s;
                  counterP4 <= 0;
               end
               else begin
                  counterP4 <= counterP4 + 1;
               end
            end
            three : begin
               if(counterP4 > BLUE_TONE) begin
                  s <=  ~s; // Fixed W336: Blocking assignment changed to non-blocking
                  speaker <= s;
                  counterP4 <= 0;
               end
               else begin
                  counterP4 <= counterP4 + 1;
               end
            end
            S_WIN : begin
               if(counterP4 > WIN_TONE) begin
                  s <=  ~s; // Fixed W336: Blocking assignment changed to non-blocking
                  speaker <= s;
                  counterP4 <= 0;
               end
               else begin
                  counterP4 <= counterP4 + 1;
               end
            end
            S_LOSS : begin
               if(counterP4 > ERROR_TONE) begin
                  s <=  ~s; // Fixed W336: Blocking assignment changed to non-blocking
                  speaker <= s;
                  counterP4 <= 0;
               end
               else begin
                  counterP4 <= counterP4 + 1;
               end
            end
            default : begin
               counterP4 <= 0;
            end
         endcase
      end
      else begin
         counterP4 <= 0;
         speaker <= 1'b0;
      end
   end
end

always @(posedge clock, posedge reset) begin// : P3
   
   
    if((reset == 1'b1)) begin
      count_P3 <= 0;
      num <= 0;
      end else begin
      count_P3 <= (count_P3 + 1) % (2 ** COD_COLOR); // Fixed SYNTH_77, W336, W505: Blocking assignment changed to non-blocking
      // count := count + 1;
      // removed(!)fs030699
      num <= count_P3;
   end
end

always @(posedge clock, posedge reset) begin //: P2
   
   
    if(reset == 1'b1) begin
      data_out <= 0;
      for (mar=0; mar <= SIZE_MEM - 1; mar = mar + 1) begin
         memory[mar] <= 0;
      end
      end else begin
      data_out <= memory[address];
      if(wr == 1'b1) begin
         memory[address] <= data_in;
      end
   end
end

// Combinatorial logic for P1 FSM next states and next outputs
always @* begin
    // Default assignments to avoid latches. Generally, maintain current state/output values.
    next_gamma = gamma;
    next_countP1 = countP1;
    next_nloss = nloss;
    next_nl = nl;
    next_play = play;
    next_wr = wr;
    next_scan = scan;
    next_max = max;
    next_ind = ind;
    next_timebase = timebase;
    next_sound = sound;
    next_address = address;
    next_data_in = data_in;

    if(start == 1'b1) begin
        next_nloss = LED_OFF;
        next_nl = {4{LED_OFF}};
        next_play = PLAY_OFF;
        next_wr = 1'b0;
        next_max = 0;
        next_timebase = COUNT_SEQ;
        next_gamma = G2;
        next_countP1 = COUNT_SEQ;
    end else begin
        case(gamma)
            G0 : begin
                next_gamma = G0;
            end
            G1 : begin // This state is effectively skipped by `start` logic
                next_nloss = LED_OFF;
                next_nl = {4{LED_OFF}};
                next_play = PLAY_OFF;
                next_wr = 1'b0;
                next_max = 0;
                next_timebase = COUNT_SEQ;
                next_gamma = G2;
                next_countP1 = COUNT_SEQ; 
            end
            G2 : begin
                next_scan = 0;
                next_wr = 1'b1;
                next_address = max;
                next_data_in = num;
                next_gamma = G3;
            end
            G3 : begin
                next_wr = 1'b0;
                next_address = scan;
                next_gamma = G4;
            end
            G4 : begin
                next_gamma = G5;
            end
            G5 : begin
                next_nl = nl;
                next_nl[data_out] = LED_ON;
                next_countP1 = timebase;
                next_play = PLAY_ON;
                next_sound = data_out;
                next_gamma = G6;
            end
            G6 : begin
                if(countP1 == 0) begin
                    next_nl = {4{LED_OFF}};
                    next_play = PLAY_OFF;
                    next_countP1 = timebase;
                    next_gamma = G7;
                end
                else begin
                    next_countP1 = countP1 - 1;
                    next_gamma = G6;
                end
            end
            G7 : begin
                if(countP1 == 0) begin
                    if(scan != max) begin
                        next_scan = scan + 1;
                        next_gamma = G3;
                    end
                    else begin
                        next_scan = 0;
                        next_gamma = G8;
                    end
                end
                else begin
                    next_countP1 = countP1 - 1;
                    next_gamma = G7;
                end
            end
            G8 : begin
                next_countP1 = COUNT_KEY;
                next_address = scan;
                next_gamma = G9;
            end
            G9 : begin
                next_gamma = G10;
            end
            G10 : begin
                if(countP1 == 0) begin
                    next_nloss = LED_ON;
                    next_max = 0;
                    next_gamma = K0;
                end
                else begin
                    next_countP1 = countP1 - 1; // Default decrement
                    if(k[0] == KEY_ON) begin
                        next_ind = 0;
                        next_sound = 0;
                        next_play = PLAY_ON;
                        next_countP1 = timebase; // Overrides default decrement if key is pressed
                        if((data_out == 0)) begin
                            next_gamma = G10a;
                        end
                        else begin
                            next_nloss = LED_ON;
                            next_gamma = Ea;
                        end
                    end
                    else if(k[1] == KEY_ON) begin
                        next_ind = 1;
                        next_sound = 1;
                        next_play = PLAY_ON;
                        next_countP1 = timebase;
                        if((data_out == 1)) begin
                            next_gamma = G10a;
                        end
                        else begin
                            next_nloss = LED_ON;
                            next_gamma = Ea;
                        end
                    end
                    else if(k[2] == KEY_ON) begin
                        next_ind = 2;
                        next_sound = 2;
                        next_play = PLAY_ON;
                        next_countP1 = timebase;
                        if((data_out == 2)) begin
                            next_gamma = G10a;
                        end
                        else begin
                            next_nloss = LED_ON;
                            next_gamma = Ea;
                        end
                    end
                    else if(k[3] == KEY_ON) begin
                        next_ind = 3;
                        next_sound = 3;
                        next_play = PLAY_ON;
                        next_countP1 = timebase;
                        if((data_out == 3)) begin
                            next_gamma = G10a;
                        end
                        else begin
                            next_nloss = LED_ON;
                            next_gamma = Ea;
                        end
                    end
                    else begin
                        next_gamma = G10; // No key pressed, continue decrementing countP1
                    end
                end
            end
            G10a : begin
                next_nl = nl;
                next_nl[ind] = LED_ON;
                next_gamma = G11;
            end
            G11 : begin
                if(countP1 == 0) begin
                    next_nl = {4{LED_OFF}};
                    next_play = PLAY_OFF;
                    next_countP1 = timebase;
                    next_gamma = G12;
                end
                else begin
                    next_countP1 = countP1 - 1;
                    next_gamma = G11;
                end
            end
            G12 : begin
                if(countP1 == 0) begin
                    if(scan != max) begin
                        next_scan = scan + 1;
                        next_gamma = G8;
                    end
                    else if(max != (SIZE_MEM - 1)) begin
                        next_max = max + 1;
                        next_timebase = timebase - DEC_SEQ;
                        next_gamma = G2;
                    end
                    else begin
                        next_play = PLAY_ON;
                        next_sound = S_WIN;
                        next_countP1 = COUNT_FIN;
                        next_gamma = W0;
                    end
                end
                else begin
                    next_countP1 = countP1 - 1;
                    next_gamma = G12;
                end
            end
            Ea : begin
                next_nl = nl;
                next_nl[ind] = LED_ON;
                next_gamma = E0;
            end
            E0 : begin
                if(countP1 == 0) begin
                    next_nl = {4{LED_OFF}};
                    next_play = PLAY_OFF;
                    next_countP1 = timebase;
                    next_gamma = E1;
                end
                else begin
                    next_countP1 = countP1 - 1;
                    next_gamma = E0;
                end
            end
            E1 : begin
                if(countP1 == 0) begin
                    next_max = 0;
                    next_gamma = K0;
                end
                else begin
                    next_countP1 = countP1 - 1;
                    next_gamma = E1;
                end
            end
            K0 : begin
                next_address = max;
                next_gamma = K1;
            end
            K1 : begin
                next_gamma = K2;
            end
            K2 : begin
                next_nl = nl;
                next_nl[data_out] = LED_ON;
                next_play = PLAY_ON;
                next_sound = data_out;
                next_countP1 = timebase;
                next_gamma = K3;
            end
            K3 : begin
                if(countP1 == 0) begin
                    next_nl = {4{LED_OFF}};
                    next_play = PLAY_OFF;
                    next_countP1 = timebase;
                    next_gamma = K4;
                end
                else begin
                    next_countP1 = countP1 - 1;
                    next_gamma = K3;
                end
            end
            K4 : begin
                if(countP1 == 0) begin
                    if(max != scan) begin
                        next_max = max + 1;
                        next_gamma = K0;
                    end
                    else begin
                        next_nl = nl;
                        next_nl[data_out] = LED_ON;
                        next_play = PLAY_ON;
                        next_sound = S_LOSS;
                        next_countP1 = COUNT_FIN;
                        next_gamma = K5;
                    end
                end
                else begin
                    next_countP1 = countP1 - 1;
                    next_gamma = K4;
                end
            end
            K5 : begin
                if(countP1 == 0) begin
                    next_nl = {4{LED_OFF}};
                    next_play = PLAY_OFF;
                    next_countP1 = COUNT_FIN;
                    next_gamma = K6;
                end
                else begin
                    next_countP1 = countP1 - 1;
                    next_gamma = K5;
                end
            end
            K6 : begin
                if(countP1 == 0) begin
                    next_nl = nl;
                    next_nl[data_out] = LED_ON;
                    next_play = PLAY_ON;
                    next_sound = S_LOSS;
                    next_countP1 = COUNT_FIN;
                    next_gamma = K5;
                end
                else begin
                    next_countP1 = countP1 - 1;
                    next_gamma = K6;
                end
            end
            W0 : begin
                if(countP1 == 0) begin
                    next_nl = {4{LED_ON}};
                    next_play = PLAY_OFF;
                    next_countP1 = COUNT_FIN;
                    next_gamma = W1;
                end
                else begin
                    next_countP1 = countP1 - 1;
                    next_gamma = W0;
                end
            end
            W1 : begin
                if(countP1 == 0) begin
                    next_nl = {4{LED_OFF}};
                    next_play = PLAY_ON;
                    next_sound = S_WIN;
                    next_countP1 = COUNT_FIN;
                    next_gamma = W0;
                end
                else begin
                    next_countP1 = countP1 - 1;
                    next_gamma = W1;
                end
            end
        endcase
    end
end

always @(posedge clock, posedge reset) begin //: P1 sequential updates
    if((reset == 1'b1)) begin
        nloss <= LED_OFF;
        nl <= {4{LED_OFF}};
        play <= PLAY_OFF;
        wr <= 1'b0;
        scan <= 0;
        max <= 0;
        ind <= 0;
        timebase <= 0;
        countP1 <= 0;
        sound <= 0;
        address <= 0;
        data_in <= 0;
        gamma <= G0;
    end else begin
        gamma <= next_gamma;
        countP1 <= next_countP1;
        nloss <= next_nloss;
        nl <= next_nl;
        play <= next_play;
        wr <= next_wr;
        scan <= next_scan;
        max <= next_max;
        ind <= next_ind;
        timebase <= next_timebase;
        sound <= next_sound;
        address <= next_address;
        data_in <= next_data_in;
    end
end


endmodule
