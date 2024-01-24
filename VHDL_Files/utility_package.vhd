LIBRARY ieee;
USE ieee.std_logic_1164.all;

-- * Not tested could have unexpected behaviour * --

PACKAGE utility_package IS

		type bank_bus is array (0 to 31) of std_logic_vector(31 downto 0);

                COMPONENT somadorN is
                Generic (N : integer := 32);
                Port(A,B : in std_logic_vector(N-1 downto 0);
                S : out std_logic_vector(N-1 downto 0);
                Ov : out std_logic);
                end COMPONENT;
                
                COMPONENT SC is
                  Port(A0: in std_logic;
                       B0: in std_logic;
                       Cin : in std_logic;
                       S0: out std_logic;
                       Cout: out std_logic);
                End COMPONENT;
                
		COMPONENT FFD is
		Port(D : in std_logic_vector(31 downto 0);
			  clk,carga,clear: in std_logic;
			  Q: out std_logic_vector(31 downto 0));
		End COMPONENT;
		
		COMPONENT Mux21 is
		Port(A: in std_logic_vector( 31 downto 0 );
			  B: in std_logic_vector( 31 downto 0 );
			  Sel : in std_logic;
			  Y: out std_logic_vector( 31 downto 0 ));
		End COMPONENT;
		
		COMPONENT Dec_WriteReg is
		Port(
			  writeRegA : in std_logic_vector( 4 downto 0 );    	  
			  A : out std_logic_vector( 31 downto 0 )
			  );
		End COMPONENT;
		
		COMPONENT Bank_Reg is

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
			  
		End COMPONENT;
		
		COMPONENT soma32 is
		Port(A,B : in std_logic_vector(31 downto 0);
	             S : out std_logic_vector(31 downto 0);
	             Ov : out std_logic);
		end COMPONENT;
		
		COMPONENT Bank_UlaInput is
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
		End COMPONENT;
		
		COMPONENT ULA is
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
		End COMPONENT;

                COMPONENT Datapath is
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
                End COMPONENT;

END utility_package ;
