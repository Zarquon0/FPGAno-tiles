module score(game_clock,correct_key_pressed,KEY,CLOCK_50, score_units,score_tens,score_hundreds,score_thousands,running,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5);
   input game_clock,correct_key_pressed,CLOCK_50;
   input [3:0] KEY;   //Start is KEY0, Reset is KEY3
	output reg [3:0] score_units,score_tens,score_hundreds,score_thousands;
	output reg running;
	output [6:0] HEX0,HEX1,HEX2,HEX3,HEX4,HEX5;
	reg [3:0] meta_key,final_key,final_key_prev;
    //initialize all 
	initial
	begin
		running = 0;
		score_units=0;
		score_tens=0;
		score_hundreds=0;
		score_thousands=0;
	end

	// synchronize start and reset
	always @(posedge CLOCK_50)
	begin
		meta_key <= KEY;
		final_key <= meta_key;
		final_key_prev <= final_key;
	end

    //set up start and reset 
	//Check and Add scores every middle of beat if correct key is pressed.
	always @(negedge game_clock || posedge final_key[3])
	begin
		//Reset
		if (~final_key[3] && final_key_prev[3]) 
		begin
			score_thousands<=0;
			score_hundreds<=0;
			score_tens<=0;
			score_units<=0;
			running<=0;
		end
		//Start
		else if (~final_key[0] && final_key_prev[0]) running<=1;   //whenever running is 0 just go back to first state (as reset)
		//update score
		else if(correct_key_pressed) 
		begin	
			if(score_tens ==9)
			begin	
				score_tens<=0;
				if(score_hundreds==9)
				begin
					score_hundreds<=0;
					score_thousands<=score_thousands+1;
				end
				else score_hundreds<= score_hundreds+1;
			end
			else score_tens<=score_tens+1;
		end
        //when wrong key is pressed and reset is not pressed keep scores the same (no pause so start will start once and pressing again will not do anything)
		else 
		begin 
			score_units <= score_units;
			score_tens <= score_tens;
			score_hundreds <= score_hundreds;
			score_thousands <= score_thousands;
		end 
	end


	//to display each score digit in the hex displays 
q6 display_units (
		.SW(score_units),
		.HEX0(HEX0)
);
q6 display_tens (
		.SW(score_tens),
		.HEX0(HEX1)
);

q6 display_hundreds (
		.SW(score_hundreds),
		.HEX0(HEX2)
);
q6 display_thousands (

module score(game_clock,correct_key_pressed,KEY,CLOCK_50, score_units,score_tens,score_hundreds,score_thousands,running,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5);
   input game_clock,correct_key_pressed,CLOCK_50;
   input [3:0] KEY;   //Start is KEY0, Reset is KEY3
	output reg [3:0] score_units,score_tens,score_hundreds,score_thousands;
	output reg running;
	output [6:0] HEX0,HEX1,HEX2,HEX3,HEX4,HEX5;
	reg [3:0] meta_key,final_key,final_key_prev;
	initial
	begin
		running = 0;
		score_units=0;
		score_tens=0;
		score_hundreds=0;
		score_thousands=0;
	end
	// synchronize start and reset
	always @(posedge CLOCK_50)
	begin
		meta_key <= KEY;
		final_key <= meta_key;
		final_key_prev <= final_key;
	end


	//Check and Add scores every middle of beat if correct key is pressed.
	always @(negedge game_clock || posedge final_key[3])
	begin
		//Reset
		if (~final_key[3] && final_key_prev[3]) 
		begin
			score_thousands<=0;
			score_hundreds<=0;
			score_tens<=0;
			score_units<=0;
			running<=0;
		end
		//Start
		else if (~final_key[0] && final_key_prev[0]) running<=1;   //whenever running is 0 just go back to first state (as reset)
		
		else if(correct_key_pressed) 
		begin	
			if(score_tens ==9)
			begin	
				score_tens<=0;
				if(score_hundreds==9)
				begin
					score_hundreds<=0;
					score_thousands<=score_thousands+1;
				end
				else score_hundreds<= score_hundreds+1;
			end
			else score_tens<=score_tens+1;
		end

		else 
		begin 
			score_units <= score_units;
			score_tens <= score_tens;
			score_hundreds <= score_hundreds;
			score_thousands <= score_thousands;
		end 
	end


	
q6 display_units (
		.SW(score_units),
		.HEX0(HEX0)
);
q6 display_tens (
		.SW(score_tens),
		.HEX0(HEX1)
);

q6 display_hundreds (
		.SW(score_hundreds),
		.HEX0(HEX2)
);
q6 display_thousands (
		.SW(score_thousands),
		.HEX0(HEX3)
);
q6 display_empty1 (
		.SW(4'b0000),
		.HEX0(HEX4)
);
q6 display_empty2 (
		.SW(4'b0000),
		.HEX0(HEX5)
);
endmodule 