module register ( clk , rst , data_in, load,  data_out);
input clk,rst,load;
input [7:0] data_in;
output reg [7:0] data_out;
always @(posedge clk) begin
    if (rst)
        data_out <= 8'b00000000;
    else if (load)
        data_out <= data_in;
    else
        data_out <= data_out;
end
endmodule 