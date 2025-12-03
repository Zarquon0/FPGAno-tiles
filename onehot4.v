module onehot4(
	input [3:0] to_encode,
	output reg [15:0] encoded
);
	always @(*) begin
		case (to_encode)
			4'd0 : encoded = 16'b0000_0000_0000_0001;
			4'd1 : encoded = 16'b0000_0000_0000_0010;
			4'd2 : encoded = 16'b0000_0000_0000_0100;
			4'd3 : encoded = 16'b0000_0000_0000_1000;
			4'd4 : encoded = 16'b0000_0000_0001_0000;
			4'd5 : encoded = 16'b0000_0000_0010_0000;
			4'd6 : encoded = 16'b0000_0000_0100_0000;
			4'd7 : encoded = 16'b0000_0000_1000_0000;
			4'd8 : encoded = 16'b0000_0001_0000_0000;
			4'd9 : encoded = 16'b0000_0010_0000_0000;
			4'd10 : encoded = 16'b0000_0100_0000_0000;
			4'd11 : encoded = 16'b0000_1000_0000_0000;
			4'd12 : encoded = 16'b0001_0000_0000_0000;
			4'd13 : encoded = 16'b0010_0000_0000_0000;
			4'd14 : encoded = 16'b0100_0000_0000_0000;
			4'd15 : encoded = 16'b1000_0000_0000_0000;
		endcase
	end
	
endmodule
	