`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/10/2024 04:54:05 PM
// Design Name: 
// Module Name: Master_FSM
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


module Master_FSM(
    input          clk,        //system clock
    input          btnC,       //hit button
    input          btnD,       //stand button
    input          btnU,       //reset button
    output  [6:0]  seg,        //segments to show
    output  [3:0]  an,         //anode to show on
    output  [15:0] led,        //led
    output         dp          //decpoint
    );

wire [5:0] new_card;
wire [7:0] player_hand_value, dealer_hand_value;
wire [2:0] state;
wire [3:0] rank;
wire [15:0] BCD_hand;
wire reset, hit, stand, deck_empty, dealer_bust, player_bust;
assign reset = btnU;

ButtonHandler hit_handler(clk, reset, btnC, hit);
ButtonHandler stand_handler(clk, reset, btnD, stand);

generateCard card_generator(clk, reset, 6'd25, new_card, deck_empty);
CardDecoder  decode_card(new_card, rank, );
BlackjackFSM gamelogic(clk, reset, hit, stand, new_card, player_hand_value, dealer_hand_value, player_bust, dealer_bust, state);

DisplayHandler display(clk, reset, player_hand_value, rank, state, seg, an, led, dp);

endmodule

