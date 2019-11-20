library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

use ieee.math_real.uniform;
use ieee.math_real.floor;



entity TestOfSimon IS
port (l0, l1, l2, l3 : OUT STD_LOGIC := '0'; clock, b0, b1 : IN STD_LOGIC);
END TestOfSimon;

ARCHITECTURE logic OF TestOfSimon IS

type INT_ARRAY is ARRAY (0 to 9) OF INTEGER;

signal counter : STD_LOGIC_VECTOR(25 downto 0) := "00000000000000000000000000";
--signal myCcounter : integer := 0;
signal startTimer : STD_LOGIC := '0';
--signal rcounter : integer := 0;
--signal rNum : integer;
--signal rclock : STD_LOGIC := '0';
signal sequence : INT_ARRAY := (2, 3, 0, 0, 1, 3, 2, 3, 1, 0);
signal turnCount : integer := 0;
signal display : STD_LOGIC := '0'; -- this is basically a boolean to say if a part of the sequence is ready to be displayed
signal displayed : integer := 0;
BEGIN



ledOn : process (clock)
variable currentNum: integer;
BEGIN
if clock'event and clock = '0' then
if display = '1' then
if displayed <= turnCount then

if startTimer = '1' then
if counter < "10111110101111000010000000" then  
counter <= counter + 1;
end if;
end if;


currentNum := sequence(displayed);
if currentNum = 0 and startTimer = '0'then
startTimer <= '1';
l0 <= '1';
end if;

if currentNum = 1 and startTimer = '0' then
startTimer <= '1';
l1 <= '1';
end if;

if currentNum = 2 and startTimer = '0' then
startTimer <= '1';
l2 <= '1';
end if;

if currentNum = 3 and startTimer = '0' then
startTimer <= '1';
l3 <= '1';
end if;

if startTimer = '1' AND counter = "10111110101111000010000000" then
l0 <= '0';
l1 <= '0';
l2 <= '0';
l3 <= '0';
startTimer <= '0';
counter <= (others => '0');
displayed <= displayed + 1;
end if;
else
displayed <= 0;
display <= '0';
turnCount <= turnCount + 1;
end if; --if numShowed <= turnCount then
elsif b0 = '0' then
display <= '1';
end if; --if display = '1' then
end if; --if clock'event and clock = '0' then
END process ledOn;


--randCounter : process (rclock)
--
--BEGIN -- randCounter: this will be the counter that will generate a random number
-- if rclock'event and rclock = '1' then  -- rising clock edge
-- if rcounter < 3 then   -- Binary value is 4
-- rcounter <= rcounter + 1;
-- else
-- rcounter <= 0;
-- end if;
-- end if;
--END process randCounter;
--
--
--myClock : process (clock)
--BEGIN
--if RISING_EDGE(clock) then
-- if myCcounter < 7 then
-- myCcounter <= myCcounter + 1;
-- else
-- myCcounter <= 0;
-- rclock <= NOT rclock;
-- end if;
--end if;
--end process myClock;
END logic;
