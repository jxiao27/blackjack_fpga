// Basically decodes the card from the card index

module CardDecoder (
    input  logic [5:0] card_value,  // 6-bit encoded card
    output logic [3:0] rank,        // Rank: 0-12 (Ace to King)
    output logic [1:0] suite        // Suit: 0-3 (Clubs, Diamonds, Hearts, Spades)
);

    always_comb begin 
        unique case (card_value % 13)
            0: rank = 4'd13; // King
            1: rank = 4'd1;  // Ace
            2: rank = 4'd2;  // 2
            3: rank = 4'd3;  // 3
            4: rank = 4'd4;  // 4
            5: rank = 4'd5;  // 5
            6: rank = 4'd6;  // 6
            7: rank = 4'd7;  // 7
            8: rank = 4'd8;  // 8
            9: rank = 4'd9;  // 9
            10: rank = 4'd10; // 10
            11: rank = 4'd11; // Jack
            12: rank = 4'd12; // Queen
            default: rank = 4'd0; // Invalid
        endcase  
    end

    always_comb begin
        unique case (card_value / 13)
            0: suite = 2'd0; // Clubs
            1: suite = 2'd1; // Diamonds
            2: suite = 2'd2; // Hearts
            3: suite = 2'd3; // Spades
            default: suite = 2'd0; // Invalid
        endcase
    end

endmodule