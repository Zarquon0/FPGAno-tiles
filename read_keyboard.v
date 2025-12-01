module read_keyboard(
	input CLOCK_50, input [3:0] cols,
	inout [3:0] rows, output reg [15:0] pad
	); 
	
	reg [3:0] inter_cols, scols;
	always @(posedge CLOCK_50) begin
		inter_cols <= cols;
		scols = inter_cols;
	end
	
	wire milli_clk;
	period_gen pg(.CLOCK_50(CLOCK_50), .t_ms(10), .new_clk(milli_clk));
	
	initial begin
		state = 0;
	end

	reg unsigned [1:0] state;
	wire [3:0] rev_cols;
	assign rev_cols = ~{scols[0], scols[1], scols[2], scols[3]};
	always @(posedge milli_clk) begin
		case (state)
        2'd0: pad[15:12] <= rev_cols;
        2'd1: pad[11:8] <= rev_cols;
        2'd2: pad[7:4] <= rev_cols;
        2'd3: pad[3:0] <= rev_cols;
		endcase
	
		state <= state + 2'd1; //Will overflow and cycle
	end
	
	genvar i;
	generate
		for (i = 0; i < 4; i = i + 1) begin : gen_rows
			assign rows[i] = (state == i ? 1'b0 : 1'bz);
		end
	endgenerate
	
	
endmodule
