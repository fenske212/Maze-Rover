% A .m file extension for matlab might be recognized as objective-c file on GitHub, so this is why the extension is matlab.

Project Spyn - Demonstration
FSE 100: Group_7
Name
Git-Hub
ASU email
Brandon Fenske  fenske212 bafenske@asu.edu
Jasmina Lubovac jasLubovac  jlubovac@asu.edu
Mazhar Bilgrami Maz-Bil mbilgram@asu.edu
Christopher Stone ChrisrunnerR castone7@asu.edu
Pranav Appasaheb Zagade PranavZagade  pzagade@asu.edu


Colour Checklist

Sensor checklist

yellow and starts the navigation 

red and stops for 4 seconds

green and simulate pickup

blue and simulates drop off


Color Sensor
clear all
myev3 = legoev3('Bluetooth','/dev/tty.RBT-SerialPort');
mycolorsensor = colorSensor(myev3)
color = readColor(mycolorsensor)
intensity = readLightIntensity(mycolorsensor)
intensity = readLightIntensity(mycolorsensor,'reflected')
Yellow: start the navigation
%Red: stop for 4 seconds
%Green: simulate pickup
%Blue: simulate drop off


Global key1 
% InitKeyboard();
While 1 
Pause(.01)
Switch key1
Case 'yellow'
	disp('yellow detected)'








Key TEST
clc
clear all
myev3 = legoev3('Bluetooth','/dev/tty.RBT-SerialPort');
playTone(myev3,500,3,2)
mymotor = motor(myev3,'A')
mymotor2 = motor(myev3,'B')
global key
InitKeyboard();
while 1
   pause(0.1);
   switch key
       case 'uparrow'
           disp('Up Arrow Pressed');
           start(mymotor)
           start(mymotor2)
           mymotor.Speed = -100
           mymotor2.Speed = -100
     
       case 'downarrow'
           disp('Down Arrow Pressed!');
           start(mymotor)
           start(mymotor2)
           mymotor.Speed = 100
           mymotor2.Speed = 100
       case 'leftarrow'
           disp('Left Arrow Pressed!');
           start(mymotor)
           start(mymotor2)
           mymotor2.Speed = -50
           mymotor.Speed = -5
       case 'rightarrow'
           disp('Right Arrow Pressed!');
           start(mymotor)
           start(mymotor2)
           mymotor.Speed = -50
           mymotor2.Speed = -5
       case 0  % no Key is pressed
          disp('No Key Pressed');
          stop(mymotor)
          stop(mymotor2)
       case 'q'
           break;
   end
end
CloseKeyboard();

 Sonic Sensor Test
clc
clear all
myev3 = legoev3('Bluetooth','/dev/tty.RBT-SerialPort');
playTone(myev3,500,3,2)
mysonicsensor = sonicSensor(myev3,3)
distance = readDistance(mysonicsensor)






https://www.mathworks.com/help/supportpkg/legomindstormsev3io/





javaclasspath('dir/EV3_Toolbox/EV3');

brick = Brick('ioType','wifi','wfAddr','127.0.0.1','wfPort',5555,'wfSN','0016533dbaf5');







----------------------------------------
Maz trying to code:


brick = ConnectBrick('RBT');

%{
ports:
ultrasonic: 1
color: 2
%%%%touch: 3
left motor:  A
right motor: B
%}


motorlf = -57;   %A
motorrf = -54.8; %B
motorlb = 20;
motorrb = 18.5;

threshold = 50;

brick.SetColorMode(2, 2);

while 1
    %Move Forward
    brick.MoveMotor('A', motorlf);
    brick.MoveMotor('B', motorrf);
    
    %Get Sensor Readings
%%%%%%    touch = brick.TouchPressed(3);
    color = brick.ColorCode(2);
    distance = brick.UltrasonicDist(1);
    
    %Color Decisions
    if color == 5                      %if color is red stop for 4 sec                   
        disp('red');
        brick.StopMotor('AB', 'Brake'); %Brake to prevent going off course
        pause(4); %wait 4 seconds
        brick.MoveMotor('A', motorlf); 
        brick.MoveMotor('B', motorrf);
        pause(0.5);
    elseif color == 2 || color == 3    %if color is blue or green, activate keyboard control
        disp('blue/green');
        run('kbrdcontrol');
        brick.MoveMotor('A', motorlf);
        brick.MoveMotor('B', motorrf);
        pause(6);
    end
    
    %Navigation
    if distance > threshold                %if right wall falls away from right side
        pause(0.6); %wait to get past wall
        brick.StopMotor('AB', 'Brake');
        brick.MoveMotor('A', -20);
        pause(2.3); %turning time
        brick.StopMotor('A', 'Brake');
        brick.MoveMotor('A', motorlf); 
        brick.MoveMotor('B', motorrf);
        pause(2);
    end 
%%%%    if touch %if hit wall in front
        pause(1); %keep going forward for a short period of time in order to calibrate
        
%%%        disp('touched');
        brick.StopMotor('AB');          %stop
        dist = brick.UltrasonicDist(1); %get distance from right wall
        brick.MoveMotor('A', motorlb);
        brick.MoveMotor('B', motorrb);
        pause(3.5); %time to back up from wall
        brick.StopMotor('AB', 'Brake'); %stop
        
        %theoretically should never get here if previous method right
        if distance < threshold %if there is no wall on the right
            brick.MoveMotor('B', -18.5); 
            pause(2.5);
            brick.StopMotor('B', 'Brake');
            brick.MoveMotor('A', motorlf); 
            brick.MoveMotor('B', motorrf);
            pause(2);
        else %if there is a wall on the right
            brick.MoveMotor('A', -21);
            pause(2.5);
            brick.StopMotor('A', 'Brake');
            brick.MoveMotor('A', motorlf); 
            brick.MoveMotor('B', motorrf);
            pause(2);
        end
    end
end


MATLAB CODE:

main.m
​​clear all
%myev3 = legoev3('Bluetooth','/dev/tty.RBT-SerialPort');
myev3 = legoev3('USB');
mycolorsensor = colorSensor(myev3)
mysonicsensor = sonicSensor(myev3,3)
mymotor = motor(myev3,'A')
mymotor2 = motor(myev3,'B')
while 1
   color = readColor(mycolorsensor)
%   intensity = readLightIntensity(mycolorsensor)
%   intensity = readLightIntensity(mycolorsensor,'reflected')
   switch color
       case 'green'
           %distance while
           while 1
               distance_1 = readDistance(mysonicsensor)
               convert_in_cm = distance_1*100
               %start(mymotor)
               %start(mymotor2)
                   if convert_in_cm < 35
                       disp('NOOooo turn')
                       stop(mymotor)
                       stop(mymotor2)
                   else
                       disp('i can make a turn!!!')
                       start(mymotor)
                       start(mymotor2)
                       pause(0.5)
                       mymotor.Speed = -40
                       mymotor2.Speed = -40
                   end               
           end
           stop(mymotor)
           stop(mymotor2)
           break
       case 'red'
           break
       case 'blue'
           break
       case 'yellow'
           break    
   end       
end

check_1.m

clear all
%myev3 = legoev3('Bluetooth','/dev/tty.RBT-SerialPort');
myev3 = legoev3('USB');
mysonicsensor = sonicSensor(myev3,3)
mymotor = motor(myev3,'A')
mymotor2 = motor(myev3,'B')
while 1
   distance_1 = readDistance(mysonicsensor)
   convert_in_cm = distance_1*100
   if convert_in_cm<35
       start(mymotor)
       start(mymotor2)
       pause(0.20)
       mymotor.Speed = -50
       mymotor2.Speed = 50
       stop(mymotor)
       stop(mymotor2)
   else
       start(mymotor)
       start(mymotor2)
       mymotor.Speed = -80
       mymotor2.Speed = -80
       disp('Move forward')
   end
end


testclaw.m
clc
clear all
%myev3 = legoev3('Bluetooth','/dev/tty.RBT-SerialPort');
myev3 = legoev3('USB');
%intensity = readLightIntensity(mycolorsensor)
%intensity = readLightIntensity(mycolorsensor,'reflected')
mymotor = motor(myev3,'D')
pause(1.5)
start(mymotor)
mymotor.Speed = 100
pause(1)
stop(mymotor)

test3.m
clc
clear all
myev3 = legoev3('USB');
playTone(myev3,500,3,2)
mymotor = motor(myev3,'A')
mymotor2 = motor(myev3,'B')
mysonicsensor = sonicSensor(myev3,3)
mysonicsensor2 = sonicSensor(myev3,4)
start(mymotor)
start(mymotor2)
%counter = 0;
while 1
      distance = readDistance(mysonicsensor)
      distance2 = readDistance(mysonicsensor2)
      convert_in_cm = distance*100 %sensor 1
      convert_in_cm2 = distance2*100 %sensor 2
      mymotor.Speed = -98
      mymotor2.Speed = -100
     
      if convert_in_cm < 30
       stop(mymotor)
       stop(mymotor2)
       break
      end
      %counter=counter+1;
end




Extra Code (requires debugging and testing) :


brick = ConnectBrick('RBT');

%{
ports:
ultrasonic: 1
color: 2
%%%%touch: 3
left motor:  A
right motor: B
%}


motorlf = -57;   %A
motorrf = -54.8; %B
motorlb = 20;
motorrb = 18.5;

threshold = 50;

brick.SetColorMode(2, 2);

while 1
    %Move Forward
    brick.MoveMotor('A', motorlf);
    brick.MoveMotor('B', motorrf);
    
    %Get Sensor Readings
%%%%%%    touch = brick.TouchPressed(3);
    color = brick.ColorCode(2);
    distance = brick.UltrasonicDist(1);
    
    %Color Decisions
    if color == 5                      %if color is red stop for 4 sec                   
        disp('red');
        brick.StopMotor('AB', 'Brake'); %Brake to prevent going off course
        pause(4); %wait 4 seconds
        brick.MoveMotor('A', motorlf); 
        brick.MoveMotor('B', motorrf);
        pause(0.5);
    elseif color == 2 || color == 3    %if color is blue or green, activate keyboard control
        disp('blue/green');
        run('kbrdcontrol');
        brick.MoveMotor('A', motorlf);
        brick.MoveMotor('B', motorrf);
        pause(6);
    end
    
    %Navigation
    if distance > threshold                %if right wall falls away from right side
        pause(0.6); %wait to get past wall
        brick.StopMotor('AB', 'Brake');
        brick.MoveMotor('A', -20);
        pause(2.3); %turning time
        brick.StopMotor('A', 'Brake');
        brick.MoveMotor('A', motorlf); 
        brick.MoveMotor('B', motorrf);
        pause(2);
    end 
%%%%    if touch %if hit wall in front
        pause(1); %keep going forward for a short period of time in order to calibrate
        
%%%        disp('touched');
        brick.StopMotor('AB');          %stop
        dist = brick.UltrasonicDist(1); %get distance from right wall
        brick.MoveMotor('A', motorlb);
        brick.MoveMotor('B', motorrb);
        pause(3.5); %time to back up from wall
        brick.StopMotor('AB', 'Brake'); %stop
        
        %theoretically should never get here if previous method right
        if distance < threshold %if there is no wall on the right
            brick.MoveMotor('B', -18.5); 
            pause(2.5);
            brick.StopMotor('B', 'Brake');
            brick.MoveMotor('A', motorlf); 
            brick.MoveMotor('B', motorrf);
            pause(2);
        else %if there is a wall on the right
            brick.MoveMotor('A', -21);
            pause(2.5);
            brick.StopMotor('A', 'Brake');
            brick.MoveMotor('A', motorlf); 
            brick.MoveMotor('B', motorrf);
            pause(2);
        end
    end
end






