`ifndef macros_sv
`define macros_sv
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/11/2024 04:09:29 AM
// Design Name: 
// Module Name: DisplayMacros
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

`define INIT 3'b000;
`define PLAYER_TURN 3'b001;
`define DEALER_TURN 3'b010;
`define PLAYER_BUST 3'b011;
`define DEALER_WIN 3'b100;
`define PLAYER_WIN 3'b101;
`define RESET 3'b110;

`define seg_b 7'b1100000;
`define seg_u 7'b1000001;
`define seg_s 7'b0100100;
`define seg_t 7'b1110000;

`define seg_w 7'b0000110;
`define seg_i 7'b1001000;
`define seg_n 7'b0010010;
`define seg_exc 7'b1110111;

`define seg_l 7'b1110001;
`define seg_o 7'b0000001;
//`define seg_s = 7'b0100100; defined above but placed here for my sanity
`define seg_e 7'b0110000;

`define led_on  16'b1111111111111111;
`define led_off 16'b0000000000000000;
`endif