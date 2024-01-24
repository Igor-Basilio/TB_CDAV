#!/usr/bin/env python3

import logging
import os
from datetime import datetime

script_dir = os.path.dirname(os.path.abspath(__file__))
absolute_path = os.path.join(script_dir, '../output/tb_output.txt' )
timestamp = datetime.now().strftime("%Y-%m-%d_%H-%M-%S")
log_filename = f"info_log_{timestamp}.txt"
absolute_pathlog = os.path.join(script_dir, f'../log/{log_filename}' )

logger = logging.getLogger()
logger.setLevel( logging.DEBUG )

format = logging.Formatter( '%(asctime)s %(levelname)s: %(message)s' )

info_handler = logging.FileHandler( absolute_pathlog )
info_handler.setLevel(logging.INFO)
info_handler.setFormatter( format )

logger.addHandler(info_handler)

def validate_sum( items, line_counter ) :
    global num_errors
    
    try:    
        first_num = int( items[0] )
        second_num = int( items[1] )
        hw_sum = int( items[2] )
        overflow = int( items[3].strip("' '\n") )
    except IndexError:         
        print(f"INFO: Not Enough items in the line : {line_counter}")
        exit(1)
            
        sum = int(first_num) + int(second_num)
        
        if ( sum > 2147483647 or sum < -2147483648 ) and overflow != 1 :
            logging.error(f"\nThe sum is bigger than the capacity of the registers and overflow isn't set - Sum: {sum}, line: {line_counter}")
            num_errors+=1
        elif sum != hw_sum and overflow != 1 :
            logging.error(f"\n The sums are different - Result: {hw_sum}, Expected: {sum}, Error at line: {line_counter} " )                         
            num_errors+=1
        elif sum == hw_sum and overflow == 1 :
            logging.error(f"\n The sums are equal but overflow is on - Result: {hw_sum}, Expected: {sum}, Error at line: {line_counter} " )                         
            num_errors+=1
            
    return None        
    
with open( absolute_path, 'r', newline='') as file :
    
    lines = file.readlines()
    line_counter = 0
    num_errors = 0
    
    for line in lines:
        
        items = line.split(" ")
        
        validate_sum(items, line_counter)
        
        line_counter += 1
        
    if num_errors > 0 :
       print( )
       print( "\033[91mWARNING : Design Errors detected please check the log files\033[0m" )
    else :
       print( )
       print("\033[92mINFO : No Design Errors detected\033[0m")
    logging.info(f"\n\nThe number of errors in the UUT : {num_errors} " )
         
