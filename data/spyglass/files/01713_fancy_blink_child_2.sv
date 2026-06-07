module fancy_blink #(parameter LED_COUNT = 16, CLOCK_FREQ = 100000000, IPC_TOKEN_WIDTH = 64)
(
    // Clock and reset
    input clk, resetn,

    // The LEDs that we're going to drive
    output reg [LED_COUNT-1:0]  LED,

    // The interface to the FIFO that we're going to fetch IPC tokens from
    input[IPC_TOKEN_WIDTH-1:0] FIFO_DATA,
    output reg                  FIFO_RD_EN,
    input                       FIFO_EMPTY
);
    // genvar x; // Removed global genvar declaration

    // Get some convenient parameter names
    localparam TOKEN_WIDTH = IPC_TOKEN_WIDTH;
    localparam ISM_STATE_WIDTH = 8;

    // We're going to support 20 different blink-rate divisors
    localparam DIVISORS = 20;

    // These are precomputed timer-reload values for a given divisor
    wire[31:0] reload_precalc[1:DIVISORS];
    generate
        genvar x_reload; // Declared genvar locally within the generate block
        for (x_reload=1; x_reload<=DIVISORS; x_reload=x_reload+1) begin : reload_precalc_gen
            assign reload_precalc[x_reload] = CLOCK_FREQ/x_reload;
        end
    endgenerate

    // Flags that determine whether an LED is in a fixed on or off state
    reg[LED_COUNT-1:0] is_led_fixed, led_fixed_at;

    // Counters for each LED for when it's blinking
    reg[31:0] counter[0:LED_COUNT-1];
    
    // When the counter for a blinking LED reaches zero, it's reloaded from this array
    reg[31:0] reload[0:LED_COUNT-1];

    // The state of our "input state machine"    
    reg[ISM_STATE_WIDTH-1:0] ism_state;

    // The names of our state machine state
    localparam ism_IDLE        = 0;
    localparam ism_SYNTAX_ERR  = 10; // State 10 handles syntax errors
    localparam ism_RANGE_ERR   = 10; // State 10 handles range errors
    localparam ism_FLUSH_MSG   = 10; // State 10 flushes the message. Note: SYNTAX_ERR, RANGE_ERR, and FLUSH_MSG all map to state 10.
    localparam ism_FETCH_TOKEN = 20;

    // This will be true when the end-of-tokens has been reached for this message
    reg eom;

    // This is the token that is fetched by calling ism_FETCH_TOKEN
    reg[TOKEN_WIDTH-1:0] token;

    // Some handy shortcuts for determining what kind of token this is
    wire is_nul       = (token == 0);
    wire is_numeric   = token[TOKEN_WIDTH-1] == 1;
    wire is_alpha     = token[TOKEN_WIDTH-1] == 0;
    wire[63:0] number = token[63:0];

    // This is 0-based index of the LED we're processing a message for
    reg[3:0] led_index;

    // A call stack so we can have subroutines in our state machine
    reg[4*ISM_STATE_WIDTH-1:0] call_stack;
    
    // Bring some sanity to state machine programming: call, return, and goto!
    `define call(s)  call_stack<=(call_stack<<ISM_STATE_WIDTH)|(ism_state+1);ism_state<=s;
    `define icall(s) call_stack<=(call_stack<<ISM_STATE_WIDTH)|(ism_state);ism_state<=s;
    `define return   ism_state<=call_stack;call_stack<=(call_stack >> ISM_STATE_WIDTH);
    `define goto(s)  ism_state<=s

    //===============================================================================================
    // This state machine handles incoming IPC messages
    //===============================================================================================
    always @(posedge clk) begin
        
        // This should strobe high for 1 cycle
        FIFO_RD_EN <= 0;
        
        // If reset is asserted...
        if (resetn == 0) begin
            ism_state    <= 0;
            is_led_fixed <= -1;
            led_fixed_at <= 0;
        end

        // Otherwise, execute our state machine
        else begin // Added begin/end block to enclose the case statement
            case (ism_state)

            //------------------------------------------------------------------------------
            // We're in idle mode.  Clear the flag that says we've seen the end-of-message
            // marker, then wait for a token to arrive signifying a new incoming message
            //------------------------------------------------------------------------------
            0:  begin
                    eom <= 0;
                    `call(ism_FETCH_TOKEN);
                end
            //------------------------------------------------------------------------------

            //------------------------------------------------------------------------------
            // We're going to throw away the first token because it's the keyword "led".
            // Instead, go fetch the next token
            //------------------------------------------------------------------------------
            1:  begin
                    `call(ism_FETCH_TOKEN);
                end
            //------------------------------------------------------------------------------


            //------------------------------------------------------------------------------
            // Here we process the second token.  It should be "on", "off", or a valid LED
            // index
            //------------------------------------------------------------------------------

                // If the token is "on", turn on all of the LEDs, and finish
            2:  if (is_alpha && token == "on") begin
                    is_led_fixed <= -1;
                    led_fixed_at <= -1;
                    `goto(ism_FLUSH_MSG);
                end

                // If the token is "off", turn off all of the LEDs and finish
                else if (is_alpha && token == "off") begin
                    is_led_fixed <= -1;
                    led_fixed_at <= 0;
                    `goto(ism_FLUSH_MSG);                
                end

                // If the token isn't numeric, it's a syntax error
                else if (!is_numeric) begin // Added begin/end to resolve "Null statement" violation
                    `goto(ism_SYNTAX_ERR);
                end

                // If the numeric value isn't a valid LED number, it's a range error
                else if (number < 1 || number > LED_COUNT) begin // Added begin/end to resolve "Null statement" violation
                    `goto(ism_RANGE_ERR);
                end

                // If we get here, we have a valid LED number.  Store it and fetch
                // the next token
                else begin
                    led_index <= number - 1;
                    `call(ism_FETCH_TOKEN);
                end
            //------------------------------------------------------------------------------


            //------------------------------------------------------------------------------
            // Here we process the third token.  It should be "on", "off", or a valid
            // numeric divisor 
            //------------------------------------------------------------------------------
            3:  if (is_nul) begin // Added begin/end to resolve "Null statement" violation
                    `goto(ism_SYNTAX_ERR);
                end

                // If the token is alphanumeric...
                else if (is_alpha) begin

                    // If it's the word "on", turn on the specified LED
                    if (token == "on") begin
                        is_led_fixed[led_index] <= 1;
                        led_fixed_at[led_index] <= 1;
                        `goto(ism_FLUSH_MSG);
                    end

                    // If it's the word "off", turn off the specified LED
                    else if (token == "off") begin
                        is_led_fixed[led_index] <= 1;
                        led_fixed_at[led_index] <= 0;
                        `goto(ism_FLUSH_MSG);
                    end

                    // If it's anything other string, it's a syntax error
                    else begin // Added begin/end to resolve "Null statement" violation
                        `goto(ism_SYNTAX_ERR);
                    end
                end
                
                // If we get here, the token is numeric...
                else begin
                    
                    // If it's within the valid range, set the reload value for the 
                    // appropriate LED
                    if (number >= 1 && number <= DIVISORS) begin
                        is_led_fixed[led_index] <= 0;
                        reload[led_index]       <= reload_precalc[number]; 
                        `goto(ism_FLUSH_MSG);
                    end
                    
                    // If the number wasn't valid, issue a range error
                    else begin // Added begin/end to resolve "Null statement" violation
                        `goto(ism_RANGE_ERR);
                    end
                end
            //------------------------------------------------------------------------------


            //------------------------------------------------------------------------------
            // Here we sit in a loop reading and throwing away tokens until we reach the 
            // nul-token that signifies the end of the message.  After we've thrown away all
            // tokens up-to-and-including the "end of message" marker, we return to IDLE 
            // state.
            //------------------------------------------------------------------------------
            ism_FLUSH_MSG:
                if (eom == 0) begin 
                    `icall(ism_FETCH_TOKEN);
                end else begin // Added begin/end to resolve "Null statement" violation
                    `goto(ism_IDLE);
                end
            //------------------------------------------------------------------------------


            //------------------------------------------------------------------------------
            // Subroutine : ism_FETCH_TOKEN
            //
            // On entry: eom = true if we've already detected the last token of the message
            //
            // On exit:  eom   = true if the newly fetched token is all zero bits
            //           token = The newly fetched token
            //------------------------------------------------------------------------------
            ism_FETCH_TOKEN:
                if (eom) begin 
                    `return;
                end else if (FIFO_EMPTY == 0) begin
                    FIFO_RD_EN <= 1;
                    ism_state  <= ism_state + 1;
                end

            ism_FETCH_TOKEN + 1:
                begin
                    token <= FIFO_DATA;
                    eom   <= (FIFO_DATA == 0);
                    `return;
                end
            //------------------------------------------------------------------------------

            endcase
        end // End of added begin/end block

    end
    //===============================================================================================


    //===============================================================================================
    // This state machine manages LEDs
    //===============================================================================================
    generate
        genvar x_led; // Declared genvar locally within the generate block
        for (x_led=0; x_led<LED_COUNT; x_led=x_led+1) begin : led_instance_gen
            always @(posedge clk) begin 
                if (resetn == 0) begin // Added begin/end for reset block
                    LED[x_led] <= 0;
                end
                else begin
                    // If the LED has a fixed value...
                    if (is_led_fixed[x_led]) begin // Added begin/end for if block

                        // Output that fixed value.
                        LED[x_led] <= led_fixed_at[x_led];
                    
                    // Otherwise, if it's counter has reached 0...
                    end else if (counter[x_led] == 0) begin
                        
                        // Invert the state of the LED...
                        LED[x_led] <= ~LED[x_led];
                        
                        // And reload the counter for this LED
                        counter[x_led] <= reload[x_led];

                    // Otherwise, this LED is still counting down
                    end else begin // Added begin/end for else block
                        counter[x_led] <= counter[x_led] - 1;
                    end
                end
            end
        end
    endgenerate
    //===============================================================================================


endmodule
