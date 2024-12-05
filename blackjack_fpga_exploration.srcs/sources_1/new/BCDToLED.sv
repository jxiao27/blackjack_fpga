`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/29/2024 09:17:52 PM
// Design Name: 
// Module Name: BCDToLED
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


module BCDToLED(
    input  [3:0] dig, // digit binary value
    input  [7:0] hand_val, //hand val decimal
    output reg [6:0] seg // segments
    );
    
wire w, x, y, z;
assign w = dig[3];
assign x = dig[2];
assign y = dig[1];
assign z = dig[0];
    
wire bust;
assign bust = hand_val > 21;
always @(*) begin
    if(bust) begin
    // seg A 
    seg[0] = (x & ~y & ~z) | (~w & ~x & ~y & z);
    
    // seg B: modify above, not here
    seg[1] = (x & ~y & z) | (x & y & ~z);
    
    // seg C: modify above, not here
    seg[2] = (~x & y & ~z);
    
    // seg D
    seg[3] = (x & ~y & ~z) | (~w & ~x & ~y & z) | (x & y & z);
    
    // seg E
    seg[4] = (x & ~y) | z;
    
    // seg F
    seg[5] = (y & z) | (~x & y) | (~w & ~x & z);
    
    // seg G
    seg[6] = (~w & ~x & ~y) | (x & y & z);
    end else begin
      
      case(dig)
      
        4'b1010: begin
            seg[0] = 1;
            seg[1] = 1;
            seg[2] = 1;
            seg[3] = 1;
            seg[4] = 0;
            seg[5] = 0;
            seg[6] = 0;
        end
        
        4'b1011: begin
            seg[0] = 0;
            seg[1] = 1;
            seg[2] = 0;
            seg[3] = 0;
            seg[4] = 1;
            seg[5] = 0;
            seg[6] = 0;
        end
        
        4'b1100: begin
            seg[0] = 1;
            seg[1] = 1;
            seg[2] = 0;
            seg[3] = 0;
            seg[4] = 0;
            seg[5] = 1;
            seg[6] = 1;
        end
        
        4'b1101: begin
            seg[0] = 1;
            seg[1] = 1;
            seg[2] = 0;
            seg[3] = 0;
            seg[4] = 0;
            seg[5] = 0;
            seg[6] = 0;
        end
      endcase
    end
end 
    
endmodule
