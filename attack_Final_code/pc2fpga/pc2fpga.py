import serial
import time


NUM_BYTES = 16

N = 1000


ser = serial.Serial('COM4', 115200, timeout=1, stopbits=serial.STOPBITS_ONE)

data = '6bc1bee22e409f96e93d7e117393172d'

data_bytes = bytes.fromhex(data)

ser.reset_input_buffer()

cnt = 0

for i in range(N):
    cnt = 0
    ser.write(data_bytes)
    while (cnt < NUM_BYTES):
        if ser.in_waiting:
            cnt += 1
            data_in = ser.read()
            print(data_in.hex(), end="")
    print()