
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Display is
    Port ( clk : in STD_LOGIC;
			  dato_completo : in STD_LOGIC_VECTOR (15 downto 0);
			  anodos_out : out  STD_LOGIC_VECTOR (3 downto 0);
           siete_segmentos : out  STD_LOGIC_VECTOR (6 downto 0));
end Display;

architecture Behavioral of Display is
	signal choose : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
	signal anodos : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
begin
	process (clk) begin
		if(rising_edge(clk)) then	
			if(anodos="1110") then
				anodos <= "1101";
			elsif(anodos="1101") then
			   anodos <= "1011";
			elsif(anodos="1011") then
				anodos <= "0111";
			elsif(anodos="0111") then 
				anodos <= "1110";
			else
				anodos <= "1110";
			end if;
		end if;
	end process;

	process (clk) begin
		if(rising_edge(clk)) then
			case anodos is							
				when "1110" => choose <= dato_completo(3 downto 0);
				when "1101" => choose <= dato_completo(7 downto 4);
				when "1011" => choose <= dato_completo(11 downto 8);
				when "0111" => choose <= dato_completo(15 downto 12);
				when others => choose <= "0000";			
			end case;
		end if;
	end process;

	process (choose) begin
		case choose is		
			when "0000" => siete_segmentos <= "0000001";
			when "0001" => siete_segmentos <= "1001111";
			when "0010" => siete_segmentos <= "0010010";
			when "0011" => siete_segmentos <= "0000110";
			when "0100" => siete_segmentos <= "1001100";
			when "0101" => siete_segmentos <= "0100100";
			when "0110" => siete_segmentos <= "0100000";
			when "0111" => siete_segmentos <= "0001111";
			when "1000" => siete_segmentos <= "0000000";
			when "1001" => siete_segmentos <= "0001100";
			when others => siete_segmentos <= "0000001";
		end case;
		
	end process;
	
	anodos_out <= anodos;
	
end Behavioral;

