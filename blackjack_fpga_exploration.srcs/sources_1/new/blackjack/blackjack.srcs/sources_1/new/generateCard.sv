// Module to generate a Random Number between 1 and 52 (Both inclusive)

module generateCard(
    input   logic           clock,
    input   logic           reset,
    input   logic   [5:0]   seed_value,                 // random value between 0 and 63
    output  logic   [5:0]   card_value,
    output  logic           deck_empty
);

logic   [51:0]  deck;
logic   [5:0]   card_ind;
// using linear feedback shift thing
logic  [5:0]   lfsr;
always_ff @(posedge clock or posedge reset) begin
    if (reset)
        lfsr <= seed_value;
    else
        lfsr <= {lfsr[4:0], lfsr[5] ^ lfsr[3]};         // Example LFSR polynomial
    end


// Generation
always_ff @(posedge clock or posedge reset) begin
    if (reset) begin
        deck <= 52'hFFFFFFFFFFFFF;                      // Set all cards unused
        deck_empty <= 1'b0;                             // Deck is not empty
    end else if (!deck_empty) begin
        card_ind = lfsr % 52;                           // Ensure index is within valid range
        if (card_ind >= 52) //card_ind = card_ind - 52;   // Adjust if out of range
  //          while (!deck[card_ind])     
                card_ind = (card_ind + 1) % 52;
            deck[card_ind] <= 1'b0;                     // Mark the card as used
            card_value <= card_ind;                     // Return the card
            deck_empty <= (deck == 0);                  // Check if deck is empty
        deck_empty <= (deck == 52'b0);                  // Check if deck is empty
    end else 
        deck <= 52'h0000000000000;
        card_ind = 6'b111111;                           // Return invalid card

end

endmodule