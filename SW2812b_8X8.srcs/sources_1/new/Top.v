`timescale 1ns / 1ps

module top(       
        output led_data,
        output clkOut1,
        output clkOut2,
        input sys_clock
//        input reset;
 //       input [23:0] data
        );
         
        
        WS2812B_64_LED_Driver dirver(
            .dataIn(24'b011100000000000000000000),
            .serialOut(led_data),
            .clearToSend(clkOut1 ),
            .clk_50ns(clkOut2 ), //20Mhz
            .reset(1'b0), // held low
            .clk(sys_clock)
            
            );

        
endmodule
