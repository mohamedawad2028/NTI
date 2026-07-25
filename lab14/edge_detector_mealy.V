module rising_edge_mealy(clk,rst,level,tick);
parameter ZERO=1'b0;
parameter ONE=1'b1;
input clk,rst,level;
output reg tick;
reg cs,ns;

always @(posedge clk or posedge rst) begin
	if (rst) begin
		cs<=ZERO;
	end
	else begin
		cs<=ns;
	end
end

always @(*) begin
	case(cs)
		ZERO:
			if (level) begin
				ns=ONE;
			end
			else begin
				ns=cs;
			end
		ONE:
			if (level) begin
				ns=cs;
			end
			else begin
				ns=ZERO;
			end
		default:
			ns=ZERO;			
	endcase
end

always @(*)begin
	if (level==0&&cs==ZERO) begin
		tick=0;
	end
	else if (level==1&&cs==ONE) begin
		tick=1;
	end
	else begin
		tick=0;
	end
end
endmodule