file = open("input_key.txt", "r") 
ascii_key = file.readline()
if(len(ascii_key) < 16):
    ascii_key = ascii_key + (16-len(ascii_key))*"0"
ascii_key = ascii_key[0:16] 
hex_key = ''.join(r'{0:x}'.format(ord(c)) for c in ascii_key)
file.close()
file = open("input_key.txt", "w")
file.writeline(hex_key)
file.close()