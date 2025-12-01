module main(
    input CLOCK_50,
);

	[15:0] keys = keyboard_reader()
	tone_player(keys)

	// Clock controlling game progression - 0.5 for now, perhaps this should be changed *shrug*
	wire game_clock;
	period_gen pg1(.CLOCK_50(CLOCK_50), .t_ms(500), .new_clk(game_clock));

	// Counter keeping track of what game frame we're currently in
	wire [7:0] game_frame;
	counter8 c8(.clk(game_clock), .reset(0), .pause(0), .reset_at(0), .count(game_frame));
	
	game_map // Row = individual note
	  // 16 bit : ****----######## : * = note identifier, - = how long, # = when it starts
	state //matrix of pixel values
	  // 12 x 16, each spot 0 or 1 to indicate pixel position
	score //12bit num

	engine(game_map, state, game_frame) //updates state by reading from game_map
	  //Top row determined by game_map 
	  //Subsequent rows determined by previous row
	display(state) //800 MHz stream
	  //1250ns per bit  ; 0 = high 400ns, low 850ns & 1 = high 800ns, low 450ns
	  //Reset = low >50us  
	scorer(keys, state[bottom_row], score)
	  //state[bottom_row] == keys ? score += 10 : score = score
	hex_display(score)


endmodule