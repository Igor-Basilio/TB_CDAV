Library IEEE;
USE IEEE.std_logic_1164.all;

-- * Not tested could have unexpected behaviour * --

Entity FFD is
Port(D : in std_logic_vector(31 downto 0);
     clk,carga,clear: in std_logic;
     Q: out std_logic_vector(31 downto 0));
End FFD;

architecture Arq of FFD is

begin

  P1: process(clk,clear)
  begin
    if clear = '1' then		 
      Q <= (others => '0');				 
    elsif rising_edge(clk) then
      if carga = '1' then				 
        Q <= D;				 
      end if;
    end if;			 
  end process;

end Arq;
