module freq_gen(
    input CLOCK_50, input unsigned [15:0] freq_to_gen,
    output reg new_clk
);
    wire unsigned [31:0] to_count;
	 assign to_count = 50_000_000 / (freq_to_gen * 2);
	 

    reg [31:0] counter;
    always @(posedge CLOCK_50)
    begin
        if (counter == to_count)
        begin 
            new_clk <= ~new_clk;
            counter <= 0;
        end
        else
        begin
            new_clk <= new_clk;
            counter <= counter + 1;
        end
    end

endmodule