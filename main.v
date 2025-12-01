module main(
    ...
);

    [15:0] keys = keyboard_reader()
    tone_player(keys)

    game_clock // Clock controlling game progression
    game_frame // init: 0 ; game_frame += 1 ON game_clock posedge
    game_map // Row = individual note
        // 16 bit : ****----######## : * = note identifier, - = how long, # = when it starts
    state //matrix of pixel values
        // 12 x 16, each spot 0 or 1 to indicate pixel position
    score //12bit num

    engine(game_map, state, game_frame) //updates state by reading from game_map
        //Top row determined by game_map 
        //Subsequent rows determined by previous row
    display(state) //800 MHz stream
        //1250ns per bit  ; 0 = high 400ns, low 850ns & 1 = high 800ns, low 450ns
        //Reset = low >50us  
    scorer(keys, state[bottom_row], score)
        //state[bottom_row] == keys ? score += 10 : score = score
    hex_display(score)


endmodule