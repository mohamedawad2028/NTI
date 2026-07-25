module debouncing_circuit ( clk, rst , sw , db );
parameter   zero =3'b000;
parameter wait1_1=3'b001;
parameter wait1_2=3'b010;
parameter wait1_3=3'b011;
parameter    one =3'b100;
parameter wait0_1=3'b101;
parameter wait0_2=3'b110;
parameter wait0_3=3'b111;
input clk, rst , sw;
output reg db ;
reg m_tick;
reg [2:0] cs,ns;
reg [9:0] counter_tick;

always @(posedge clk or posedge rst) begin
	if (rst) begin
		cs<=zero;
		counter_tick<=10'd0;
		m_tick<=0;
	end
	else begin
		cs<=ns;
		if (counter_tick==10'd999) begin
			m_tick<=1;
			counter_tick<=10'd0;
		end
		else begin
				counter_tick<=counter_tick+1;
				m_tick<=0;
		end
	end
end

always @(*) begin
	case(cs)
		zero:
			if (~sw) begin
				ns=cs;
			end
			else begin
				ns=wait1_1;
			end
		wait1_1:
			if (~sw) begin
				ns=zero;
			end
			else if(sw==1 && m_tick==1) begin
				ns=wait1_2;
			end
			else if (sw==1 && m_tick==0) begin
				ns=cs;
			end	
			else begin
				ns=cs;
			end		
		wait1_2:
			if (~sw) begin
				ns=zero;
			end
			else if(sw==1 && m_tick==1) begin
				ns=wait1_3;
			end
			else if (sw==1 && m_tick==0) begin
				ns=cs;
			end	
			else begin
				ns=cs;
			end
		wait1_3:
			if (~sw) begin
				ns=zero;
			end
			else if(sw==1 && m_tick==1) begin
				ns=one;
			end
			else if (sw==1 && m_tick==0) begin
				ns=cs;
			end	
			else begin
				ns=cs;
			end
		one:
			if (sw) begin
				ns=cs;
			end
			else begin
				ns=wait0_1;
			end
		wait0_1:
			if (sw) begin
				ns=one;
			end
			else if(sw==0 && m_tick==1) begin
				ns=wait0_2;
			end
			else if (sw==0 && m_tick==0) begin
				ns=cs;
			end	
			else begin
				ns=cs;
			end
		wait0_2:
			if (sw) begin
				ns=one;
			end
			else if(sw==0 && m_tick==1) begin
				ns=wait0_2;
			end
			else if (sw==0 && m_tick==0) begin
				ns=cs;
			end	
			else begin
				ns=cs;
			end
		wait0_3:
			if (sw) begin
				ns=one;
			end
			else if(sw==0 && m_tick==1) begin
				ns=zero;
			end
			else if (sw==0 && m_tick==0) begin
				ns=cs;
			end	
			else begin
				ns=cs;
			end
	endcase
end

always @(*) begin
	if ( cs==one || cs==wait0_1 || cs==wait0_2 || cs==wait0_3 ) begin
		db=1;
	end
	else begin
		db=0;
	end
end
endmodule