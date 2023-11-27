library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;
entity SHIFTer8 is
port (a: in std_logic_vector (15 downto 0);y:out std_logic_vector(15 downto 0));
end entity SHIFTer8;
architecture Struct of SHIFTer8 is
signal p:std_logic_vector(15 downto 0);
signal q:std_logic_vector(15 downto 0);

component two2one is
port (I0, I1, s: in std_logic; Y: out std_logic);
end component two2one;
begin


n4_bit : for i in 0 to 15 generate
lsb: if i < 8 generate
b2: two2one port map(p(i), '0', '1', q(i));
end generate lsb;
msb: if i > 7 generate
b2: two2one port map( p(i), p(i-8), '1', q(i));
end generate msb;
end generate;


end Struct;
