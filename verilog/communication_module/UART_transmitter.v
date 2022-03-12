module UART_tx(
  input clk,                // system clock
  input reset,              // reset
  input tx_start,           // signal to start transmission
  input s_tick,             // sample tick, frequency of baud rate
  input [7:0] d_in,         // word to be transmitted
  output reg tx_done_flag,  // transmission done flag
  output reg tx             // serial data line
);

// this module is connected to the baud generator (in clockDivider.v) and the tx line (connected to UART_reciever.v)
// unlike the receiver, this module doesn't use an oversampling scheme, the signal it gets from the clock divider is
// has the frequnecy of the baud rate. When a full byte of data is transmitted, the tx_done_flag flag is asserted

// split into pairs, a next state and current state
// so there is a duplicate of everything

  // state register
  reg [1:0] state_reg;
  reg [1:0] state_next;

  // sample tick counter
  reg [3:0] s_reg;
  reg [3:0] s_next;

  // number of transmitted bits
  reg [2:0] n_reg;
  reg [2:0] n_next;

  // data register
  reg [7:0] b_reg;
  reg [7:0] b_next;

  // transmitted bit register
  reg tx_reg;
  reg tx_next;

  // The design of the code is very similar to what can be done in VHDL, the UART_rx module is modeled as an FSM.
  // with the state_reg being a number from 0 to 3 which denotes the states: idle, start, data, and stop

  // this is the main process block
  // it first checks the state_reg to see which behavior to follow
  always @(posedge clk) begin
    if(!reset) begin
      state_reg <= 0;
      state_next <= 0;

      s_reg <= 0;
      s_next <= 0;

      n_reg <= 0;
      n_next <= 0;

      b_reg <= 0;
      b_next <= 0;

      tx_reg <= 1;
      tx_next <= 1;
    end

    else begin
      // first update registers
      state_reg <= state_next;
      s_reg <= s_next;
      n_reg <= n_next;
      b_reg <= b_next;
      tx_reg <= tx_next;
      tx_done_flag <= 0;

      if(state_reg == 0) begin    // idle state
         tx_next <= 1;            // ensure that line is held high when idle
         if(tx_start == 1) begin  // if the start flag is set (by the sender) transition to the start state
          state_next <= 1;        // change state to the start state
          s_next <= 0;            // reset counter
          b_next <= d_in;         // load word into the b_next register to transmit
         end
      end
      if(state_reg == 1) begin    // start state
        tx_next <= 0;             // send start bit
        if(s_tick == 1) begin     // only operate when the s_tick (from baud generator) is set
          if(s_reg == 15) begin   // when 16 ticks have passed, transition to next state
            state_next <= 2;
            s_next <= 0;          // reset counters
            n_next <= 0;
          end else begin
            s_next <= s_reg + 1;  // if 16 haven't passed, increment counter
          end
        end
      end
      if(state_reg == 2) begin          // data state
        tx_next <= b_reg[0];            // transmit MSB by setting it to the tx line
        if(s_tick == 1) begin           // only operate when the s_tick (from baud generator) is set
          if(s_reg == 15) begin         // once 16 ticks have passed, the next bit can be shifted out to the tx line
            s_next <= 0;                // reset conuter
            b_next <= b_reg[7:0] >> 1;  // shift bits in the b_reg

            if(n_reg == 7) begin        // when all 8 bits have been shifted;
              state_next <= 3;          // go to stop state
            end else begin
              n_next <= n_reg + 1;      // else increment bits transmitted counter
            end
          end else begin                // if less than 16 ticks have passed, increment counter
            s_next <= s_reg + 1;
          end
        end
      end
      if(state_reg == 3) begin    // stop state
        tx_next <= 1;             // transmit stop bit
        if(s_tick == 1) begin     // only operate when the s_tick (from baud generator) is set
          if(s_reg == 15) begin   // once 16 ticks have passed (which corresponds to 1 stop bit) switch back to idle state
            state_next <= 0;
            tx_done_flag <= 1;    // set transmission done flag
          end else begin
            s_next <= s_reg + 1;  // else increment counter
          end
        end
      end

      tx <= tx_reg;               // continuously set tx line to bit in tx_reg
    end
  end
endmodule
