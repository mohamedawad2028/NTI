module io_interface_7seg (
    input  wire [31:0] reg_data,  // coming from the processor
    output reg [7:0]  leds       // 7 segments leds
);

    wire [3:0] hex_digit;
    
    // lower 4 bits to display as a single Hex digit
    assign hex_digit = reg_data[3:0]; 

    always @(*) begin
        // display the 4-bit number using a 7-segment display pattern
        case (hex_digit)
            4'h0: leds = 8'b1100_0000;
            4'h1: leds = 8'b1111_1001;
            4'h2: leds = 8'b1010_0100;
            4'h3: leds = 8'b1011_0000;
            4'h4: leds = 8'b1001_1001;
            4'h5: leds = 8'b1001_0010;
            4'h6: leds = 8'b1000_0010;
            4'h7: leds = 8'b1111_1000;
            4'h8: leds = 8'b1000_0000;
            4'h9: leds = 8'b1001_0000;
            4'hA: leds = 8'b1000_1000;
            4'hB: leds = 8'b1000_0011;
            4'hC: leds = 8'b1100_0110;
            4'hD: leds = 8'b1010_0001;
            4'hE: leds = 8'b1000_0110;
            4'hF: leds = 8'b1000_1110;
            default: leds = 8'b1111_1111; // turned off the 7-segment
        endcase
    end

endmodule