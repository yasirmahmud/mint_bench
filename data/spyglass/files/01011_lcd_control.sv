module lcd_control
  (/*AUTOARG*/
  // Outputs
  sf_d, sf_ceo, lcd_e, lcd_rs, lcd_rw, led,
  // Inputs
  clk, reset, init_done
  );

  // parameters
  parameter [3:0] 
    init = 4'h0,
    function_set = 4'h1,
    entry_set = 4'h2,
    set_display = 4'h3,
    clear_display = 4'h4,
    pause = 4'h5,
    set_addr = 4'h6,
    char_f = 4'h7,
    char_p = 4'h8,
    char_g = 4'h9,
    char_a = 4'ha,
    main_done = 4'hb;

  parameter [2:0]
    high_setup = 3'h0,
    high_hold = 3'h1,
    oneus = 3'h2,
    low_setup = 3'h3,
    low_hold = 3'h4,
    fortyus = 3'h5,
    tx_done = 3'h6;

  parameter [3:0]
    idle = 4'h0,
    fifteenms = 4'h1,
    one = 4'h2,
    two = 4'h3,
    three = 4'h4,
    four = 4'h5,
    five = 4'h6,
    six = 4'h7,
    seven = 4'h8,
    eight = 4'h9,
    power_on_done = 4'ha;
    
                  
  // In/Out declarations
  input        clk;
  input        reset;

  // temporary
  input        init_done;

  output [3:0] sf_d;
  output       sf_ceo;

  output       lcd_e;
  output       lcd_rs;
  output       lcd_rw;

  output [7:0] led;

  /*AUTOREG*/
  // Beginning of automatic regs (for this module's undeclared outputs)
  reg			lcd_e;
  reg			lcd_rs;
  reg [7:0]		led;
  reg [3:0]		sf_d;
  // End of automatics
  /*AUTOWIRE*/

  // Regs and Wires
//  reg          init_done;

  reg [3:0]    main_state;
  reg [3:0]    nxt_main_state;

  reg [3:0]    init_state;
  reg [3:0]    nxt_init_state;

  reg [2:0]    tx_state;
  reg [2:0]    nxt_tx_state;

  reg [3:0]    power_on_state;
  reg [3:0]    nxt_power_on_state;

  reg [19:0]   timer1;

  reg          start_timer;
  reg [23:0]   start_timer_value;
  wire         timer_expired;

  reg          tx_init;
  reg          init_init;

  wire [24:0]   tx_count;

  reg 		lcd_e0;
  reg [3:0] 	sf_d0;

  assign lcd_rw = 1'b0;
  assign sf_ceo = 1'b0;

  ////////////////////////
  // Counter instance used for all countdown timers
  dec_counter counter0(.clk(clk),
		       .rst(reset),
		       .load(start_timer),
		       .load_value(start_timer_value),
		       .expired(timer_expired),
		       .counter(tx_count));
  ////////////////////////

  ////////////////////////
  // Main state machine
  always @(/*AS*/init_done or main_state or timer_expired) begin
    nxt_main_state = main_state;
    
    case (main_state)
      init : begin
	if (init_done == 1'b1) begin
	  nxt_main_state = function_set;
	end
      end

      function_set : begin
	if (timer_expired) begin
	  nxt_main_state = entry_set;
	end
      end

      entry_set : begin
	if (timer_expired) begin
	  nxt_main_state = set_display;
	end
      end

      set_display : begin
	if (timer_expired) begin
	  nxt_main_state = clear_display;
	end
      end

      clear_display : begin
	if (timer_expired) begin
	  nxt_main_state = pause;
	end
      end

      pause : begin
	if (timer_expired) begin
	  nxt_main_state = set_addr;
	end
      end

      set_addr : begin
	if (timer_expired) begin
	  nxt_main_state = char_f;
	end
      end

      char_f : begin
	if (timer_expired) begin
	  nxt_main_state = char_p;
	end
      end

      char_p : begin
	if (timer_expired) begin
	  nxt_main_state = char_g;
	end
      end

      char_g : begin
	if (timer_expired) begin
	  nxt_main_state = char_a;
	end
      end

      char_a : begin
	if (timer_expired) begin
	  nxt_main_state = main_done;
	end
      end

      main_done : begin
	nxt_main_state = main_done;
      end

      default : nxt_main_state <= 4'hx;
    endcase
  end
  ////////////////////////

  ////////////////////////
  // LCD_RS output
  always @(posedge clk) begin
    if (~reset) begin
      lcd_rs <= 1'b1;
    end
    else begin
      if (main_state == function_set ||
	  main_state == entry_set ||
	  main_state == set_display ||
	  main_state == clear_display ||
	  main_state == set_addr) begin
	lcd_rs <= 1'b0;
      end
      else begin
	lcd_rs <= 1'b1;
      end
    end
  end
  ////////////////////////

  ////////////////////////
  // LED output
  always @(posedge clk) begin
    if (~reset) begin
      led <= 8'h00;
    end
    else begin
      case (main_state)
	function_set  : led <= 8'b00101000;
	entry_set     : led <= 8'b00000110;
	set_display   : led <= 8'b00001100;
	clear_display : led <= 8'b00000001;
	set_addr      : led <= 8'b10000000;
	char_f        : led <= 8'b01000110;
	char_p        : led <= 8'b01010000;
	char_g        : led <= 8'b01000111;
	char_a        : led <= 8'b01000001;
	default       : led <= 8'h00;
      endcase
    end
  end
  ////////////////////////

  ////////////////////////
  // Manage state machine
  always @(posedge clk) begin
    if (~reset) begin
      main_state <= init;
      start_timer  <= 1'b0;
      start_timer_value <= 24'h000;
      tx_init <= 1'b0;
      init_init <= 1'b0;
    end
    else begin

      if (main_state == init) begin
	init_init <= 1'b1;
      end
      else begin
	init_init <= 1'b0;
      end

      if (nxt_main_state == init ||
	  nxt_main_state == pause ||
	  nxt_main_state == main_done) begin
	tx_init <= 1'b0;
      end
      else begin
	tx_init <= 1'b1;
      end

      if (main_state != nxt_main_state) begin
	if (main_state == init ||
	    main_state == function_set ||
	    main_state == entry_set ||
	    main_state == set_display ||
	    main_state == pause ||
	    main_state == set_addr ||
	    main_state == char_f ||
	    main_state == char_p ||
	    main_state == char_g) begin
	  start_timer_value <= 2078;
	  start_timer <= 1'b1;
	end
	else if (main_state == clear_display) begin
	  start_timer_value <= 82000;
	  start_timer <= 1'b1;
	end
      end
      else begin
	start_timer <= 1'b0;
      end
      
      main_state <= nxt_main_state;

    end
  end
  ////////////////////////


  ////////////////////////
  // TX state machine
  always @(/*AS*/led or timer_expired or tx_count or tx_init
	   or tx_state) begin
    nxt_tx_state = tx_state;
    lcd_e0 = 1'b0;
    sf_d0 = led[3:0];
    
    case(tx_state)
      high_setup : begin
	lcd_e0 = 1'b0;
	sf_d0 = led[7:4];
	if (tx_count == 2076) begin
	  nxt_tx_state = high_hold;
	end
      end
      high_hold : begin
	lcd_e0 = 1'b1;
	sf_d0 = led[7:4];
	if (tx_count == 2064) begin
	  nxt_tx_state = oneus;
	end
      end
      oneus : begin
	lcd_e0 = 1'b0;
	sf_d0 = led[7:4];
	if (tx_count == 2014) begin
	  nxt_tx_state = low_setup;
	end
      end
      low_setup : begin
	lcd_e0 = 1'b0;
	sf_d0 = led[3:0];
	if (tx_count == 2012) begin
	  nxt_tx_state = low_hold;
	end
      end
      low_hold : begin
	lcd_e0 = 1'b1;
	sf_d0 = led[3:0];
	if (tx_count == 2000) begin
	  nxt_tx_state = fortyus;
	end
      end
      fortyus : begin
	lcd_e0 = 1'b0;
	sf_d0 = led[3:0];
	if (timer_expired) begin
	  nxt_tx_state = tx_done;
	end
      end
      tx_done : begin
	lcd_e0 = 1'b0;
	if (tx_init == 1'b1) begin
	  nxt_tx_state = high_setup;
	end
      end
      default : begin
      end
    endcase

  end
  ////////////////////////

  ////////////////////////
  // Manage state machine
  always @(posedge clk) begin
    if (~reset) begin
      tx_state <= tx_done;
    end
    else begin
      tx_state <= nxt_tx_state;
    end
  end
  ////////////////////////

  ////////////////////////
  // Init state machine
  always @(/*AS*/init_init or init_state) begin
    nxt_init_state = init_state;

    case (init_state)
      idle : begin
	if (init_init == 1'b1) begin
	  nxt_init_state = fifteenms;
	end
      end
      fifteenms : begin
      end
      one : begin
      end
      two : begin
      end
      three : begin
      end
      four : begin
      end
      five : begin
      end
      six : begin
      end
      seven : begin
      end
      eight : begin
      end
      power_on_done : begin
      end
      default : begin
      end
    endcase
  end


  
endmodule
