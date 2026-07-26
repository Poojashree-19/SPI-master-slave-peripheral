`timescale 1ns/1ps

module clock_divider_tb;

    // Testbench Signals
    logic       clk;
    logic       reset;
    logic [7:0] divider;
    logic       spi_clk;

    // Instantiate DUT
    clock_divider dut (
        .clk(clk),
        .reset(reset),
        .divider(divider),
        .spi_clk(spi_clk)
    );

    //==========================================================
    // System Clock Generation (100 MHz)
    // Clock Period = 10 ns
    //==========================================================
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    //==========================================================
    // Test Sequence
    //==========================================================
    initial begin

        // Dump waveform
        $dumpfile("clock_divider.vcd");
        $dumpvars(0, clock_divider_tb);

        //------------------------------------------------------
        // Test 1 : Reset
        //------------------------------------------------------
        reset   = 1;
        divider = 8;

        #20;
        reset = 0;

        //------------------------------------------------------
        // Run with divider = 8
        //------------------------------------------------------
        #200;

        //------------------------------------------------------
        // Test 2 : Divider = 4
        //------------------------------------------------------
        divider = 4;
        #120;

        //------------------------------------------------------
        // Test 3 : Divider = 2
        //------------------------------------------------------
        divider = 2;
        #80;

        //------------------------------------------------------
        // Test 4 : Invalid Divider (<2)
        //------------------------------------------------------
        divider = 1;
        #60;

        //------------------------------------------------------
        // End Simulation
        //------------------------------------------------------
        $finish;

    end

    //==========================================================
    // Monitor
    //==========================================================
    initial begin
        $monitor("Time=%0t | Reset=%b | Divider=%0d | Counter=%0d | SPI_CLK=%b",
                 $time,
                 reset,
                 divider,
                 dut.counter,
                 spi_clk);
    end

endmodule
