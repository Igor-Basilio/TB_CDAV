Library IEEE;
USE IEEE.std_logic_1164.all;
LIBRARY work;
USE work.utility_package.all;

-- * Not tested could have unexpected behaviour * --

Entity ULA is
Port(

		Data_in : in std_logic_vector( 31 downto 0 );
		CLK : in std_logic;
		Clear : in std_logic;
		CodeA , CodeB : in std_logic_vector( 4 downto 0 );
		writeReg : in std_logic_vector( 4 downto 0 );		
		ULA_Funct : in std_logic_vector( 2 downto 0 );
		Saida_Ula : out std_logic_vector( 31 downto 0 );
		
		Ov , N , Z : out std_logic;	
		
		Reg_ValuesOut : out bank_bus;
		Write_FromUla : in std_logic;
		Write_Bool : in std_logic;	
		
		Data_Out : out std_logic_vector( 31 downto 0 )
			
		);
End ULA;

architecture Arq of ULA is

signal ValueA , ValueB : std_logic_vector( 31  downto 0 );
signal sumV , subV : std_logic_vector( 31  downto 0 );
signal TEMP , sumTemp : std_logic_vector( 31  downto 0 );
signal OvSum , OvSub : std_logic;

begin

	Data_Out <= ValueA;
	
 	BUI1 : Bank_UlaInput port map ( Data_in , Write_FromUla , 
	Write_Bool , writeReg , CLK , Clear , TEMP , CodeA , CodeB , Reg_ValuesOut , ValueA , ValueB );
   
	S1 : soma32 port map ( ValueA , ValueB , sumV , OvSum );
	
	STEMP : soma32 port map ( (31 downto 1 => '0', 0 => '1')  ,  not ValueB , sumTemp , open );
 
	S2 : soma32 port map ( ValueA , sumTemp , subV , OvSub );
		
	with ULA_Funct select
                    Ov <= OvSum when "010",
                          OvSub when "011",
                          'X' when others;

	N <= TEMP(31);
		
	with ULA_Funct select
          TEMP <=  ValueA when "000",
          ( ValueA or ValueB ) when "001",		        	
          sumV when "010",
          subV when "011",
          ValueA xor ( not ValueB ) when "100",
          not ValueB when "101",
          ValueB when "110",
          ValueA nand ValueB when "111",
          ( others => '0' ) when others;

        with TEMP select
           Z <= '1' when (others => '0'),
                '0' when  others;
        
	Saida_Ula <= TEMP;

end Arq;
