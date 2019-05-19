
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Memorias is
	port(	clk: in std_logic;
			selector : in std_logic;
			read_write: in std_logic;
			ready: in std_logic;
			cont_1 : in std_logic_vector(7 downto 0);
			cont_2 : in std_logic_vector(7 downto 0);
			dato: in std_logic_vector(7 downto 0);
			dato_display: out std_logic_vector(7 downto 0)
		 );
end Memorias;

architecture arq_memorias of Memorias is
	type memory is array (0 to 255) of std_logic_vector(7 downto 0);
	signal servo_motor_1 : memory := ((others => (others =>'0')));
	signal servo_motor_2 : memory := ((others => (others =>'0')));	
	--Contador Guardar
	signal contador_guardar : integer range 0 to 514:=0;
begin 
	process(clk)
	begin 
		if(rising_edge(clk)) then
			if(read_write='0' and ready='1') then
				if(contador_guardar < 256) then
					servo_motor_1(contador_guardar) <= dato;
					contador_guardar <= contador_guardar + 1;
				elsif(contador_guardar >= 512) then
					contador_guardar <= 0;	
				elsif(contador_guardar >= 256) then
					servo_motor_2(contador_guardar-256) <= dato;
					contador_guardar <= contador_guardar + 1;
				end if;					
			end if;
			if(read_write='1') then 
				if(selector='0') then
					dato_display <= servo_motor_1(CONV_INTEGER(cont_1));
				else
					dato_display <= servo_motor_2(CONV_INTEGER(cont_2));
				end if;
			else
				dato_display <= (others =>'0');
			end if;
		end if;
	end process;
	
	
end arq_memorias;

