LIBRARY ieee;
USE ieee.std_logic_1164.all;

-- * Not tested could have unexpected behaviour * --

package function_package is

  function to_string(v : std_logic_vector) return string;
  
end function_package;

package body function_package is

  function to_string(v : std_logic_vector) return string is
    variable str : string( 1 to v'length );
  begin

    for i in v'range loop
      if v(i) = '1' then
        str(i + 1) := '1';
      elsif v(i) = '0' then
        str(i + 1) := '0';
      else
        str(i + 1) := 'X'; -- For undefined or high-impedance states
      end if;
    end loop;
    return str;
  end function;
  
end package body function_package;
