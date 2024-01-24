#!/usr/bin/env python3

# Verifying that the sum between two registers
# is working, from - 2^32 / 2 to ( 2^32 / 2 - 1 )
# [ -2147483648 to 2147483647 ].
# Testing with random generated numbers from random lib.

import random
import os

script_dir = os.path.dirname(os.path.abspath(__file__))
absolute_path = os.path.join(script_dir, '../output/random_tb_numbers' )
 
with open( absolute_path, 'w', newline='') as file :
    
    limit = 1e4
    i = 0
    
    while( i <= limit ) :

        n_1 = random.randint( -2147483648, 2147483647 )

        file.write( str( n_1 ) )
        file.write( ' ' )
        
        i += 1
        
