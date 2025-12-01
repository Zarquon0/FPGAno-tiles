module tone_player(
	input CLOCK_50, input [15:0] keys, 
	output tone
);

	wire a,b,c,d,e,f,g,as,cs,ds,fs,gs;
	freq_gen fg3(.CLOCK_50(CLOCK_50), .freq_to_gen(1047), .new_clk(c));
	freq_gen fg4(.CLOCK_50(CLOCK_50), .freq_to_gen(1109), .new_clk(cs));
	freq_gen fg5(.CLOCK_50(CLOCK_50), .freq_to_gen(1175), .new_clk(d));
	freq_gen fg6(.CLOCK_50(CLOCK_50), .freq_to_gen(1245), .new_clk(ds));
	freq_gen fg7(.CLOCK_50(CLOCK_50), .freq_to_gen(1319), .new_clk(e));
	freq_gen fg8(.CLOCK_50(CLOCK_50), .freq_to_gen(1397), .new_clk(f));
	freq_gen fg9(.CLOCK_50(CLOCK_50), .freq_to_gen(1480), .new_clk(fs));
	freq_gen fg10(.CLOCK_50(CLOCK_50), .freq_to_gen(1568), .new_clk(g));
	freq_gen fg11(.CLOCK_50(CLOCK_50), .freq_to_gen(1661), .new_clk(gs));
	freq_gen fg12(.CLOCK_50(CLOCK_50), .freq_to_gen(1760), .new_clk(a));
	freq_gen fg1(.CLOCK_50(CLOCK_50), .freq_to_gen(1866), .new_clk(as));
	freq_gen fg2(.CLOCK_50(CLOCK_50), .freq_to_gen(1976), .new_clk(b));
	
	reg wave;
	always @* begin
		casex (keys[11:0])
			12'b1??????????? : wave = b;
			12'b?1?????????? : wave = as;
			12'b??1????????? : wave = a;
			12'b???1???????? : wave = gs;
			12'b????1??????? : wave = g;
			12'b?????1?????? : wave = fs;
			12'b??????1????? : wave = f;
			12'b???????1???? : wave = e;
			12'b????????1??? : wave = ds;
			12'b?????????1?? : wave = d;
			12'b??????????1? : wave = cs;
			12'b???????????1 : wave = c;
			default : wave = 0;
		endcase
	end
	assign tone = wave;

endmodule

