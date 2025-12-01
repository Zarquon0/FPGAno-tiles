module period_gen(
	input CLOCK_50, input [19:0] t_ms,
	output reg new_clk
	);
	
	wire [31:0] to_count;
	assign to_count = 25_000*t_ms;
	
	reg [31:0] counter;
   always @(posedge CLOCK_50)
   begin
       if (counter == to_count) begin 
           new_clk <= ~new_clk;
           counter <= 0;
       end
       else begin
           new_clk <= new_clk;
           counter <= counter + 1;
       end
   end
	
	
endmodule