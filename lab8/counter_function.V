module counter ( clk , rst , cnt_in , enab , load , cnt_out);
input clk,rst, enab,load;
input [4:0] cnt_in;
output [4:0] cnt_out;

function [4:0] next_count;
    input [4:0] current_count;
    input [4:0] load_value;
    input en;
    input ld;

    begin
        if (ld)
            next_count = load_value;
        else if (en)
            next_count = current_count + 1;
        else
            next_count = current_count;
    end
endfunction

always @(posedge clk or posedge rst) begin
    if (rst)
        cnt_out <= 5'd0;
    else
        cnt_out <= next_count(cnt_out, cnt_in, enab, load);
end



endmodule 