`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: The Honorable 233?
// Engineer: Jet Geronimo
// 
// Create Date: 12/09/2024 10:11:40 PM
// Design Name: ???
// Module Name: Blackjack_Main
// Project Name: Blackjack FPGA Project
// Target Devices: 
// Tool Versions: 
// Description: Finite state machine that dictates the current state of
// the Blackjack game. The INIT state denotes the beginning of the hand, where
// neither player has cards. The states PLAYER_TURN and DEALER_TURN dictate
// who the current action is on.
//
// Dependencies: 
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////


module BlackjackFSM (
    input logic clk,
    input logic reset,
    input logic hit,            // Player action: hit
    input logic stand,          // Player action: stand
    input logic [5:0] new_card, // Random card input
    output logic [7:0] player_hand_value,
    output logic [7:0] dealer_hand_value,
    output logic player_bust,
    output logic dealer_bust,
    output logic [2:0] state
);

    // State encoding
    typedef enum logic [2:0] {
        INIT = 3'b000,
        PLAYER_TURN = 3'b001,
        DEALER_TURN = 3'b010,
        PLAYER_BUST = 3'b011,
        DEALER_WIN = 3'b100,
        PLAYER_WIN = 3'b101,
        RESET = 3'b110
    } state_t;

    state_t current_state, next_state;
    wire [7:0] dhv, phv;
    wire db, pb;
    
    assign state = current_state;
    assign dealer_hand_value = dhv;
    assign player_hand_value = phv;
    assign dealer_bust = db;
    assign player_bust = pb;
    // Player and dealer instances
    logic add_card_player, add_card_dealer;
    Player player (
        clk,
        reset,
        new_card,
        add_card_player,
        phv,
        pb
    );

    Dealer dealer (
        clk,
        reset,
        new_card,
        add_card_dealer,
        dhv,
        db
    );

    // FSM state transitions
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= INIT;
        else
            current_state <= next_state;
    end

    always_comb begin
        // Default assignments
        next_state = current_state;
        add_card_player = 0;
        add_card_dealer = 0;

        case (current_state)
            INIT: begin
                add_card_player <= 1;
                next_state <= PLAYER_TURN;
            end

            PLAYER_TURN: begin
                if (hit) begin
                    add_card_player <= 1;
                    if (player_bust)
                        next_state <= PLAYER_BUST;
                end else if (stand) begin
                    next_state <= DEALER_TURN;
                end
            end

            DEALER_TURN: begin
                if (dealer_hand_value <= player_hand_value && !dealer_bust) begin
                    add_card_dealer <= 1;
                end else if (dealer_bust || dealer_hand_value > player_hand_value) begin
                    if (dealer_bust || player_hand_value > dealer_hand_value)
                        next_state <= PLAYER_WIN;
                    else
                        next_state <= DEALER_WIN;
                end
            end

            PLAYER_BUST: begin
                // Possibly show 'BUST' on the seven-segment display here
                next_state <= RESET;
            end

            DEALER_WIN: begin
                // Possibly show 'LOSE' on the seven-segment display here
                next_state <= RESET;
            end

            PLAYER_WIN: begin
                // Possibly show 'WIN!' on the seven-segment display here
                next_state <= RESET;
            end

            RESET: begin
                next_state <= INIT;
            end

            default: next_state <= RESET;
        endcase
    end
endmodule

