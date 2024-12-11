`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/10/2024 10:24:33 PM
// Design Name: 
// Module Name: DisplayHandler
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

`include "DisplayMacros.vh"

module DisplayHandler(
    input         clk,
    input         reset,
    input logic  [7:0]  player_hand_value,
    input logic  [3:0]  rank,
    input logic  [2:0]  state,
    output logic [6:0]  seg,
    output logic [3:0]  an,
    output logic [15:0] led,
    output logic        dp
    );
logic [15:0] BCD;
    
BINtoBCD bcd_conv( {6'b0, hand_val}, BCD );
BCDtoLED led_conv( curr_digit, dig_seg );

reg [12:0] counter = 13'b0;
logic [3:0]  curr_digit = 4'b0000;

always @(posedge clk or posedge reset) begin
    if(reset) begin
        counter <= 13'b0;
        seg     <= 7'b1111111;
        an      <= 4'b1111;
        dp      <= 7'b1;
    end else 
        counter <= counter + 1;
        seg     <= 7'b0000000;
end


always @(*) begin
    case(counter[12:11])
     //ANODE[3]
     2'b00: begin
       an <= 4'b1110;
       curr_digit  <= BCD[3:0];
       if          (state == 3'b100) begin
         led[15:0] <= 16'b0000000000000000;
         seg[6:0]  <= 7'b1110000;
         dp        <= 1'b1;
       end else if (state == 3'b001) begin
         led[15:0] <= 16'b1111111111111111;
         seg[6:0]  <= 7'b1110111;
         dp        <= 1'b0;
       end else if (state == 3'b010) begin
         led[15:0] <= 16'b0000000000000000;
         seg[6:0]  <= 7'b0110000;
         dp        <= 1'b0;
       end else begin
         led[15:0] <= 16'b0000000000000000;
         seg[6:0]  <= dig_seg;
         dp        <= 1'b0;
       end
     end
     
     //ANODE[2]
     2'b01: begin     
       an <= 4'b1101;
       curr_digit  <= BCD[7:4];
       if          (state == 3'b100) begin
         led[15:0] <= 16'b0000000000000000;
         seg[6:0]  <= 7'b0100100;
         dp        <= 1'b0;
       end else if (state == 3'b001) begin
         led[15:0] <= 16'b1111111111111111;
         seg[6:0]  <= 7'b0010010;
         dp        <= 1'b0;
       end else if (state == 3'b010) begin
         led[15:0] <= 16'b0000000000000000;
         seg[6:0]  <= 7'b0100100;
         dp        <= 1'b0;
       end else begin
         led[15:0] <= 16'b0000000000000000;
         seg[6:0]  <= dig_seg;
         dp        <= 1'b0;
       end
     end
     
     //ANODE[1]
     2'b10: begin
       an <= 4'b1011;
       curr_digit  <= 4'b0000;
       if          (state == 3'b100) begin
         led[15:0] <= 16'b0000000000000000;
         seg[6:0]  <= 7'b1000001;
         dp        <= 1'b0;
       end else if (state == 3'b001) begin
         led[15:0] <= 16'b1111111111111111;
         seg[6:0]  <= 7'b1001000;
         dp        <= 1'b0;
       end else if (state == 3'b010) begin
         led[15:0] <= 16'b0000000000000000;
         seg[6:0]  <= 7'b0000001;
         dp        <= 1'b0;
       end else begin
         led[15:0] <= 16'b0000000000000000;
         seg[6:0]  <= dig_seg;
         dp        <= 1'b0;
       end
     end
     
     //ANODE[0]
     2'b11: begin
       an <= 4'b0111;
       curr_digit  <= rank;
       if          (state == 3'b100) begin
         led[15:0] <= 16'b0000000000000000;
         seg[6:0]  <= 7'b1100000;
         dp        <= 1'b0;
       end else if (state == 3'b001) begin
         led[15:0] <= 16'b1111111111111111;
         seg[6:0]  <= 7'b0000110;
         dp        <= 1'b0;
       end else if (state == 3'b010) begin
         led[15:0] <= 16'b0000000000000000;
         seg[6:0]  <= 7'b1110001;
         dp        <= 1'b0;
       end else begin
         led[15:0] <= 16'b0000000000000000;
         seg[6:0]  <= dig_seg;
         dp        <= 1'b0;
       end
      end
     endcase
end

endmodule
