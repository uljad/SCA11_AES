module fifo(
  input clk,                // System clock
  input reset,              // Asynchronous reset
  input [127:0] d_in,       // Input block
  input write_en,           // Assert this signal to write d_in into buffer
  input read_en,            // Read enable to read next word from buffer
  output reg [127:0] d_out, // Data out from buffer, 128 bits = size of block for AES
  output empty,             // Empty flag is asserted when buffer has no readable data
  output overflow           // Overflow flag is asserted when buffer has no more space
);

// state register
reg [1:0] state;
reg [1:0] state_next;

// buffer and associated data_next block
reg [127:0] buff [7:0];

// hasData flags to see if buffer locations are filled
reg hasData [7:0];

// buffer index for loading data
reg [2:0] load_index;
reg [2:0] load_index_next;

// buffer index for reading data
reg [2:0] read_index;
reg [2:0] read_index_next;

  always@(posedge clk) begin
    if(!reset) begin
      state <= 0;
      state_next <= 0;

      load_index <= 0;
      load_index_next <= 0;

      read_index <= 0;
      read_index_next <= 0;

      hasData[0] <= 0;
      hasData[1] <= 0;
      hasData[2] <= 0;
      hasData[3] <= 0;
      hasData[4] <= 0;
      hasData[5] <= 0;
      hasData[6] <= 0;
      hasData[7] <= 0;

      buff[0] <= 0;
      buff[1] <= 0;
      buff[2] <= 0;
      buff[3] <= 0;
      buff[4] <= 0;
      buff[5] <= 0;
      buff[6] <= 0;
      buff[7] <= 0;
    end
    else begin
      state <= state_next;
      load_index <= load_index_next;
      read_index <= read_index_next;

      if(state == 0) begin
        if(write_en) begin
          state_next <= 1;
        end else if(read_en) begin
          state_next <= 3;
        end
      end

      if(state == 1) begin
        buff[load_index] <= d_in;
        state_next <= 2;
      end

      if(state == 2) begin
        hasData[load_index] <= 1;
        load_index_next <= load_index + 1;
        state_next <= 0;
      end

      if(state == 3) begin
        if(hasData[read_index]) begin
          hasData[read_index] <= 0;
          read_index_next <= read_index + 1;
          state_next <= 0;
        end
      end

      d_out <= buff[read_index];
    end
  end

  assign overflow = (hasData[load_index]);
  assign empty = (!hasData[read_index]);
endmodule
