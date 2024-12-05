`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: The Honorable 233?
// Engineer: Jimmy Xiao
// 
// Create Date: 11/27/2024 02:30:40 PM
// Design Name: ???
// Module Name: Blackjack_Main
// Project Name: Blackjack FPGA Project
// Target Devices: 
// Tool Versions: 
// Description: idk
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Blackjack_Main(
    input btnC,
    input clk,
    output [6:0] seg,
    output [3:0] an
    );
    
wire [7:0] hand_val;
wire [3:0] ones;
wire [3:0] tens;
wire [3:0] curr_dig;

wire digit_up;

assign digit_up = (ones == 9);

HandValue hand_hold(clk, btnC, hand_val);
BCDToLED seg_gen(curr_dig, hand_val, seg);
DisplayRotator dis_rot(clk, ones, tens, an, curr_dig);

DigitConv one_to_ten(clk, , digit_up, , tens);

endmodule
