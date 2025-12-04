module engine(
	input unsigned [7:0] game_frame, input game_clock,
	output [11:0] curr_note, next_note, output reg [3:0] hold_length
);
	
	// 2d matrix storing song data
	// Row = one note
	// 8 bit : ****---- : * = note identifier, - = how long
	// Array size is 42 notes (Indices 0 to 41)
	/*reg [7:0] game_map [45:0];
	initial begin
		// --- INTRO RESTS ---
		game_map[0]  = {4'd15, 4'd1}; // Rest (1 beat)
		game_map[1]  = {4'd15, 4'd1}; // Rest (1 beat)

		// --- SECTION A ("Twinkle twinkle little star...") ---
		game_map[2]  = {4'd0, 4'd1};  // C
		game_map[3]  = {4'd0, 4'd1};  // C
		game_map[4]  = {4'd7, 4'd1};  // G
		game_map[5]  = {4'd7, 4'd1};  // G
		game_map[6]  = {4'd9, 4'd1};  // A
		game_map[7]  = {4'd9, 4'd1};  // A
		game_map[8]  = {4'd7, 4'd2};  // G (hold 2 beats)

		// ("...How I wonder what you are")
		game_map[9]  = {4'd5, 4'd1};  // F
		game_map[10] = {4'd5, 4'd1};  // F
		game_map[11] = {4'd4, 4'd1};  // E
		game_map[12] = {4'd4, 4'd1};  // E
		game_map[13] = {4'd2, 4'd1};  // D
		game_map[14] = {4'd2, 4'd1};  // D
		game_map[15] = {4'd0, 4'd2};  // C (hold 2 beats)

		// --- SECTION B ("Up above the world so high...") ---
		game_map[16] = {4'd7, 4'd1};  // G
		game_map[17] = {4'd7, 4'd1};  // G
		game_map[18] = {4'd5, 4'd1};  // F
		game_map[19] = {4'd5, 4'd1};  // F
		game_map[20] = {4'd4, 4'd1};  // E
		game_map[21] = {4'd4, 4'd1};  // E
		game_map[22] = {4'd2, 4'd2};  // D (hold 2 beats)

		// ("...Like a diamond in the sky")
		game_map[23] = {4'd7, 4'd1};  // G
		game_map[24] = {4'd7, 4'd1};  // G
		game_map[25] = {4'd5, 4'd1};  // F
		game_map[26] = {4'd5, 4'd1};  // F
		game_map[27] = {4'd4, 4'd1};  // E
		game_map[28] = {4'd4, 4'd1};  // E
		game_map[29] = {4'd2, 4'd2};  // D (hold 2 beats)

		// --- SECTION A REPEAT ("Twinkle twinkle little star...") ---
		game_map[30] = {4'd0, 4'd1};  // C
		game_map[31] = {4'd0, 4'd1};  // C
		game_map[32] = {4'd7, 4'd1};  // G
		game_map[33] = {4'd7, 4'd1};  // G
		game_map[34] = {4'd9, 4'd1};  // A
		game_map[35] = {4'd9, 4'd1};  // A
		game_map[36] = {4'd7, 4'd2};  // G (hold 2 beats)

		// ("...How I wonder what you are")
		game_map[37] = {4'd5, 4'd1};  // F
		game_map[38] = {4'd5, 4'd1};  // F
		game_map[39] = {4'd4, 4'd1};  // E
		game_map[40] = {4'd4, 4'd1};  // E
		game_map[41] = {4'd2, 4'd1};  // D
		game_map[42] = {4'd2, 4'd1};  // D
		game_map[43] = {4'd0, 4'd2};  // C (hold 2 beats)

		// --- OUTRO RESTS ---
		game_map[44] = {4'd15, 4'd1}; // Rest (1 beat)
		game_map[45] = {4'd15, 4'd1}; // Rest (1 beat)
	end*/
	reg [7:0] game_map [41:0];
	initial begin
		// --- INTRO RESTS (2 Beats) ---
		game_map[0]  = {4'd15, 4'd1}; // Rest
		game_map[1]  = {4'd15, 4'd1}; // Rest

		// --- SECTION A ("Dum da-da-da dum...") ---
		game_map[2]  = {4'd7, 4'd2};  // E
		game_map[3]  = {4'd2, 4'd1};  // B
		game_map[4]  = {4'd3, 4'd1};  // C
		game_map[5]  = {4'd5, 4'd2};  // D
		game_map[6]  = {4'd3, 4'd1};  // C
		game_map[7]  = {4'd2, 4'd1};  // B
		game_map[8]  = {4'd0, 4'd2};  // A
		game_map[9]  = {4'd0, 4'd1};  // A
		game_map[10] = {4'd3, 4'd1};  // C
		game_map[11] = {4'd7, 4'd2};  // E
		game_map[12] = {4'd5, 4'd1};  // D
		game_map[13] = {4'd3, 4'd1};  // C
		game_map[14] = {4'd2, 4'd3};  // B (Held longer)
		game_map[15] = {4'd3, 4'd1};  // C
		game_map[16] = {4'd5, 4'd2};  // D
		game_map[17] = {4'd7, 4'd2};  // E
		game_map[18] = {4'd3, 4'd2};  // C
		game_map[19] = {4'd0, 4'd2};  // A
		game_map[20] = {4'd0, 4'd2};  // A
		
		// ** NEW REST ADDED HERE **
		game_map[21] = {4'd15, 4'd2}; // Rest (Quarter note)

		// --- SECTION B ("Da-da-da Dum...") ---
		game_map[22] = {4'd5, 4'd2};  // D
		game_map[23] = {4'd5, 4'd1};  // D
		game_map[24] = {4'd8, 4'd1};  // F
		game_map[25] = {4'd10, 4'd2}; // G (Substituted for High A)
		game_map[26] = {4'd10, 4'd1}; // G
		game_map[27] = {4'd8, 4'd1};  // F
		game_map[28] = {4'd7, 4'd2};  // E
		game_map[29] = {4'd3, 4'd1};  // C
		game_map[30] = {4'd7, 4'd1};  // E
		game_map[31] = {4'd5, 4'd2};  // D
		game_map[32] = {4'd3, 4'd1};  // C
		game_map[33] = {4'd2, 4'd1};  // B
		game_map[34] = {4'd2, 4'd3};  // B (Held longer)
		game_map[35] = {4'd3, 4'd1};  // C
		game_map[36] = {4'd5, 4'd2};  // D
		game_map[37] = {4'd7, 4'd2};  // E
		game_map[38] = {4'd3, 4'd2};  // C
		game_map[39] = {4'd0, 4'd2};  // A
		game_map[40] = {4'd0, 4'd2};  // A

		// --- OUTRO RESTS (2 Beats) ---
		game_map[41] = {4'd15, 4'd2}; // Rest
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
