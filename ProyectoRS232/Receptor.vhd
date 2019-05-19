library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Receptor is
    Port ( clk_Div_Freq  : in  STD_LOGIC;
           Bit_Entrada : in  STD_LOGIC;
           Habilitador_Recepcion : in  STD_LOGIC;
           Recepcion_completa : out  STD_LOGIC;
           Registro : out  STD_LOGIC_VECTOR (7 downto 0));
end Receptor;

architecture Behavioral of Receptor is

signal cont: integer range 7 downto 0 := 7;
signal estado: integer range 1 to 2 := 1; 
signal registro_acum: std_logic_vector (7 downto 0); 

begin

process(clk_Div_Freq)

begin

 if Rising_edge(clk_Div_Freq) then
 
  if Habilitador_Recepcion = '1' then
   
	if estado = 1 then
	
	 if (cont >= 0 and cont <= 7) then
     registro_acum(cont) <= Bit_Entrada;
	  Recepcion_completa <= '0';
	  cont <= cont - 1;
	 end if; 
	 if cont = 0 then
     Recepcion_completa <= '1';
     estado <= 2;	 
    end if;
	end if;
   
	if estado = 2 then
	
	 Registro <= registro_acum;
	 Recepcion_completa <= '0';
	 cont <= 7;
	 estado <= 1;
	end if;
  end if;
 end if;

end process;
	
end Behavioral;

