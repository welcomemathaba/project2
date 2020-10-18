
load('C:\Users\WMathaba\Documents\plot\TxRF_In.mat')%path to file
load('C:\Users\WMathaba\Documents\plot\TxRF_Out.mat')
load('C:\Users\WMathaba\Documents\plot\RxRF_In.mat')
load('C:\Users\WMathaba\Documents\plot\RxRF_Out.mat')
load('C:\Users\WMathaba\Documents\plot\NoisePower.mat')
   
j = 105;
k = 3000;
st = 1e-08; 
pp = 8;
pulsep = TxRF_In(pp,j);      
ppb = 4;
b = 1;
c = 2; 

pr = 3;
pri = 12;
fr = 4;
ph = 5;
pwt = 9;
pp = 8;    



%%%%%%%%%%%%%%%%%%%%%TxRF_In%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%           
frequency = TxRF_In(fr,j);%0.005; % Frequency should be in Hertz
power = TxRF_In(pr,j);%44301;    %Power should be Watt
phase = TxRF_In(ph,j);
pw = TxRF_In(pwt,j);
pris = TxRF_In(pri,j);
pps = TxRF_In(pp,j);

Amplitude = sqrt(2*power);
w = 2*pi*frequency;
p = 1/(frequency*100);
s = 4*3.3356e-07;
t = pps:p:s;
y = Amplitude*sin((w*t+phase));
t1 = 0:p:pps;
x = 0*t1;

coder.extrinsic('plot')


subplot(4,1,1)
plot(t,y)
hold on
plot(t1,x)
hold on

%axis([0 s -53 53])
xlabel('Time(s)')
ylabel('Amplitude')
title(['Tx in Signal pulse ' ] )
grid on
          
%%%%%%%%%%%%%%%%%%%%%%TxRF_Out%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%            
frequency = TxRF_Out(fr,j);%0.005; % Frequency should be in Hertz
power = TxRF_Out(pr,j);%44301;    %Power should be Watt
phase = TxRF_Out(ph,j);
pw = TxRF_Out(pwt,j);
pris = TxRF_Out(pri,j);
pps = TxRF_Out(pp,j)

Amplitude = sqrt(2*power)
w = 2*pi*frequency;
p = 1/(frequency*100);
s = 1e-05;
t = pps:p:s;
y = Amplitude*sin((w*t+phase));
t2 = (0:pps/2:pps)';
x = 0*t2;


subplot(4,1,2)
plot(t2,x)
hold on
plot(t,y)

%axis([0 s -53 53])
xlabel('Time(s)')
ylabel('Amplitude')
title(['Tx out Signal pulse' ] )
grid on

%%%%%%%%%%%%%%%%%%RxRF_In%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
frequency = RxRF_In(fr,j);%0.005; % Frequency should be in Hertz
power = RxRF_In(pr,j);%44301;    %Power should be Watt
phase = RxRF_In(ph,j);
pw = RxRF_In(pwt,j);
pris = RxRF_In(pri,j);
pps = RxRF_In(pp,j)

Amplitude = sqrt(2*power);
w = 2*pi*frequency;

p = 1/(frequency*100);
s = 5/(frequency/1);
t = pps:p:4*pps;
y = Amplitude*sin((w*t+phase));
t2 = (0:p:pps)';
x = 0*t2;




subplot(4,1,3)

plot(t2,x)
hold on
plot(t,y)
%axis([0 s -53 53])
xlabel('Time(s)')
ylabel('Amplitude')
title(['Rx in Signal pulse '] )
grid on        
        
%%%%%%%%%%%%%%%%%%RxRF_Out%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%to determine coulomb for noise power
e = 32940/1001;
actual = j/e
npv = ceil(actual)
frequency = RxRF_Out(fr,j);%0.005; % Frequency should be in Hertz
power = RxRF_Out(pr,j);%44301;    %Power should be Watt
phase = RxRF_Out(ph,j);
pw = RxRF_Out(pwt,j);
pris = RxRF_Out(pri,j);
pps = RxRF_Out(pp,j);

np = NoisePower(3,npv)
Amplitude = sqrt(2*power);
w = 2*pi*frequency;
namp = sqrt(2*np)
p = 1/(frequency*100);
s = 5/(frequency/1);
t = (pps:p:2*pps)';
y = Amplitude*sin((w*t+phase));
yn = y + namp*randn(size(t));
t2 = (0:p:pps)';
x = 0*t2;



subplot(4,1,4)

plot(t2,x)
hold on
plot(t,yn)
%axis([0 s -53 53])
xlabel('Time(s)')
ylabel('Amplitude')
title(['Rx Out Signal pulse '] )
grid on    
    
    


    