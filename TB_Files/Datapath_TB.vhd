library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use std.textio.all;
use work.utility_package.all;
use work.function_package.all;

entity Datapath_TB is
end Datapath_TB;

architecture arq of Datapath_TB is

  -- Constants for ULA_Funct
  
  constant soma : std_logic_vector := "010";
  constant sub : std_logic_vector := "011";
  constant or_AB : std_logic_vector := "001";
  constant a_xorn_b : std_logic_vector := "100";
  constant a_nand_b : std_logic_vector := "111";
  constant not_b : std_logic_vector := "101";
  constant bypass_a : std_logic_vector := "000";
  constant bypass_b : std_logic_vector := "110";
  
  -- Inputs
  
  signal CLK : std_logic ;
  signal Clear : std_logic ;
  
  signal Data_in : std_logic_vector( 31 downto 0 ) := ( others => '0' );
  signal RegA, RegB : std_logic_vector ( 4 downto 0 ) := ( others => '0' );
  signal writeReg : std_logic_vector ( 4 downto 0 ) := ( others => '0' );
  signal ULA_Funct : std_logic_vector ( 2 downto 0 ) := ( others => '0' );
  signal Write_FromUla : std_logic := '0';
  signal Write_Bool : std_logic := '0';
  
  -- Outputs

  signal Data_Out : std_logic_vector ( 31 downto 0 );
  signal Ov, N, Z : std_logic;
  signal Reg_Values : bank_bus;
  signal Saida_Ula : std_logic_vector ( 31 downto 0 );
  
  -- Internal Counter

  signal counter : integer := 0; 
 
  -- Break flag

  signal break_flag : boolean := false;
  
   -- * * * * * * * * * * --
 -- * Start of architecture * --   
   -- * * * * * * * * * * --
  
begin

  UUT : Datapath port map (
    Data_in, CLK, Clear, RegA, RegB, writeReg, ULA_Funct, Saida_Ula, 
    Ov, N, Z, Reg_Values,
    Write_FromUla, Write_Bool, Data_Out
  ); 
  
  Clear <= '0' , '1' after 10 ns, 
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

    file file_pointer : text;
    
    variable line_value : line;
    variable num1, num2 : integer;
    constant filename : string := "./output/random_tb_numbers";
    variable file_status : file_open_status;
    variable good : boolean;
    variable line_r : line;

    variable current_overflow : std_logic;
    variable value_to_write : std_logic_vector( 31 downto 0 );    
    file output_file : text open write_mode is "output/tb_output.txt";
    
  begin

    file_open( file_status, file_pointer, filename, READ_MODE);

    report filename & LF & HT & "file_open_status = " &
           file_open_status'image(file_status);
    assert file_status = OPEN_OK
      report "file_open_status /= file_ok"
      severity FAILURE;
    
    while not endfile(file_pointer) loop

      readline(file_pointer, line_value);
      while line_value.all'length > 0 loop
      
        read(line_value, num1, good);
        exit when not good;
        report integer'image(num1);
        wait until rising_edge(CLK);
        
        -- Set inputs 
        Data_in <= std_logic_vector( to_signed( num1, Data_in'length ) );
        writeReg <= std_logic_vector( to_unsigned( 4 , writeReg'length ) );
        write_Bool <= '1';
        write_FromUla <= '0';
        regA <= ( others => 'X' );
        regB <= ( others => 'X' );
        ULA_Funct <= "XXX";

        -- Write value to file
        value_to_write := std_logic_vector( to_signed( num1, Data_in'length ) );
        write( line_r, integer'Image(
          to_integer( signed( value_to_write ) ) ) );
        write( line_r, string'(" ") );                
        wait until rising_edge(CLK);                    
     
        read(line_value, num2, good);
        exit when not good;
        report integer'image(num2);

        -- Set inputs
        Data_in <= std_logic_vector( to_signed( num2, Data_in'length ) );
        writeReg <= std_logic_vector( to_unsigned( 3 , writeReg'length ) );
        write_Bool <= '1';
        write_FromUla <= '0';
        regA <= ( others => 'X' );
        regB <= ( others => 'X' );
        ULA_Funct <= "XXX";
        
        -- Write value to file
        value_to_write := std_logic_vector( to_signed( num2, Data_in'length ) );
        write( line_r, integer'Image(
          to_integer( signed( value_to_write ) ) ) );
        write( line_r, string'(" ") );                                
        wait until rising_edge(CLK);      

        read(line_value, num1, good);
        exit when not good;
        report integer'image(num1);
        wait until rising_edge(CLK);
        
        -- Set inputs 
        Data_in <= ( others => 'X' );
        writeReg <= std_logic_vector( to_unsigned( 5 , writeReg'length ) );
        regA <= std_logic_vector( to_unsigned( 3 , regA'length ) );
        regB <= std_logic_vector( to_unsigned( 4 , regB'length ) );
        write_Bool <= '1';
        write_FromUla <= '1';
        ULA_Funct <= soma;
        wait until rising_edge(CLK);

        -- Save current overflow after sum
        current_overflow := ov;
        
        write_Bool <= '0';
        regA <= std_logic_vector( to_unsigned( 5, regA'length ) );
        wait until rising_edge(CLK);

        write( line_r, integer'Image(
          to_integer( signed( Data_Out ) ) ) );
        write( line_r, string'(" ") );                

        write( line_r, std_logic'Image( current_overflow ) );        
        writeline( output_file, line_r );                
        wait until rising_edge(CLK);
        
      end loop;
      
    end loop;

    wait until falling_edge(CLK);
    file_close ( file_pointer );
    report filename & " closed;";

    break_flag <= true;
    wait;
  end process;
  
end arq;
