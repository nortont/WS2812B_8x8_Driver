`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Nortronics
// Engineer: Tim Norton
// 
// Create Date: 10.02.2022 11:50:22
// Design Name: WS2812B bit timing
// Module Name: bitSerialTranslation
// Project Name: WS2812B 8X8 Matrix
// Target Devices: 
// Tool Versions: 
// Description: Recieves a hi or low and translates it to timing requirements for WS2812
// - A bit is 1250ns
// - One is indicated by: 800ns high, 450ns low
// - Zero is indicated by: 400ns high, 850ns low 
// 
// need to specify the number of LED's - 64 is default

// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// - clk is 50ns/20Mhz
// 
//////////////////////////////////////////////////////////////////////////////////



module WS2812B_64_LED_Driver(
    input clk,
    input  [23:0] dataIn,
    output   serialOut,
    output   clearToSend,
    output  clk_50ns, //20Mhz
    input reset
);


    // timing values in nanoseconds
    localparam    [5:0] t_clk = 50; // clock period ns
    localparam    [4:0] t_period = 1250 / t_clk; // 1 bit period ns
    localparam    [4:0] t_1hi = 700 / t_clk; // 1 hi bit period ns
    localparam    [4:0] t_1lo = 700 / t_clk; // 1 low bit period ns
    localparam    [4:0] t_0hi = 300 / t_clk; // 1 hi bit period ns
    localparam    [4:0] t_0lo = 700 / t_clk; // 1 low bit period ns
    localparam    [16:0] t_reset = 2900000 / t_clk; // reset period ns

    // LED's and bit tracking
    localparam    [6:0] led_count = 64; // number of WS2812 LED's in the string     
    localparam    [5:0] bit_count = 24; // number of bits in RGB bit pattern

    // FSM states
    //localparam    S_initialise= 0; // runs on initialise
    localparam    [1:0] S_start_cycle = 1; // Starting from first LED
    localparam    [1:0] S_rx_rgb = 2; // Get colour bit pattern
    localparam    [1:0] S_get_bit = 3; // process bit from MSB
    localparam    [2:0] S_output_hi = 4; // Set output high
    localparam    [2:0] S_output_low = 5; // Set output low
    localparam    [2:0] S_led_position = 6; // Increment to next LED
    localparam    [2:0] S_reset_delay = 7; // End of 64 string timing

    reg [4:0] t_period_hi_count ; // count 1st half of pulse (max count 25)
    reg [16:0] t_period_low_count ; // count 2nd half of pulse (max count 25)
    reg  CTS ; // Clear to send initially high (ready)
    reg [23:0] data_rx; // store a copy of the incoming data
    reg  data_out ; // data out initially low
    reg [3:0] state, next_state ; // state machine for each step
    reg [6:0] led_pos; // current LED in the string  
    reg [5:0] bit_pos; // current bit position in RGB bit bit_count
    reg  bit_current; // store the current bit value from data_rx
    reg  [5:0] tmp;
    // clock divider 
    reg    [5:0] clkCount=0;
    reg    clkTick=0;

    initial begin // initiallise variables at time 0
        CTS = 1'b1;
        data_out = 1'b0;
        next_state = S_start_cycle ;
        bit_pos=0;
    end


    assign clearToSend = CTS; // Ready to recieve a data bit when high
    assign serialOut = data_out; // setail data output   
    assign clk_50ns = clkTick;

    always @(posedge clk) // clock divider to 20Mhz 50ns
    /* sys_clock =8ns
    6 loops =48ns
    
    */

    begin
        if(clkCount >=5)
            begin
                clkTick =1;
                clkCount =0;
            end
        else
            begin
                clkTick =0;
                clkCount =clkCount +1;
            end


    end


    always @(posedge clkTick)
    begin
        if (reset) begin // go to state zero if reset

            next_state = S_start_cycle;
        end


        /***************************************************      
  State machine processing
  ****************************************************/

        //if(clkTick ) begin
        state = next_state ;
        case (state)
            //            S_initialise: begin
            //            // clear the screen and set initail values

            //            data_out = 0;
            //                            CTS = 1; // set CTS bit high to allow incoming data bit_count
            //                led_pos = 0; // start atfirst LED in string
            //                bit_pos =bit_count-1; //24
            //                next_state = S_rx_rgb;
            //                data_rx=24'b000000000000000000000000;
            //                next_state = S_get_bit;
            //            end

            S_start_cycle: begin
                CTS = 1; // set CTS bit high to allow incoming data bit_count
                led_pos = 0; // start atfirst LED in string
                bit_pos =bit_count;
                next_state = S_rx_rgb;
            end


            S_rx_rgb: begin
                data_rx = dataIn; // copy the data in case it changes
                //bit_pos = bit_count-1; // position to read MSB
                next_state = S_get_bit;
                CTS = 0; // set CTS bit low to stop incoming data bit_count
            end

            S_get_bit: begin
                bit_current = data_rx[bit_pos-1]; // copy bit from RGB data
                bit_pos <= bit_pos -1; // ready for next bit on next loop
                if (bit_current) begin // Hi bit
                    t_period_hi_count = t_1hi -1; // count hi period -1 for the current state and next state before count is deducted
                    t_period_low_count = t_1lo -1; // remained of period
                    next_state = S_output_hi;
                end
                else begin // low bit
                    t_period_hi_count = t_0hi -1; // count low period
                    t_period_low_count = t_0lo -1;
                    
                    next_state = S_output_hi;
                end
            end

            S_output_hi: begin // output hi for period based on bit value
                data_out = 1; // set output high
                if (t_period_hi_count == 0) begin // check if time elapsed    
                    next_state = S_output_low;
                    //data_out = 0; // set output low

                end
                else begin // decrement timer
                    t_period_hi_count = t_period_hi_count -1;
                    next_state = S_output_hi; // loop until timer done
                end
            end

            S_output_low: begin // output low for period based on bit value
                data_out = 0; // set output low 
                if (t_period_low_count== 0) begin // check if time 
                    if (bit_pos == 0) begin
                        next_state = S_led_position; // stare next LED
                    end
                    else begin
                        next_state = S_get_bit; // get next bit
                    end
                end
                else begin // decrement timer
                    t_period_low_count = t_period_low_count -1;
                    next_state = S_output_low; // loop until timer done
                end
            end

            S_led_position: begin
                if (led_pos < (led_count-1)) begin
                    led_pos = led_pos +1;
                    bit_pos = bit_count;
                    next_state = S_rx_rgb; // proecss data for next LED
                end
                else begin
                    t_period_low_count = t_reset; // time to stay in reset state
                    next_state = S_reset_delay; // all LEDs done so do reset delay
                end
            end

            S_reset_delay: begin // alloow time for LED's to know data will start at LED 1 again
                data_out =0;
                if (t_period_low_count== 0)begin
                    next_state= S_start_cycle;
                end
                else begin // decrement timer
                    t_period_low_count = t_period_low_count -1;
                    next_state = S_reset_delay; // loop until timer done
                end

            end
            default: begin
                data_out =0;
            end


        endcase
    end
    //end

endmodule
