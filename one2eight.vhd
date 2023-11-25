library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;

entity one2eight  is
  port (d: in std_logic;s: in std_logic_vector(2 downto 0); y: out std_logic_vector(7 downto 0));
end entity one2eight;

architecture Struct of one2eight is
begin
process(d,s)
begin
    y(0) <= (not s(0)) and (not s(1)) and (not s(2)) and d;
    y(1) <= (s(0)) and (not s(1)) and (not s(2)) and d;
    y(2) <= (not s(0)) and (s(1)) and (not s(2)) and d;
    y(3) <= (s(0)) and (s(1)) and (not s(2)) and d;
    y(4) <= (not s(0)) and (not s(1)) and (s(2)) and d;
    y(5) <= (s(0)) and (not s(1)) and (s(2)) and d;
    y(6) <= (not s(0)) and (s(1)) and (s(2)) and d;
    y(7) <= (s(0)) and (s(1)) and (s(2)) and d;
end process;
end Struct;