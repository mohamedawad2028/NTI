module behavioral(A,B,S,Ci,Co);
input A,B,Ci;
output reg S,Co;
reg Z,Y,W;
always @(*) begin
 Z=A^B;
 Y=A&B;
 S= Z^Ci;
 W=Z & Ci;
 Co=W|Y;	
end
endmodule


module gate_level(A,B,S,Ci,Co);
input A,B,Ci;
output S,Co;
wire Z,Y,W;
xor G1(Z,A,B);
and G2(Y,A,B);
xor G3(S,Z,Ci);
and G4(W,Z,Ci);
or G5(Co,W,Y);
endmodule

// module sum (A,B,Ci,S);
// input A,B,Ci;
// output S;
// assign S=A^B^Ci;
// endmodule


// module Carry (A,B,Ci,Co);
// input A,B,Ci;
// output S;
// wire Z,Y,W;
// assign Z=A^B;
// assign W=Z&Ci;
// assign Y=A&B;
// endmodule
module structural(A,B,S,Ci,Co);
input A,B,Ci;
output S,Co;

 sum stuc_sum(.A(A) ,.B(B) ,.Ci(Ci) ,.S(S) );
 Carry stuc_Carry(.A(A),.B(B) ,.Ci(Ci),.Co(Co));

endmodule