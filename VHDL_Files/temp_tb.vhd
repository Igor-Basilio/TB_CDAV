library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use std.textio.all;
use work.utility_package.all;
use work.function_package.all;

entity temp_tb is
end temp_tb;

architecture arq of temp_tb is
    
  -- Inputs

  constant N : integer := 32;
  signal Clear : std_logic;
  signal CLK  : std_logic;
  signal A,B : std_logic_vector( N - 1 downto 0 );
  
  -- Outputs

  signal S : std_logic_vector( N - 1 downto 0 );
  signal Ov : std_logic;
  
  -- Internal Counter

  signal counter : integer := 0; 
  
   -- * * * * * * * * * * --
  -- Start of architecture --   
   -- * * * * * * * * * * --
  
begin
  
  UUT : soma32 port map ( A, B, S, Ov );
  
  Clear <= '1' , '0' after 10 ns, 
                 '0' after 20 ns;

  clock : process
  begin
    CLK <= '1' , '0' after 5 ns;
    wait for 10 ns;
  end process;

   -- * * * * * * * * * * --
   -- Start of test bench --   
   -- * * * * * * * * * * --
    
  test_bench : process
   
  begin

    while( counter <= 20 ) loop 

        A <= std_logic_vector( to_signed( 3242324, A'length ) );
        B <= std_logic_vector( to_signed( 399302193, A'length ) );
        wait until rising_edge(CLK);
        A <= std_logic_vector( to_signed( -3242324, A'length ) );
        B <= std_logic_vector( to_signed( 32442324, A'length ) );
        wait until rising_edge(CLK);
        A <= std_logic_vector( to_signed( -12030492, A'length ) );
        B <= std_logic_vector( to_signed( 3242324, A'length ) );
        wait until rising_edge(CLK);
        A <= std_logic_vector( to_signed( 3242324, A'length ) );
        B <= std_logic_vector( to_signed( 3829433, A'length ) );
        wait until rising_edge(CLK);
        A <= std_logic_vector( to_signed( 1242324999, A'length ) );
        B <= std_logic_vector( to_signed( 1829433555, A'length ) );
        wait until rising_edge(CLK);
        A <= std_logic_vector( to_signed( 1242324999, A'length ) );
        B <= std_logic_vector( to_signed( -1829433555, A'length ) );
        wait until rising_edge(CLK);
        A <= std_logic_vector( to_signed( -1242324999, A'length ) );
        B <= std_logic_vector( to_signed( -1829433555, A'length ) );
        wait until rising_edge(CLK);      
        A <= std_logic_vector( to_signed( -1242324999, A'length ) );
        B <= std_logic_vector( to_signed( -9433555, A'length ) );
        wait until rising_edge(CLK);      
        
        counter <= counter + 1;
        
    end loop;    
     
    wait;
  end process;
  
end arq;
