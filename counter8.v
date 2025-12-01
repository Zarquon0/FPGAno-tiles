module counter8(
	input clk, reset, pause, input [7:0] reset_at, 
	output reg unsigned [7:0] count
	);
	
	//reset_at dictates the number 1 beyond what the counter will ever reach,
	//so reset_after dictates the highest number that the counter will reach
	wire [7:0] reset_after;
	assign reset_after = ((reset_at == 0) ? 255 : reset_at - 1);
	
	reg paused;
	always @(posedge pause) begin
		paused <= ~paused;
	end
	
	always @(posedge clk or posedge reset) begin
		if (reset) count <= 0;
		else begin
			if (paused) count <= count;
			else count <= ((count == reset_after) ? 0 : count + 1);
		end
	end
	
endmodule