module UART_rx(
  input clk,              // system clock
  input reset,            // asynchronous reset
  input rx,               // rx data line (connected to a UART transmitter)
  input s_tick,           // ticks received from baud generator
  output reg [7:0] d_out, // byte that is received
  output reg rx_done_flag // flag is asserted when one byte is received
);

// this module is connected to the baud generator (in clockDivider.v) and the rx line (connected to UART_transmitter.v)
// The module decides when to sample the b_next line and shift the incoming bits to an internal register. When a full byte is received
// a flag is asserted to show that you can know read d_out and it would be correct

// split into pairs, a next state and current state
// so there is a duplicate of everything

  // state register
  reg [1:0] state_reg;
  reg [1:0] state_next;

  // sample tick counter
  reg [3:0] s_reg;
  reg [3:0] s_next;

  // bits received counter
  reg [2:0] n_reg;
  reg [2:0] n_next;

  // data register
  reg [7:0] b_reg;
  reg [7:0] b_next;


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
    end
    else begin
      // at every rising edge of the system clock, update all the registers
      state_reg <= state_next;
      s_reg <= s_next;
      n_reg <= n_next;
      b_reg <= b_next;
      rx_done_flag <= 0;

      if(state_reg == 0) begin    // idle state
        if(!rx) begin             // when in idle state, if a zero is received on the b_next line, that is a start bit
          state_next <= 1;        // change state to start state
          s_next <= 0;            // reset counter
        end
      end

      if(state_reg == 1) begin    // start state
        if(s_tick) begin          // everything happens only when s_tick is asserted to ensure that sampling happens at specific times
          if(s_reg == 7) begin    // in start state, we only need to count to 7 to get to the middle of the start bit
            state_next <= 2;      // switch state to b_next
            s_next <= 0;          // reset the counters
            n_next <= 0;
          end else begin
            s_next <= s_reg + 1; // tick counter is incremented until we get to 7
          end
        end
      end

      if(state_reg == 2) begin
        if(s_tick) begin
          if(s_reg == 15) begin                 // oversampling scheme requires sampling in the middle of the wave, this is ensured by counting 16 ticks
                                                // this ensures we sample the middle of the wave, the middle of one wave is 16 bits from the middle of the
                                                // next wave
            b_next <= {rx, b_reg[7:1]};         // shift in b_next bit
            s_next <= 0;                        // reset tick counter
            if(n_reg == 7) begin                // once entire message is received switch to stop state
              state_next <= 3;
            end
            else begin
              n_next <= n_reg + 1;              // bits received counter is incremented until we get to 7 (we received 8 bits total)
            end
          end else begin
            s_next <= s_reg + 1;
          end
        end
      end

      if(state_reg == 3) begin  // stop state
        if(s_tick) begin
          if(s_reg == 15) begin // 16 sample ticks corresponds to one stop bit
            state_next <= 0;    // reset to idle state
            rx_done_flag <= 1;  // done flag is asserted
          end else begin
            s_next <= s_reg + 1;
          end
        end
      end

      d_out <= b_reg;           // d_out is always assigned to the b_next register
    end
  end
endmodule
