module main(
	input CLOCK_50, input [3:0] GPIO_0, 
	inout [3:0] GPIO_1
);
	//
	//INPUT SIDE
	//
	
	//One hot encoded representation of which key is currently being pressed
	reg [15:0] keys;
	read_keyboard rk1(.CLOCK_50(CLOCK_50), .cols(GPIO_0[3:0]), .rows(GPIO_1[3:0]), .pad(keys));
	
	//
	//INTERNALS
	//
	
	// Clock controlling game progression - 0.5 for now, perhaps this should be changed *shrug*
	reg game_clock;
	period_gen pg1(.CLOCK_50(CLOCK_50), .t_ms(500), .new_clk(game_clock));

	// Counter keeping track of what game frame we're currently in
	reg [7:0] game_frame;
	counter8 c8(.clk(game_clock), .reset(0), .pause(0), .reset_at(0), .count(game_frame));
	
	// 2d matrix storing song data
	// Row = one note
	// 16 bit : ****----######## : * = note identifier, - = how long, # = when it starts
	reg [15:0] game_map [3:0];
	initial begin
		game_map[0] = {4'd0, 4'd4, 8'd0};
		game_map[1] = {4'd1, 4'd4, 8'd4};
		game_map[2] = {4'd2, 4'd4, 8'd8};
		game_map[3] = {4'd3, 4'd4, 8'd12};
	end
	 
	// 2d matrix of current pixel values
	// 0 = OFF, 1 = ON 
	reg [11:0] state [15:0];
	initial state = 0;
	
	// Keeps track of player score, maxing out at 9,990
	reg [16:0] score;
	initial score = 0;

	engine(game_map, state, game_frame) //updates state by reading from game_map
	  //Top row determined by game_map 
	  //Subsequent rows determined by previous row
	scorer(keys, state[bottom_row], score)
	  //state[bottom_row] == keys ? score += 10 : score = score
	
	//
	//OUTPUT SIDE  
	//
	
	tone_player(keys)
	hex_display(score)
	display(state) //800 MHz stream
	  //1250ns per bit  ; 0 = high 400ns, low 850ns & 1 = high 800ns, low 450ns
	  //Reset = low >50us


endmodule