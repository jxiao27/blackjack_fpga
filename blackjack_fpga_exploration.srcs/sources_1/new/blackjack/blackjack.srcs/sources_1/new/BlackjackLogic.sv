`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/11/2024 11:19:16 AM
// Design Name: 
// Module Name: BlackjackLogic
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


module BlackjackLogic (
    input logic clk,
    input logic reset,
    input logic player_hit,
    input logic player_stand,
    output logic [7:0] player_hand_value,
    output logic player_bust,
    output logic [7:0] dealer_hand_value,
    output logic dealer_bust,
    output logic game_over,
    output logic player_win
);

    // Internal signals
    logic [5:0] random_card;
    logic add_card_to_player, add_card_to_dealer;
    logic dealer_hit;
    logic deck_empty;

    // Instantiate RandomCardGenerator
    generateCard card_gen (
        .clock(clk),
        .reset(reset),
        .seed(5'd25),
        .card(random_card),
        .deck_empty(deck_empty)
    );

    // Instantiate Player HandManager
    HandManager player_hand (
        .clk(clk),
        .reset(reset),
        .new_card(random_card),
        .add_card(add_card_to_player),
        .hand_value(player_hand_value),
        .bust(player_bust)
    );

    // Instantiate Dealer HandManager
    HandManager dealer_hand (
        .clk(clk),
        .reset(reset),
        .new_card(random_card),
        .add_card(add_card_to_dealer),
        .hand_value(dealer_hand_value),
        .bust(dealer_bust)
    );

    // Dealer Logic
    DealerLogic dealer_logic (
        .hand_value(dealer_hand_value),
        .bust(dealer_bust),
        .hit(dealer_hit)
    );

    // Game Control Logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            add_card_to_player <= 0;
            add_card_to_dealer <= 0;
            game_over <= 0;
            player_win <= 0;
        end else begin
            if (player_hit && !player_bust)
                add_card_to_player <= 1;
            else
                add_card_to_player <= 0;

            if (player_stand || player_bust) begin
                if (dealer_hit && !dealer_bust)
                    add_card_to_dealer <= 1;
                else
                    add_card_to_dealer <= 0;

                game_over <= dealer_bust || (!dealer_hit && !dealer_bust);
                player_win <= (player_hand_value > dealer_hand_value && !player_bust) || dealer_bust;
            end
        end
    end
endmodule
