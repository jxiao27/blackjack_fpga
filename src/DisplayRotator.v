module DisplayRotator(
    input            clk,
    input            showUpperBits, // toggles whether to show MM:SS or SS:hh
    input      [3:0] digit0,
    input      [3:0] digit1,
    input      [3:0] digit2,
    input      [3:0] digit3,
    input      [3:0] digit4,
    input      [3:0] digit5,
    output reg [3:0] an,
    output reg       dpEnable,
    output reg [3:0] digitToDisplay
);

reg [12:0] counter = 13'b0;


// YOU SHOULD NOT NEED TO EDIT THIS ALWAYS BLOCK

always @(posedge clk) begin
  counter <= counter + 1;
end


// YOU SHOULD EDIT ONLY THE digitToDisplay LINES BELOW

always @(*) begin
  case(counter[12:11])
    2'b00: begin
      an <= 4'b1110;
      digitToDisplay <= (showUpperBits ? digit2 : digit0); //digit0 (orig input)
      dpEnable <= (showUpperBits ? 1'b0 : 1'b1);
    end
    2'b01: begin
      an <= 4'b1101;
      digitToDisplay <= (showUpperBits ? digit3 : digit1); //digit1 (orig input)
      dpEnable <= 1'b1;
    end
    2'b10: begin
      an <= 4'b1011;
      digitToDisplay <= (showUpperBits ? digit4 : digit2); //digit2 (orig input)
      dpEnable <= (showUpperBits ? 1'b1 : 1'b0);
    end
    2'b11: begin
      an <= 4'b0111;
      digitToDisplay <= (showUpperBits ? digit5 : digit3); //digit3 (orig input)
      dpEnable <= 1'b1;
    end
  endcase
end

endmodule