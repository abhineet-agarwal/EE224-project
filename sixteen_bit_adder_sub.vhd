library ieee;
use ieee.std_logic_1164.all;
use work.Gates.all;

entity sixteen_bit_adder_sub is
	port(A,B : in std_logic_vector(15 downto 0); M : in std_logic; S : out std_logic_vector(15 downto 0); Cout : out std_logic );
end entity sixteen_bit_adder_sub;	

architecture struct_addsub of sixteen_bit_adder_sub is
   
signal C : std_logic_vector(4 downto 0) := (others=>'0');
signal tBx : std_logic_vector(3 downto 0) := (others=>'0');
begin
C(0) <= M;
gen: for i in 0 to 15 generate
tBx(i)=>M xor B(i);
FA : FULL_ADDER port map (A => A(i), B => tBx(i), Ci => C(i), S => S(i), Co => C(i+1));
end generate gen;
Cout <= C(16);
end architecture struct_addsub;
