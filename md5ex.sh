#!/usr/bin/python #tells os which program to use to run the code

import sys, os, hashlib #Brings in functions to be used by the code

def get_hash(name): #Defines the function get_hash which takes in the value of the name variable 
    readsize = 64 * 1024 #Sets var read size to 64KB
    with open(name, 'rb') as f: #Open file name as a binary stream called "F"
        size = os.path.getsize(name) #In reality this does nothing becuase it defines a variable that is not used
        data = f.read(readsize) #Reads the first 64KB of a file and stores in the binary stream
        f.seek(-readsize, os.SEEK_END) #Jumps to the last 64KB of a file 
        data += f.read(readsize) #Adds the last 64KB of data to the file 
    return hashlib.md5(data).hexdigest() #Creates an mds mash of data in hexadecimal
    
print get_hash(sys.argv[1]); #Prints the end result of the cod
