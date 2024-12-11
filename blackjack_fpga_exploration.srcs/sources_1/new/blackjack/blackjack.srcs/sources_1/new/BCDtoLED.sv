module BCDtoLED(
    input  [3:0] sw,  // binary input from switches
    output [6:0] seg, // segments
    output [3:0] an   // display specific anodes
);

// assign switches to w/x/y/z to make it easier to write your logic

wire w, x, y, z;
assign w = sw[3];
assign x = sw[2];
assign y = sw[1];
assign z = sw[0];


// segment B: provided logic - debug and fix if needed; 
// DO NOT REPLACE THEM WITH YOUR OWN LOGIC

wire not_w, not_x, not_y, not_z;
wire segb, segb_a0, segb_a1, segb_a2, segb_b0, segb_b1, segb_b2; // you may need some/all/more of these

not segb_not0(not_y, y);
not segb_not1(not_z, z);
and segb_and0(segb_a0, x, not_y); 
and  segb_and1 (segb_a1, segb_a0, z);
and segb_and2(segb_b0, x, y); 
and  segb_and3 (segb_b1, segb_b0, not_z);
or  segb_or2 (segb, segb_a1, segb_b1); 


// segment C: provided logic - debug and fix if needed; 
// DO NOT REPLACE THEM WITH YOUR OWN LOGIC

wire segc, segc_a0, segc_a1; // you may need some/all/more of these

not segc_not0(not_x, x);
and segc_and0(segc_a0, not_x, y);
and segc_and1(segc, segc_a0, not_z);


// assign seg outputs here (you may use logical expressions for all segments EXCEPT B/C)

// seg A 
assign seg[0] = (x & ~y & ~z) | (~w & ~x & ~y & z);

// seg B: modify above, not here
assign seg[1] = segb;

// seg C: modify above, not here
assign seg[2] = segc;

// seg D
assign seg[3] = (x & ~y & ~z) | (~w & ~x & ~y & z) | (x & y & z);

// seg E
assign seg[4] = (x & ~y) | z;

// seg F
assign seg[5] = (y & z) | (~x & y) | (~w & ~x & z);

// seg G
assign seg[6] = (~w & ~x & ~y) | (x & y & z);


// assign anode output here: you need to assign all bits of an correctly
assign an[3] = 0;
assign an[2] = 1;
assign an[1] = 1;
assign an[0] = 0;


endmodule