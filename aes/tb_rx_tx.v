//////////////////////////////////////////////////////////////////////
// File Downloaded from http://www.nandland.com
//////////////////////////////////////////////////////////////////////
 
// This testbench will exercise both the UART Tx and Rx.
// It sends out byte 0xAB over the transmitter
// It then exercises the receive by receiving byte 0x3F
`timescale 1ns/10ps

module uart_tb ();
 
  // Testbench uses a 10 MHz clock
  // Want to interface to 115200 baud UART
  // 10000000 / 115200 = 87 Clocks Per Bit.
  parameter c_CLOCK_PERIOD_NS = 10;
  parameter c_CLKS_PER_BIT    = 868;
  parameter c_BIT_PERIOD      = 8680;
   
  reg r_Clock = 0;
  wire w_Tx_Serial;
  reg r_Rx_Serial = 1;
   
 
  // Takes in input byte and serializes it 
  task UART_WRITE_BYTE;
    input [7:0] i_Data;
    integer     ii;
    begin
       
      // Send Start Bit
      r_Rx_Serial <= 1'b0;
      #(c_BIT_PERIOD);
      #1000;
       
      // Send Data Byte
      for (ii=0; ii<8; ii=ii+1)
        begin
          r_Rx_Serial <= i_Data[ii];
          #(c_BIT_PERIOD);
        end
       
      // Send Stop Bit
      r_Rx_Serial <= 1'b1;
      #(c_BIT_PERIOD);
     end
  endtask // c_BIT_PERIOD
 
 UART_Loopback_Top top_uart_inst (
     .i_Clk(r_Clock),
     .i_UART_RX(r_Rx_Serial),
     .o_UART_TX(w_Tx_Serial)
    );
   
  always
    #(c_CLOCK_PERIOD_NS/2) r_Clock <= !r_Clock;
 
   
  // Main Testing:
initial
    begin
  
      // Send a command to the UART (exercise Rx)
        @(posedge r_Clock);
        UART_WRITE_BYTE(8'h3F);
        @(posedge r_Clock);
      
        @(posedge uart_tb.top_uart_inst.UART_TX_Inst.o_Tx_Done);
             
      // Check that the correct command was received
//      if (w_Rx_Byte == 8'h3F)
//        $display("Test Passed - Correct Byte Received");
//      else
//        $display("Test Failed - Incorrect Byte Received");
      
        repeat (2)
            @(posedge r_Clock);
            @(posedge r_Clock);
        $finish;
       
    end
   
endmodule