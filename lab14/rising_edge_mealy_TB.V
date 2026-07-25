module rising_edge_tb();
reg clk,rst,level;
wire tick_tb;
integer i=0;

rising_edge_mealy tb1( .clk(clk) , .rst(rst) , .level(level) , .tick(tick_tb) );

initial begin
	clk=0;
	forever
	#1 clk=~clk;
end

initial begin
$monitor ("rst=%b,clk=%b,level=%b,tick_tb=%b,rst,clk,level,tick_tb");
end

initial begin
	rst=1;
	level=0;
	@(negedge clk);
	rst=0;
	for (i=0;i<20;i=i+1) begin
		level=$random;
		@(negedge clk);
	end
	$stop;
end
endmodule