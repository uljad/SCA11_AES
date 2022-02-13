module UART_Loopback_Top
  (input  i_Clk,       // Main Clock
   input  i_UART_RX,   // UART RX Data
   output o_UART_TX   // UART TX Data  
   ); 
 
  wire w_RX_DV;
  wire [7:0] w_RX_Byte;
  wire w_TX_Active, w_TX_Serial;
   
  // 25,000,000 / 115,200 = 217
  UART_RX UART_RX_Inst
  (.i_Clock(i_Clk),
   .i_RX_Serial(i_UART_RX),
   .o_RX_DV(w_RX_DV),
   .o_RX_Byte(w_RX_Byte));
    
  UART_TX UART_TX_Inst
  (.i_Clock(i_Clk),
   .i_TX_DV(w_RX_DV),      // Pass RX to TX module for loopback
   .i_TX_Byte(w_RX_Byte),  // Pass RX to TX module for loopback
   .o_TX_Active(w_TX_Active),
   .o_TX_Serial(w_TX_Serial),
   .o_TX_Done());

// Drive UART line high when transmitter is not active
  assign o_UART_TX = w_TX_Active ? w_TX_Serial : 1'b1;

   
endmodule