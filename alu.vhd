library ieee;
use ieee.std_logic_1164.all;

entity alu is
	port(A, B: in std_logic_vector(15 downto 0);
		 control: in std_logic_vector(3 downto 0);
		  z: out std_logic;
		 out_alu: out std_logic_vector(15 downto 0));
end entity alu;

architecture struct of ALU is

	component sixteen_bit_adder_sub is
		port(A, B: in std_logic_vector(15 downto 0);
		 M: in std_logic;
		 S: out std_logic_vector(15 downto 0); 
		 Cout: out std_logic);
	end component sixteen_bit_adder_sub;

	component sixteen_bit_and is
		port(A, B: in std_logic_vector(15 downto 0);
		 outp: out std_logic_vector(15 downto 0)
		 );
	end component sixteen_bit_and;

	component sixteen_bit_or is
		port(A, B: in std_logic_vector(15 downto 0);
		 outp: out std_logic_vector(15 downto 0)
		 );
	end component sixteen_bit_or;
	component BitInverter is
    Port ( 
        input_bits : in  std_logic_vector(15 downto 0);
        output_bits : out std_logic_vector(15 downto 0)
    );
end component BitInverter;

component sixteen_bit_mul  is
  port (A3,A2,A1,A0,B3,B2,B1,B0: in std_logic; m: out std_logic_vector(7 downto 0));
end component sixteen_bit_mul;
	
entity Mux_8 is
	port(I0, I1, I2, I3, I4, I5, I6, I7: in std_logic;
			S: out std_logic;
			sel0, sel1, sel2: in  std_logic);
end entity Mux_8;


	component zero_check is
		port(A: in std_logic_vector(15 downto 0);
			S: out std_logic);
	end component zero_check;

	signal s1, s2, s3, s4, s5 : std_logic_vector(15 downto 0):="0000000000000000";
	signal s6, s7, Abar: std_logic_vector(15 downto 0):="0000000000000000";
begin
	add_instance: sixteen_bit_adder_sub
		port map (
		 	A => A, B => B, M=> '0' ,S => s1(15 downto 0)
		 );
		sub_instance: sixteen_bit_adder_sub
		port map (
		 	A => A, B => B, M=> '1' ,S => s2(15 downto 0)
		 );  
	and_instance: sixteen_bit_and
		port map (
			A => A, B => B, outp => s3(15 downto 0)
		);
	or_instance: sixteen_bit_or
		port map (
			A => A, B => B, outp => s4(15 downto 0)
		);
		mul_instance: sixteen_bit_mul
		port map (
			A3 => A(3), A2=>A(2), A1=>A(1), A0=>A(0), B3 => B(3), B2=>B(2), B1=>B(1), B0=>B(0), m => s5(15 downto 0)
		);
		invert: BitInverter
		port map(input_bits=>A, output_bits=>Abar);
		
		imp_instance: sixteen_bit_or
		port map (
			A => Abar, B => B, outp => s6(15 downto 0)
		);
	Mux: Mux_8
		port map (
			I0 => s1, I1 => s2, I2 => s5, I3 => s3, I4=>s4, I5=>s6, sel0 => control(0), 
			sel1 => control(1), sel2=>control(2), sel3=>'0', S => s7
		);


	out_alu <= s7;

	zero: zero_check
		port map (
			A => s7, S => z
		);

end architecture struct;
