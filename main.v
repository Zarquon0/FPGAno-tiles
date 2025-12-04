module main(
	input CLOCK_50, input [3:0] GPIO_1, KEY,
	inout [35:0] GPIO_0, 
	output [9:0] LEDR, output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5
);
	//
	//INPUT SIDE
	//
	
	//One hot encoded representation of which key is currently being pressed
	wire [15:0] keys; 
	read_keyboard rk1(.CLOCK_50(CLOCK_50), .cols(GPIO_1[3:0]), .rows(GPIO_0[3:0]), .pad(keys));
	
	//NOTE: Reset and start buttons are handled in score.v
	
	// Pause and reset signals
	wire reset;
	reg start;
	initial start = 0;
	assign reset = ~KEY[3];
	always @(negedge KEY[0] or posedge reset) begin
		if (reset) start <= 0;
		else start <= 1; 
	end

	//
	//INTERNALS
	//
	
	// Clock controlling game progression - 0.5 for now, perhaps this should be changed *shrug*
	wire game_clock;
	period_gen pg1(.CLOCK_50(CLOCK_50), .t_ms(1000), .new_clk(game_clock)); 

	// Counter keeping track of what game frame we're currently in
	// NOTE: 8 bits, so maxes at 255
	wire [7:0] game_frame;
	counter8 c8(.clk(game_clock), .reset(reset), .start(start), 
		.reset_at(11), //reset_at should be set to the LENGTH of the song being played
		.count(game_frame));
	
	// Game state objects (downstream of game_frame
	// curr_note = one hot encoded representation of current note, next_note = same thing for next note
	// hold_length = binary representation for how many beats (game_clock periods) current note should be held
	wire [11:0] curr_note, next_note;
	wire [3:0] hold_length;

	// Keeps track of player score, maxing out at 9,990
	wire [16:0] score;
	
	// NOTE: See engine for game_map object - would be declared out here
	// but 2d arrays cannot be passed as module inputs

	//Updates game state objects based off of game_frame and internal game_map
	engine e(
		.game_frame(game_frame), .game_clock(game_clock),
		.curr_note(curr_note), .next_note(next_note), .hold_length(hold_length)
		);
		
	// Scorer
	wire correct_key_pressed;
	assign correct_key_pressed = (keys[11:0] == curr_note);
	score s(.game_clock(game_clock), .correct_key_pressed(correct_key_pressed), .CLOCK_50(CLOCK_50),
		  .start(start), .reset(reset), .HEX0(HEX0), .HEX1(HEX1), .HEX2(HEX2), .HEX3(HEX3), .HEX4(HEX4), .HEX5(HEX5)
		);
	
	//
	//OUTPUT SIDE  
	//
	
	// Display beat (visual metronome) via LED
	assign LEDR[9] = game_clock;
	
	// Display hold length
	assign mask_shift = (hold_length <= 8 ? hold_length : 8); 
	assign LEDR[7:0] = ((1 << hold_length) - 1);
	
	// Display notes
	assign GPIO_0[21:10] = curr_note[11:0];
	assign GPIO_0[35:24] = next_note[11:0];
	
	// Play the note corresponding to a given keypress - even if incorrect!
	wire tone;
	tone_player tp1(.CLOCK_50(CLOCK_50), .keys(keys), .tone(tone));
	assign GPIO_0[4] = tone;

	// NOTE: Score display is taken care of inside of score.v

endmodule