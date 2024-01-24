Library IEEE;
USE IEEE.std_logic_1164.all;

-- * Not tested could have unexpected behaviour * --

Entity Mux21 is
Port(A: in std_logic_vector( 31 downto 0 );
     B: in std_logic_vector( 31 downto 0 );
	  Sel : in std_logic;
	  Y: out std_logic_vector( 31 downto 0 ));
End Mux21;

architecture Arq of Mux21 is
begin
 
 with sel select
   Y <= A when '0',
        B when '1',
        ( others => '0' ) when others;
 
end Arq;

