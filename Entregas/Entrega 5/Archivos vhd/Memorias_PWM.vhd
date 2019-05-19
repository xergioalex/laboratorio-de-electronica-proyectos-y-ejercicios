
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity Memorias_PWM is
    Port ( dato_memoria1 : in  STD_LOGIC_VECTOR (7 downto 0);
			  dato_memoria2 : in  STD_LOGIC_VECTOR (7 downto 0);
           numero_ciclos1 : out  STD_LOGIC_VECTOR (15 downto 0);
			  numero_ciclos2 : out  STD_LOGIC_VECTOR (15 downto 0)
			  );
end Memorias_PWM;

architecture arch_MPWM of Memorias_PWM is
	type memory is array (0 to 255) of std_logic_vector(15 downto 0);
	signal memoria_PWM : memory;
	
	procedure Fill_Mem( signal memoria_PWM : out memory) is
		variable ciclos_ms : Integer range 0 to 200 := 196;
		variable num_ciclos : Integer range 0 to 65536 := 0;
		variable memoria_aux : memory;
	begin 
		for i in 0 to 255 loop
			num_ciclos := i * ciclos_ms;
			memoria_aux(i) := CONV_STD_LOGIC_VECTOR(num_ciclos, 16);			
		end loop;
		memoria_PWM <= memoria_aux;		
	end Fill_Mem;
	
begin
	Fill_Mem(memoria_PWM);
	process(dato_memoria1, dato_memoria2, memoria_PWM)
	begin
		numero_ciclos1 <= memoria_PWM(CONV_INTEGER(dato_memoria1));
		numero_ciclos2 <= memoria_PWM(CONV_INTEGER(dato_memoria2));		
	end process;
	
end arch_MPWM;

