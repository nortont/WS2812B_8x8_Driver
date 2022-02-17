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
    reg [23:0] data;
    wire clkOut1;
    wire led_data;
    wire clkOut1;
    
    Top uut(
    .data(data),
    .led_data(led_data),
     .clkOut1(clkOut1),
      .clkOut2(clkOut1),
       .sys_clock (sys_clock)
       
       );
       
        /*
     * Generate a 20Mhz (50ns) clock 
     */
    always begin
        clk = 1; #8;
        clk = 0; #8;
   
        if (cts) begin
            data = 24'b000000000000000000000000;
        end 
    
    end

endmodule
