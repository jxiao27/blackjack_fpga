`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/29/2024 10:17:20 PM
// Design Name: 
// Module Name: HandValue
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


module HandValue(
    input clk,
    input btn,
    output reg [7:0] hand_val
    );
    
always @(posedge clk) begin
   if(btn)
   hand_val <= hand_val + 1
;  
end

endmodule
