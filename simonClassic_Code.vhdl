library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

ENTITY simonClassic IS
port (clock, b0 : IN STD_LOGIC; l0, l1,l2,l3 : OUT STD_LOGIC);
END simonClassic;


ARCHITECTURE behavior OF simonClassic IS
signal randCount : STD_LOGIC_VECTOR(2 downto 0);
signal halfSecCount : STD_LOGIC_VECTOR(24 downto 0);
signal CLK_1HZ : STD_LOGIC;
signal randNum : STD_LOGIC_VECTOR(2 downto 0);
signal startclock : STD_LOGIC;
signal numOfMoves : INTEGER range 0 to 100;
signal simonVector : STD_LOGIC_VECTOR (0 to 1);
signal numOfInputs : INTEGER;

signal userFinishedInput : STD_LOGIC;
signal patternDisplayed : STD_LOGIC;

BEGIN --behavior

randCounter : process (clock)
BEGIN -- randCounter: this will be the counter that will generate a random number
if clock'event and clock = '1' then  -- rising clock edge
if randCount < "100" then   -- Binary value is 4
randCount <= randCount + 1;
else
randCount <= (others => '0');
end if;
end if;
END process randCounter;

halfSecondClock : process
BEGIN
 wait until startclock = '1';
if clock'event and clock = '1' then  -- rising clock edge
if halfSecCount < "1011111010111100001000000" then   -- Binary value is 4
halfSecCount <= halfSecCount + 1;
else
halfSecCount <= (others => '0');
startclock <= '0';
end if;
end if;
END process halfSecondClock;

createAndDisplay : process -- will be adding one value (two bits) to the simonVector after a signal is changed
variable index : integer range 0 to 100;
variable numOfMovesIndex : INTEGER range 0 to 100:= numOfMoves;
SUBTYPE my_loop_range IS natural range 0 to numOfMovesIndex;
BEGIN
wait until userFinishedInput = '0';
 randNum <= randCount;
 index := numOfMoves + numOfMoves;
 simonVector(index) <= randNum(0);
 simonVector(index +1) <= randNum(1);
 numOfMoves <= numOfMoves + 1;
 userFinishedInput <= '1';

  startclock <= '1';
  for ii in my_loop_range loop
wait until startclock = '0';
l0 <= '0'; l1 <= '0'; l2 <= '0'; l3 <= '0';
    if simonVector((2*ii) to (2*ii) + 1) = "00" then
l0 <= '1';
 elsif simonVector((2*ii) to (2*ii) + 1) = "01" then
     l1 <= '1';
 elsif simonVector((2*ii) to (2*ii) + 1) = "10" then
     l2 <= '1';
 elsif simonVector((2*ii) to (2*ii) + 1) = "11" then
     l3 <= '1';
 end if;
END loop;
patternDisplayed <= '1';
END PROCESS createAndDisplay;


userInput : process (clock)
BEGIN -- userInput
if patternDisplayed = '1' then
if b0 = '0' then
userFinishedInput <= '0';
END if;
END if;
END PROCESS userInput;
END behavior;
