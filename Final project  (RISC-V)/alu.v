module ALU( a , b , alu_ctrl , result , zero);
parameter Dwidth=32;
parameter Swidth=4;

input [Dwidth-1:0] a,b;
input [Swidth-1:0] alu_ctrl;
output reg [Dwidth-1:0] result;
output reg zero;

		
localparam ADD            =4'b0000;
localparam subtract       =4'b0001;
localparam XOR            =4'b0010;
localparam OR             =4'b0011;
localparam AND            =4'b0100;
localparam ALU_SRL        =4'b0101;
localparam ALU_SLL        =4'b0110;
localparam XNOR           =4'b0111;
localparam ALU_SLT        =4'b1011;
localparam ALU_SRA        =4'b1100;
localparam ALU_SLA        =4'b1101;
localparam ALU_PASS_a     =4'b1110;
localparam ALU_PASS_b     =4'b1111;

always @(*) begin
	case(alu_ctrl)
		ADD:             result = a+b;
		subtract:        result = a-b;
		XOR:             result = a^b;
		OR:              result = a|b;
		AND:             result = a&b;
		ALU_SRL :        result = a>>b[Swidth:0];
		ALU_SLL :        result = a<<b[Swidth:0];
		XNOR:            result = a~^b;
		ALU_SLT  :       result = ($signed(a)<$signed(b))? 1 : 0;
		ALU_SRA:         result = $signed(a)>>>b[Swidth:0];
		ALU_SLA:         result = a<<<b[Swidth:0];
        ALU_PASS_a:      result = a;
        ALU_PASS_b:      result = b;
		default:         result = {Dwidth{1'b0}};
	endcase
	if (result=={Dwidth{1'b0}}) begin
		zero=1;
	end
	else begin
		zero=0;
	end
end
endmodule