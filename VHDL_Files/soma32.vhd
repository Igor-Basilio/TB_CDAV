Library IEEE;
USE IEEE.std_logic_1164.all;
library work;
use work.utility_package.all;

-- * TESTED | OK * --

Entity soma32 is
Port(A,B : in std_logic_vector(31 downto 0);
     S : out std_logic_vector(31 downto 0);
     Ov : out std_logic);
end soma32;

architecture Arq of soma32 is

begin

m: somadorN Generic Map(N => 32) port map( A , B , S , Ov );

end Arq;
