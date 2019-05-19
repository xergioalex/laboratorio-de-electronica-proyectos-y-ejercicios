
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Decifrador is
    Port ( dato_in : in  STD_LOGIC_VECTOR (7 downto 0);
           memory : in  STD_LOGIC;
			  dato_completo : out std_logic_vector (15 downto 0)
			  );
			  
end Decifrador;

architecture arch_Decifrador of Decifrador is
	type Mem is array (0 to 255) of STD_LOGIC_VECTOR (3 downto 0);
		
	signal decenas : std_logic_vector (3 downto 0)  := (others => '0');
	signal centenas : std_logic_vector (3 downto 0) := (others => '0');
	signal unidades : std_logic_vector (3 downto 0) := (others => '0');
	signal mem_out : std_logic_vector (3 downto 0) := (others => '0');
	
	signal Cent : Mem;
	signal Dec : Mem;
	signal Uni : Mem;
	procedure Fill_Mem( signal Cente : out Mem; signal Dece : out Mem; signal Unin : out Mem) is
		variable Unidades, Decenas, Centenas : Integer range 0 to 11 := 0;
		variable Uni1, Dec1, Cent1 : Mem;
	begin 
		for i in 0 to 255 loop
			
			Uni1(i) := CONV_STD_LOGIC_VECTOR(Unidades, 4);
			Dec1(i) := CONV_STD_LOGIC_VECTOR(Decenas, 4);
			Cent1(i) := CONV_STD_LOGIC_VECTOR(Centenas, 4);
			Unidades := Unidades + 1;
			if (Unidades = 10) then
				Unidades := 0;
				Decenas := Decenas + 1;
			end if;
			if (Decenas = 10) then
				Decenas := 0;
				Centenas := Centenas + 1;
			end if;			
		end loop;
		Unin <= Uni1;
		Dece <= Dec1;
		Cente <= Cent1;
	end Fill_Mem;
	
begin
	Fill_Mem(Cent, Dec, Uni);
	process(dato_in, Dec, Cent, Uni, memory)
	begin
		decenas <= Dec(CONV_INTEGER(dato_in));
		centenas <= Cent(CONV_INTEGER(dato_in));
		unidades <= Uni(CONV_INTEGER(dato_in));
		mem_out <= "000"&memory;
	end process;
	dato_completo <= mem_out&centenas&decenas&unidades;
	
end arch_Decifrador;

