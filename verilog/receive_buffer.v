module rx_buff(
  input clk,                // System clock
  input [7:0] din,          // Input data from UART_receivers
  input ready,              // rx_done_flag from UART_receiver
  input reset,              // Asynchronous reset
  input read_en,            // Read enable to read next word from buffer
  output reg [127:0] dout,  // Data out from buffer, 128 bits = size of block for AES
  output empty,             // Empty flag is asserted when buffer has no readable data
  output reg overflow       // Overflow flag is asserted when buffer has no more space
);

// split into pairs, a next state and current state
// so there is a duplicate of everything

// state register
reg [1:0] state;
reg [1:0] state_next;

// number of bytes received
reg [3:0] ctr;
reg [3:0] ctr_next;

// buffer index for loading data
reg [4:0] load_index;
reg [4:0] load_index_next;

// buffer index for reading data
reg [4:0] read_index;
reg [4:0] read_index_next;

// buffer and intermediate 128 bit block
reg [127:0] buff [31:0];
reg [127:0] data_next;

// flags to show whether that location in buffer has readable data
reg hasData [31:0];

// at asynchronous reset, set everything to zero
  always @(reset) begin
    state <= 0;
    state_next <= 0;

    ctr <= 0;
    ctr_next <= 0;

    load_index <= 0;
    load_index_next <= 0;

    read_index <= 0;
    read_index_next <= 0;

    data_next <= 0;

    hasData[0] <= 0;
    hasData[1] <= 0;
    hasData[2] <= 0;
    hasData[3] <= 0;
    hasData[4] <= 0;
    hasData[5] <= 0;
    hasData[6] <= 0;
    hasData[7] <= 0;
    hasData[8] <= 0;
    hasData[9] <= 0;
    hasData[10] <= 0;
    hasData[11] <= 0;
    hasData[12] <= 0;
    hasData[13] <= 0;
    hasData[14] <= 0;
    hasData[15] <= 0;
    hasData[16] <= 0;
    hasData[17] <= 0;
    hasData[18] <= 0;
    hasData[19] <= 0;
    hasData[20] <= 0;
    hasData[21] <= 0;
    hasData[22] <= 0;
    hasData[23] <= 0;
    hasData[24] <= 0;
    hasData[25] <= 0;
    hasData[26] <= 0;
    hasData[27] <= 0;
    hasData[28] <= 0;
    hasData[29] <= 0;
    hasData[30] <= 0;
    hasData[31] <= 0;

    buff[0] <= 0;
    buff[1] <= 0;
    buff[2] <= 0;
    buff[3] <= 0;
    buff[4] <= 0;
    buff[5] <= 0;
    buff[6] <= 0;
    buff[7] <= 0;
    buff[8] <= 0;
    buff[9] <= 0;
    buff[10] <= 0;
    buff[11] <= 0;
    buff[12] <= 0;
    buff[13] <= 0;
    buff[14] <= 0;
    buff[15] <= 0;
    buff[16] <= 0;
    buff[17] <= 0;
    buff[18] <= 0;
    buff[19] <= 0;
    buff[20] <= 0;
    buff[21] <= 0;
    buff[22] <= 0;
    buff[23] <= 0;
    buff[24] <= 0;
    buff[25] <= 0;
    buff[26] <= 0;
    buff[27] <= 0;
    buff[28] <= 0;
    buff[29] <= 0;
    buff[30] <= 0;
    buff[31] <= 0;

    overflow <= 0;
  end

  always @(posedge clk) begin
    // at every rising edge of the system clock, update all the registers
    state <= state_next;
    ctr <= ctr_next;
    load_index <= load_index_next;
    read_index <= read_index_next;
    buff[load_index] <= data_next;

    if(state == 0) begin                // idle state
      if(ready) begin                   // if UART_receiver is ready
        if(!hasData[load_index]) begin  // and buffer has space
          state_next <= 1;              // transition to data state
          ctr_next <= 0;                // reset counter
          data_next <= din;             // load first byte
        end else begin
          overflow <= 1;                // if buffer has no space, assert overflow flag
          state_next <= 0;              // stay in idle state
        end
      end else if(read_en) begin        // if read enable flag is asserted
        state_next <= 2;                // go to read state
      end
    end

    if(state == 1) begin                            // data state
      if(ctr == 15) begin                           // if 16 bytes were recieved
        hasData[load_index] <= 1;                   // set flag at index
        load_index_next <= load_index + 1;          // increment load index
        state_next <= 0;                            // go back to idle state
      end else begin
        if(ready) begin                             // else if UART_receiver is ready
          data_next <= buff[load_index] << 8 | din; // shift another byte in
          ctr_next <= ctr + 1;                      // increment counter
        end
      end
    end

    if(state == 2) begin                  // read state
      hasData[read_index] <= 0;           // set location as read
      read_index_next <= read_index + 1;  // increment read index
      state_next <= 0;                    // go back to idle state
    end

    dout <= buff[read_index];             // dout is always set to the data at the read index in buffer
  end

  assign empty = (!hasData[read_index]);  // if reading from an empty location, the buffer is empty
endmodule
