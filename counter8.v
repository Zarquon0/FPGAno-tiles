 module counter8(
	input clk, reset, start, input [7:0] stop_at, 
	output reg unsigned [7:0] count
	);
	
	//reset_at dictates the number 1 beyond what the counter will ever reach,
	//so reset_after dictates the highest number that the counter will reach
	wire [7:0] stop_after;
	assign stop_after = ((stop_at == 0) ? 255 : stop_at - 1);
	
//	reg started;
//	always @(posedge pause) begin
//		paused <= ~paused;
//	end
	
	always @(posedge clk or posedge reset) begin
		if (reset) count <= 0;
		else begin
			if (~start) count <= 0;
			else count <= ((count == stop_after) ? count : count + 1);
		end
	end
	
endmodule