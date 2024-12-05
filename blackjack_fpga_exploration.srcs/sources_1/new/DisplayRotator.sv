`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/29/2024 10:34:20 PM
// Design Name: 
// Module Name: DisplayRotator
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


module DisplayRotator(
    input            clk,
    input      [3:0] digit0,
    input      [3:0] digit1,
    output reg [3:0] an,
    output reg [3:0] digit_to_show
    );

reg [12:0] counter = 13'b0;

wire bust = ( (digit0 >= 2) & (digit1 == 2) ) | (digit1 >= 3); //if the decimal hand val >= 21, bust = 1
always @(posedge clk) begin
  counter <= counter + 1;
end

always @(*) begin
  case(counter[12:11])
  
    2'b00: begin
      an <= 4'b1110;
      digit_to_show <= (bust ? 4'b1010 : digit0); //any digit value >= 10 is a special sentinel value for BCDToLED
    end
    
    2'b01: begin
      an <= 4'b1101;
      digit_to_show <= (bust ? 4'b1011 : digit1);
    end
    
    2'b10: begin
      if(bust) begin
        an <= 4'b1011;
        digit_to_show <= 4'b1100; //1110 is a special value used in a boolean condition in BCDToLED
      end else begin
        an <= 4'b1111;
      end
    end
    
    2'b11: begin
      if(bust) begin
        an <= 4'b0111;
        digit_to_show <= 4'b1101;
      end else begin
        an <= 4'b1111;
      end
    end
  
  endcase
end

endmodule
