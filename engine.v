module engine(
	input unsigned [7:0] game_frame, input game_clock,
	output [11:0] curr_note, next_note, output reg [3:0] hold_length
);
	
	// 2d matrix storing song data
	// Row = one note
	// 8 bit : ****---- : * = note identifier, - = how long
	reg [7:0] game_map [3:0];
	initial begin
		game_map[0] = {4'd0, 4'd2};
		game_map[1] = {4'd2, 4'd3};              
		game_map[2] = {4'd8, 4'd2};
		game_map[3] = {4'd6, 4'd4};
	end
	
	reg unsigned [7:0] index, past_beats;
	initial begin
		index = 0;
		past_beats = 0;
	end
	
	reg [3:0] curr_bin, next_bin;
	always @(posedge game_clock) begin
		if (game_frame == 0) begin //Game actually lags one frame behind game_frame
			index <= 0;
			past_beats <= 0;
		end
		if (({4'd0, game_map[index][3:0]} + past_beats) <= game_frame) begin
			index <= index + 8'd1;
			past_beats <= past_beats + game_map[index][3:0];
		end
		curr_bin <= game_map[index][7:4];
		next_bin <= game_map[index + 8'd1][7:4];
		hold_length <= game_map[index][3:0];
	end
	
	wire [15:0] curr_full, next_full;
	onehot4 oh41(.to_encode(curr_bin), .encoded(curr_full));
	onehot4 oh42(.to_encode(next_bin), .encoded(next_full));
	assign curr_note = curr_full[11:0];
	assign next_note = next_full[11:0];
	
endmodule
