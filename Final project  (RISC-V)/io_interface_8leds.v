module io_interface_8leds (
    input  wire [31:0] reg_data,       // coming from the processor
    output wire [7:0]  leds            // LEDs
);

    // mapping the lower 8 bits
    assign leds = reg_data[7:0];

endmodule