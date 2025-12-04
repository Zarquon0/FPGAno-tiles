module score(game_clock,correct_key_pressed,CLOCK_50,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,start,reset);
   input game_clock,correct_key_pressed,CLOCK_50;
   input start,reset;
	reg [3:0] score_units,score_tens,score_hundreds,score_thousands;
	output [6:0] HEX0,HEX1,HEX2,HEX3,HEX4,HEX5;
    //initialize all 
	initial
	begin
		score_units=0;
		score_tens=0;
		score_hundreds=0;
		score_thousands=0;
	end



	//Check and Add scores every middle of beat if correct key is pressed.
	always @(negedge game_clock or posedge reset)
	begin
		//Reset
		if (reset) 
		begin
			score_thousands<=0;
			score_hundreds<=0;
			score_tens<=0;
			score_units<=0;
		end
		else begin
			//Start
			//if (start) running<=1;   //whenever running is 0 just go back to first state (as reset)
			//update score
			if(correct_key_pressed) 
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