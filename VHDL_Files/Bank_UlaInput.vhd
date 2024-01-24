Library IEEE;
USE IEEE.std_logic_1164.all;
LIBRARY work;
USE work.utility_package.all;

-- * Not tested could have unexpected behaviour * --

Entity Bank_UlaInput is
Port(

		Data_in : in std_logic_vector( 31 downto 0 );
		Write_FromUla : in std_logic;
		Write_Bool : in std_logic;
		writeReg : in std_logic_vector( 4 downto 0 );
		CLK : in std_logic;
		Clear : in std_logic;
		ULA_Value : in std_logic_vector( 31 downto 0 );
		
		CodeA , CodeB : in std_logic_vector( 4 downto 0 );
		Reg_ValuesOut : out bank_bus;
		UlaA , UlaB : out std_logic_vector( 31 downto 0 )
		
	  );
End Bank_UlaInput;

architecture Arq of Bank_UlaInput is

signal Reg_Values : bank_bus;

begin
 
  	B1 : Bank_Reg port map ( Data_in , Write_FromUla ,
                                 Write_Bool , writeReg , CLK , Clear ,	
                                 ULA_Value ,  Reg_Values => Reg_Values );
		
	Reg_ValuesOut <= Reg_Values;
	
   with CodeA select
    UlaA <= Reg_Values(0)  when "00000",
				Reg_Values(1)  when "00001",
				Reg_Values(2)  when "00010",
				Reg_Values(3)  when "00011",
				Reg_Values(4)  when "00100",
				Reg_Values(5)  when "00101",
				Reg_Values(6)  when "00110",
				Reg_Values(7)  when "00111",
				Reg_Values(8)  when "01000",
				Reg_Values(9)  when "01001",
				Reg_Values(10) when "01010",
				Reg_Values(11) when "01011",
				Reg_Values(12) when "01100",
				Reg_Values(13) when "01101",
				Reg_Values(14) when "01110",
				Reg_Values(15) when "01111",
				Reg_Values(16) when "10000",
				Reg_Values(17) when "10001",
				Reg_Values(18) when "10010",
				Reg_Values(19) when "10011",
				Reg_Values(20) when "10100",
				Reg_Values(21) when "10101",
				Reg_Values(22) when "10110",
				Reg_Values(23) when "10111",
				Reg_Values(24) when "11000",
				Reg_Values(25) when "11001",
				Reg_Values(26) when "11010",
				Reg_Values(27) when "11011",
				Reg_Values(28) when "11100",
				Reg_Values(29) when "11101",
				Reg_Values(30) when "11110",
				Reg_Values(31) when "11111",
				(others => '0') when others;
			
	 with CodeB select
    UlaB <= Reg_Values(0)  when "00000",
				Reg_Values(1)  when "00001",
				Reg_Values(2)  when "00010",
				Reg_Values(3)  when "00011",
				Reg_Values(4)  when "00100",
				Reg_Values(5)  when "00101",
				Reg_Values(6)  when "00110",
				Reg_Values(7)  when "00111",
				Reg_Values(8)  when "01000",
				Reg_Values(9)  when "01001",
				Reg_Values(10) when "01010",
				Reg_Values(11) when "01011",
				Reg_Values(12) when "01100",
				Reg_Values(13) when "01101",
				Reg_Values(14) when "01110",
				Reg_Values(15) when "01111",
				Reg_Values(16) when "10000",
				Reg_Values(17) when "10001",
				Reg_Values(18) when "10010",
				Reg_Values(19) when "10011",
				Reg_Values(20) when "10100",
				Reg_Values(21) when "10101",
				Reg_Values(22) when "10110",
				Reg_Values(23) when "10111",
				Reg_Values(24) when "11000",
				Reg_Values(25) when "11001",
				Reg_Values(26) when "11010",
				Reg_Values(27) when "11011",
				Reg_Values(28) when "11100",
				Reg_Values(29) when "11101",
				Reg_Values(30) when "11110",
				Reg_Values(31) when "11111",
			   (others => '0') when others;
			
end Arq;
