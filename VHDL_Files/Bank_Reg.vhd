Library IEEE;
USE IEEE.std_logic_1164.all;
LIBRARY work;
USE work.utility_package.all;

-- * Not tested could have unexpected behaviour * --

Entity Bank_Reg is

Generic (N : integer := 32);

Port(
		Data_in : in std_logic_vector( 31 downto 0 );
		Write_FromUla : in std_logic;
		Write_Bool : in std_logic;
		writeReg : in std_logic_vector( 4 downto 0 );
		CLK : in std_logic;
		Clear : in std_logic;
		ULA_Value : in std_logic_vector( 31 downto 0 );
		Reg_Values : out bank_bus
	  );
	  
End Bank_Reg;

architecture Arq of Bank_Reg is

signal Dec_WriteCode : std_logic_vector( 31 downto 0 );

signal Value_To_Write : std_logic_vector( 31 downto 0 );

begin

	DEC : Dec_WriteReg port map (	writeReg , A => Dec_WriteCode  );
			  
   M1 : Mux21 port map ( Data_in , ULA_Value , Write_FromUla , Value_To_Write );
	
	F1: for i in 0 to N-1 generate
		 Flip : FFD port map(  Value_To_Write , CLK , 
		                      ( Dec_WriteCode(i) and Write_Bool )
								    , Clear , Reg_Values(i) ); 
	end generate;
	
end Arq;
