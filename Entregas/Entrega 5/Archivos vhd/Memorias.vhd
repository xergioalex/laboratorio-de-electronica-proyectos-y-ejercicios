
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Memorias is
	port(	clk: in std_logic;
			clk_PWM : in std_logic;
			ready: in std_logic;
			read_write: in std_logic;
			dato: in std_logic_vector(7 downto 0);
			dato_M1: out std_logic_vector(7 downto 0);
			dato_M2:out std_logic_vector(7 downto 0)
		 );
end Memorias;

architecture arq_memorias of Memorias is
	type memory is array (0 to 255) of std_logic_vector(7 downto 0);
	signal servo_motor_1 : memory := ((others => (others =>'0')));
	signal servo_motor_2 : memory := ((others => (others =>'0')));	
	--Contador Guardar
	signal contador_guardar : std_logic_vector(8 downto 0) := (others =>'0');
	signal contador_leer : std_logic_vector(7 downto 0) := (others =>'0');
begin

	Escribir:
	process(clk)
	begin 
		if(rising_edge(clk)) then
			if(ready='1' and read_write = '0') then
				if (contador_guardar < 256) then
					servo_motor_1(conv_integer(contador_guardar (7 downto 0))) <= dato;
				else
					servo_motor_2(conv_integer(contador_guardar (7 downto 0))) <= dato;
				end if;	
				contador_guardar <= contador_guardar+1;				
			end if;
		end if;
	end process;
	
	Leer:
	process(clk_PWM)
	begin
		if(rising_edge(clk_PWM)) then
			if(read_write = '1') then
				dato_M1 <= servo_motor_1(conv_integer(contador_leer));
				dato_M2 <= servo_motor_2(conv_integer(contador_leer));
				contador_leer <= contador_leer + 1;
			end if;
		end if;
	end process;
end arq_memorias;
