module test(
	input game_clock, 
	output [11:0] curr_note, next_note, output [3:0] hold_length, output [7:0] game_frame
);
	
	counter8 c8(.clk(game_clock), .reset(0), .start(1), .stop_at(0), .count(game_frame));

	engine e(
		.game_frame(game_frame), .game_clock(game_clock),
		.curr_note(curr_note), .next_note(next_note), .hold_length(hold_length)
		);

endmodule
