
Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity bcd_counter1 is
	port
	(
		EN, LD, UP, CLR, CLK : in std_logic;
		D		: in std_logic_vector(3 downto 0);
		CO		: out std_logic;
		Q		: out std_logic_vector(3 downto 0)
		
		
	);
end bcd_counter1;

architecture Equations of bcd_counter1 is
	-- internal signal for Q 
	--signal QINT : std_logic_vector(3 downto 0);
	-- internal count variable
	signal COUNT : unsigned(3 downto 0);

begin process(CLK, CLR) 

	begin -- concurrent statements

	-- clear is asynch. 
	if(CLR = '0') then
	-- reset counter
	COUNT <= ( others => '0');
	CO <= '0';
	--QINT <= (others => '0'); --- "0000"
	-- on clk rising edge  
	elsif(CLK'EVENT and CLK='1') then
		CO <= '0';
		if(LD='1' AND EN='1') then
			-- load data D into counter
			COUNT <= unsigned(D);	
		elsif(LD='0' AND EN='1' AND UP='1') then

			-- increment counter
			if(COUNT = "1001") then
				COUNT <= (others => '0');		
				CO <= '1';		-- Set to 0 ? initialize??
			else
				COUNT <= (COUNT+1);
			end if;
		elsif(LD='0' AND EN='1' AND UP='0') then
			-- decrement counter
			if(COUNT=0) then
				COUNT <= (others => '0');
				CO <= '1';
			else
				COUNT <= (COUNT-1);
			end if;
		end if;

		
	end if;

end process;

-- set external 
Q <= std_logic_vector(COUNT);
	
end equations;