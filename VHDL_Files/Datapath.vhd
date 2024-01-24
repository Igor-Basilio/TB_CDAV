Library IEEE;
USE IEEE.std_logic_1164.all;
LIBRARY work;
USE work.utility_package.all;

-- * Not tested could have unexpected behaviour * --

Entity Datapath is
Port(

		Data_in : in std_logic_vector( 31 downto 0 );
		CLK : in std_logic;
		Clear : in std_logic;

                RegA , RegB : in std_logic_vector( 4 downto 0 );
                writeReg : in std_logic_vector( 4 downto 0 );		
		ULA_Funct : in std_logic_vector( 2 downto 0 );

                Saida_Ula : out std_logic_vector( 31 downto 0 );
                
                Ov , N , Z : out std_logic;	

                Reg_Values : out bank_bus;
                
		Write_FromUla : in std_logic;
		Write_Bool : in std_logic;	                

                Data_Out : out std_logic_vector( 31 downto 0 )
                
		);
End Datapath;

architecture Arq of Datapath is

begin
          
	U_1 : ULA port map ( Data_in , CLK , Clear , RegA,
                          RegB, writeReg,
                          ULA_Funct, Saida_Ula , Ov , N , Z , Reg_Values,
                          Write_FromUla, Write_Bool, Data_Out );
		
end arq;
