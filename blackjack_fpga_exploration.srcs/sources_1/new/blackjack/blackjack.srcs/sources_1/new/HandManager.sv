`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/11/2024 11:17:23 AM
// Design Name: 
// Module Name: HandManager
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module HandManager (
    input logic clk,
    input logic reset,
    input logic [5:0] new_card,    // New card to add
    input logic add_card,          // Signal to add the card
    output logic [7:0] hand_value, // Current hand value
    output logic bust              // Indicates if hand value > 21
);

    logic [5:0] hand [0:10];       // Maximum 11 cards (worst case: all Aces)
    logic [3:0] num_cards;         // Number of cards in hand
    logic [7:0] temp_value;        // Temporary value for summing

    // Add card to hand
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            num_cards <= 0;
            hand_value <= 0;
            bust <= 0;
        end else if (add_card) begin
            hand[num_cards] <= new_card;
            num_cards <= num_cards + 1;
        end
    end

    // Calculate hand value
    always_comb begin
        temp_value = 0;
        bust = 0;
        for (int i = 0; i < num_cards; i++) begin
            case (hand[i][3:0]) // Rank
                4'd0: temp_value += 11;              // Ace
                4'd1, 4'd2, 4'd3, 4'd4, 4'd5, 
                4'd6, 4'd7, 4'd8: temp_value += hand[i][3:0] + 1; // 2-10
                default: temp_value += 10;           // Jack, Queen, King
            endcase
        end

        // Adjust for Aces
        for (int i = 0; i < num_cards; i++) begin
            if (temp_value > 21 && hand[i][3:0] == 0) // Ace
                temp_value -= 10;
        end

        hand_value = temp_value;
        if (hand_value > 21)
            bust = 1;
    end
endmodule