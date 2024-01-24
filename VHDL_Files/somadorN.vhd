Library IEEE;
USE IEEE.std_logic_1164.all;
library work;
use work.utility_package.all;

-- * TESTED | OK * --

Entity somadorN is
Generic (N : integer := 32);
Port(A,B : in std_logic_vector(N-1 downto 0);
     S : out std_logic_vector(N-1 downto 0);
     Ov : out std_logic);
end somadorN;

architecture Arq of somadorN is

signal n_aux : std_logic_vector(N downto 0);

begin

n_aux(0) <= '0';
  
G1: for i in 0 to N-1 generate
  m: sc port map( A(i), B(i), n_aux(i), S(i), n_aux(i+1) );
end generate;
       
Ov <=  n_aux(N) xor n_aux(N - 1) ;
	 
end Arq; 
	  
