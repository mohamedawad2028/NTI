module program_counter (
input wire 			  clk,
input wire 			  rstn,
input wire [31:0]  pc_next,
output reg [31:0]   pc_out
);

always @ (posedge clk ) begin 

if(!rstn) begin
pc_out <= 'b0;
end

else begin 
pc_out <= pc_next;
end
end
endmodule