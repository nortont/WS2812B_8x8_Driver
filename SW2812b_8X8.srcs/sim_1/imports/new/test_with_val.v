`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.02.2022 17:03:32
// Design Name: 
// Module Name: test_with_val
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module test_with_val;
    reg sys_clock;
    reg [23:0]data;
    wire clkOut1;
    wire led_data;
    wire clkOut2;
    
    WS2812B_64_LED_Driver uut(
    
       
       .clk(sys_clock),
    .dataIn(data),
    .serialOut(led_data ),
    .clearToSend(clkOut1),
    .clk_50ns(clkOut2), //20Mhz
    .reset(1'b0)
       );
       
        /*
     * Generate a 20Mhz (50ns) clock 
     */
    always begin
        sys_clock = 1; #4;
        sys_clock = 0; #4;
   
   
        if (clkOut1) begin
            data = 24'hf0f0f0;
        end 
    
    end

endmodule
