%     FILTERS      %
%%Part of EE202 Course Project by Aryan, Vardhan and Gautam%%
clc
clear all

Fs=1000; % sampling frequency
Ts=1/Fs; % Sampling period or time step
dt=0:Ts:5-Ts; % 5 second signal duration
f1=10;
f2=30;
f3=70;

%% Input Signal
y_in=5*sin(2*pi*f1*dt)+5*sin(2*pi*f2*dt)+5*sin(2*pi*f3*dt); 
plot(dt,y_in)
title(["Input Signal= 5sin(2\pif_1*t)+5sin(2\pif_2t)+5sin(2\pif_3t)","f_1=10Hz, f_2=30Hz, f=70Hz"])
%% Fourier Transform of Input
nfft=length(y_in);
ff=fft(y_in,nfft);
fffshift=fftshift(ff);    %% Scaling
x=[-(length(ff)/2):((length(ff)/2)-1)]*(Fs/length(ff));


%% IDEAL LPF
Stop_freq=40;
H_lpf=rectangularPulse(-Stop_freq,Stop_freq,x);    %Transfer function
Y_lpf=H_lpf.*fffshift;
figure;
subplot(3,1,1);plot(x,abs(fffshift));title("Input in Frequency Domain");xticks([-500,-400,-300,-200,-100,-70,-30,-10,10,30,70,100,200,300,400,500])
subplot(3,1,2);plot(x,abs(H_lpf));title("Response Function of Filter");xticks([-40,40])
subplot(3,1,3);plot(x,abs(Y_lpf));title("Output in Frequency Domain");xticks([-500,-400,-300,-200,-100,-70,-30,-10,10,30,70,100,200,300,400,500])
sgtitle('Low Pass Filter');

y_out_lpf=ifft(ifftshift(Y_lpf));           %Output


%% IDEAL BPF
Lower_f=20;
Higher_f=50;
H_bpf=rectangularPulse(Lower_f,Higher_f,x)+rectangularPulse(-Higher_f,-Lower_f,x);   %Transfer function
Y_bpf=H_bpf.*fffshift;
figure;
subplot(3,1,1);plot(x,abs(fffshift));title("Input in Frequency Domain");xticks([-500,-400,-300,-200,-100,-70,-30,-10,10,30,70,100,200,300,400,500])
subplot(3,1,2);plot(x,abs(H_bpf));title("Response Function of Filter");xticks([-50,-20,20,50])
subplot(3,1,3);plot(x,abs(Y_bpf));title("Output in Frequency Domain");xticks([-500,-400,-300,-200,-100,-70,-30,-10,10,30,70,100,200,300,400,500])
sgtitle('Band Pass Filter');

y_out_bpf=ifft(ifftshift(Y_bpf));           %Output


%% IDEAL HPF
Pass_freq=40;
H_hpf= x<-40 | x>40;        %Transfer function
Y_hpf=H_hpf.*fffshift;
figure;
subplot(3,1,1);plot(x,abs(fffshift));title("Input in Frequency Domain");xticks([-500,-400,-300,-200,-100,-70,-30,-10,10,30,70,100,200,300,400,500])
subplot(3,1,2);plot(x,abs(H_hpf));title("Response Function of Filter");xticks([-40,40])
subplot(3,1,3);plot(x,abs(Y_hpf));title("Output in Frequency Domain");xticks([-500,-400,-300,-200,-100,-70,-30,-10,10,30,70,100,200,300,400,500])
sgtitle('High Pass Filter');

y_out_hpf=ifft(ifftshift(Y_hpf));           %Output
%% IDEAL BRF
Low_stop=20;
High_stop=50;
H_brf1=x<Low_stop | x>High_stop ;
H_brf2= x>-Low_stop | x<-High_stop;
H_brf=H_brf1.*H_brf2;         %Transfer function
Y_brf=H_brf.*fffshift;
figure;
subplot(3,1,1);plot(x,abs(fffshift));title("Input in Frequency Domain");xticks([-500,-400,-300,-200,-100,-70,-30,-10,10,30,70,100,200,300,400,500])
subplot(3,1,2);plot(x,abs(H_brf));title("Response Function of Filter");xticks([-50,-20,20,50])
subplot(3,1,3);plot(x,abs(Y_brf));title("Output in Frequency Domain");xticks([-500,-400,-300,-200,-100,-70,-30,-10,10,30,70,100,200,300,400,500])
sgtitle('Band Reject Filter');

y_out_brf=ifft(ifftshift(Y_brf));           %Output


%% Filtering Results
figure;
subplot(5,1,1);plot(dt,y_in);title("Input signal in Time Domain");
subplot(5,1,2);plot(dt,y_out_lpf);title("Output under Low Pass Filter");
subplot(5,1,3);plot(dt,y_out_hpf);title("Output under High Pass Filter");
subplot(5,1,4);plot(dt,y_out_bpf);title("Output under Band Pass Filter");
subplot(5,1,5);plot(dt,y_out_brf);title("Output under Band Reject Filter");