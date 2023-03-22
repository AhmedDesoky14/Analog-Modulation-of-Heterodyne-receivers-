%% Reading Signals
Number_of_signals = 5;  %Dealing with 5 signals
[Signal_1_Stereo,Fs_1] = audioread('Short_BBCArabic2.wav'); %Read Signal 1
Signal_1 = [(Signal_1_Stereo(:,1))+(Signal_1_Stereo(:,2))]; %Converting Stereo into Mono
[Signal_2_Stereo,Fs_2] = audioread('Short_QuranPalestine.wav'); %Read Signal 2
Signal_2 = [(Signal_2_Stereo(:,1))+(Signal_2_Stereo(:,2))]; %Converting Stereo into Mono
[Signal_3_Stereo,Fs_3] = audioread('Short_SkyNewsArabia.wav'); %Read Signal 3
Signal_3 = [(Signal_3_Stereo(:,1))+(Signal_3_Stereo(:,2))]; %Converting Stereo into Mono
[Signal_4_Stereo,Fs_4] = audioread('Short_RussianVoice.wav'); %Read Signal 4
Signal_4 = [(Signal_4_Stereo(:,1))+(Signal_4_Stereo(:,2))]; %Converting Stereo into Mono
[Signal_5_Stereo,Fs_5] = audioread('Short_FM9090.wav'); %Read Signal 5
Signal_5 = [(Signal_5_Stereo(:,1))+(Signal_5_Stereo(:,2))]; %Converting Stereo into Mono
%getting signals lengths
L1=length(Signal_1);L2=length(Signal_2);L3=length(Signal_3);L4=length(Signal_4);L5=length(Signal_5);
Lengths=[L1 L2 L3 L4 L5];
%finding the longest signal
Lmax=L1;
for i=2:Number_of_signals
    if Lengths(i) > Lmax
        Lmax=Lengths(i);
    end
end
%Padding signals to make them with same length
Signal_1 = [Signal_1;zeros(Lmax-L1,1)]; %Padding Signal 1
Signal_2 = [Signal_2;zeros(Lmax-L2,1)]; %Padding Signal 2
Signal_3 = [Signal_3;zeros(Lmax-L3,1)]; %Padding Signal 3
Signal_4 = [Signal_4;zeros(Lmax-L4,1)]; %Padding Signal 4
Signal_5 = [Signal_5;zeros(Lmax-L5,1)]; %Padding Signal 5
%% AM Modulation
%Since Fn>Fs/2 %We increase the signals Sampling frequency
Signal_1 = interp(Signal_1,20);
Signal_2 = interp(Signal_2,20);
Signal_3 = interp(Signal_3,20);
Signal_4 = interp(Signal_4,20);
Signal_5 = interp(Signal_5,20);
% Parameters for all signals
Fs=20*Fs_1; %Sampling Frequency is same for all signals
Lmax = 20*Lmax;
Ts=1/Fs;
t=0:Ts:(Lmax-1)*Ts;
k=(-Lmax/2):(Lmax/2-1);
f=k*(Fs/Lmax);
%Signal 1 Modulation
W1=2*pi*100e+3;
C1=cos(W1*t);
Signal_1_Mod=Signal_1.*C1.';
%Signal 2 Modulation
W2=2*pi*150e+3;
C2=cos(W2*t);
Signal_2_Mod=Signal_2.*C2.';
%Signal 3 Modulation
W3=2*pi*200e+3;
C3=cos(W3*t);
Signal_3_Mod=Signal_3.*C3.';
%Signal 4 Modulation
W4=2*pi*250e+3;
C4=cos(W4*t);
Signal_4_Mod=Signal_4.*C4.';
%Signal 5 Modulation
W5=2*pi*300e+3;
C5=cos(W5*t);
Signal_5_Mod=Signal_5.*C5.';
%Multiplexed Signals
Multiplexed_Signals=Signal_1_Mod+Signal_2_Mod+Signal_3_Mod+Signal_4_Mod+Signal_5_Mod;
Multiplexed_Signals_FD=fft(Multiplexed_Signals);
plot(f,fftshift(abs(Multiplexed_Signals_FD)));
xlabel('Frequency in Hz');
title('Spectrum of the output of the Transmitter');
%% RF Stage
%Designing Band Pass Filter for Interference-Image Rejection
prompt="Choose Channel Number: ";
Ch_Num = input(prompt);
if(Ch_Num == 1)
A_stop1 = 60;		% Attenuation in the first stopband = 60 dB
F_stop1 = 85400;	% Edge of the stopband = 85400 Hz
F_pass1 = 88400;	% Edge of the passband = 88400 Hz
F_pass2 = 111500;	% Closing edge of the passband = 111500 Hz
F_stop2 = 114500;	% Edge of the second stopband = 114500 Hz
A_stop2 = 60;		% Attenuation in the second stopband = 60 dB
A_pass = 1;		% Amount of ripple allowed in the passband = 1 dB
elseif(Ch_Num == 2)
A_stop1 = 60;		% Attenuation in the first stopband = 60 dB
F_stop1 = 117500;	% Edge of the stopband = 117500 Hz
F_pass1 = 120500;	% Edge of the passband = 120500 Hz
F_pass2 = 186500;	% Closing edge of the passband = 186500 Hz
F_stop2 = 189500;	% Edge of the second stopband = 189500 Hz
A_stop2 = 60;		% Attenuation in the second stopband = 60 dB
A_pass = 1;		% Amount of ripple allowed in the passband = 1 dB    
elseif(Ch_Num == 3)
A_stop1 = 60;		% Attenuation in the first stopband = 60 dB
F_stop1 = 186000;	% Edge of the stopband = 186000 Hz
F_pass1 = 189000;	% Edge of the passband = 189000 Hz
F_pass2 = 212500;	% Closing edge of the passband = 212500 Hz
F_stop2 = 215500;	% Edge of the second stopband = 215500 Hz
A_stop2 = 60;		% Attenuation in the second stopband = 60 dB
A_pass = 1;		% Amount of ripple allowed in the passband = 1 dB    
elseif(Ch_Num == 4)
A_stop1 = 60;		% Attenuation in the first stopband = 60 dB
F_stop1 = 217000;	% Edge of the stopband = 217000 Hz
F_pass1 = 220000;	% Edge of the passband = 220000 Hz
F_pass2 = 280000;	% Closing edge of the passband = 280000 Hz
F_stop2 = 283000;	% Edge of the second stopband = 283000 Hz
A_stop2 = 60;		% Attenuation in the second stopband = 60 dB
A_pass = 1;		% Amount of ripple allowed in the passband = 1 dB    
elseif(Ch_Num == 5)
A_stop1 = 60;		% Attenuation in the first stopband = 60 dB
F_stop1 = 278000;	% Edge of the stopband = 280500 Hz
F_pass1 = 281000;	% Edge of the passband = 281000 Hz
F_pass2 = 331000;	% Closing edge of the passband = 331000 Hz
F_stop2 = 334000;	% Edge of the second stopband = 334000 Hz
A_stop2 = 60;		% Attenuation in the second stopband = 60 dB
A_pass = 1;		% Amount of ripple allowed in the passband = 1 dB
end
BandPassSpecObj = ...
fdesign.bandpass('Fst1,Fp1,Fp2,Fst2,Ast1,Ap,Ast2', ...
F_stop1, F_pass1, F_pass2, F_stop2, A_stop1, A_pass, ...
A_stop2,Fs);
BandPassFilter1 = design(BandPassSpecObj, 'equiripple');
BandPassFiltSysObj1 = design(BandPassSpecObj,...
'equiripple','SystemObject',true);
%fvtool(BandPassFilter1) %plot the filter magnitude response to check it
Signal_RF=filter(BandPassFilter1,Multiplexed_Signals);
Signal_RF_FD=fft(Signal_RF);

%Without using RF Filter Code Line
%Before it, remove or comment the lines 122,123
%Signal_RF=Multiplexed_Signals;

plot(f,fftshift(abs(Signal_RF_FD)));
xlabel('Frequency in Hz');
title('Message Signal at RF Stage');
%% The Oscillator Mixer after RF Stage
WIF=2*pi*25e+3;
if(Ch_Num == 1)
    W_Osc=W1+WIF;
    Signal_IF=Signal_RF.*cos(W_Osc*t).';
    Signal_IF_FD=fft(Signal_IF);
elseif(Ch_Num == 2)
    W_Osc=W2+WIF;
    Signal_IF=Signal_RF.*cos(W_Osc*t).';
    Signal_IF_FD=fft(Signal_IF);
elseif(Ch_Num == 3)
    W_Osc=W3+WIF;
    Signal_IF=Signal_RF.*cos(W_Osc*t).';
    Signal_IF_FD=fft(Signal_IF);
elseif(Ch_Num == 4)
    W_Osc=W4+WIF;
    Signal_IF=Signal_RF.*cos(W_Osc*t).';
    Signal_IF_FD=fft(Signal_IF); 
elseif(Ch_Num == 5)
    W_Osc=W5+WIF;
    Signal_IF=Signal_RF.*cos(W_Osc*t).';
    Signal_IF_FD=fft(Signal_IF);
end
plot(f,fftshift(abs(Signal_IF_FD)));
xlabel('Frequency in Hz');
title('Message after the mixer of RF Stage');
%% IF Stage
%Designing Band Pass Filter
if(Ch_Num == 1)
A_stop1 = 60;		% Attenuation in the first stopband = 60 dB
F_stop1 = 10450;	% Edge of the stopband = 10450 Hz
F_pass1 = 13450;	% Edge of the passband = 13450 Hz
F_pass2 = 36550;	% Closing edge of the passband = 36550 Hz
F_stop2 = 39550;	% Edge of the second stopband = 39550 Hz
A_stop2 = 60;		% Attenuation in the second stopband = 60 dB
A_pass = 1;         % Amount of ripple allowed in the passband = 1 dB
elseif(Ch_Num == 2)
A_stop1 = 60;		% Attenuation in the first stopband = 60 dB
F_stop1 = 1;        % Edge of the stopband = 4 Hz
F_pass1 = 3000; 	% Edge of the passband = 3000 Hz
F_pass2 = 58000;	% Closing edge of the passband = 58000 Hz
F_stop2 = 61000;	% Edge of the second stopband = 61000 Hz
A_stop2 = 60;		% Attenuation in the second stopband = 60 dB
A_pass = 1;		% Amount of ripple allowed in the passband = 1 dB  
elseif(Ch_Num == 3)
A_stop1 = 60;		% Attenuation in the first stopband = 60 dB
F_stop1 = 10250;	% Edge of the stopband = 10250 Hz
F_pass1 = 13250;	% Edge of the passband = 13250 Hz
F_pass2 = 36750;	% Closing edge of the passband = 36750 Hz
F_stop2 = 39750;	% Edge of the second stopband = 39750 Hz
A_stop2 = 60;		% Attenuation in the second stopband = 60 dB
A_pass = 1;		% Amount of ripple allowed in the passband = 1 dB 
elseif(Ch_Num == 4)
A_stop1 = 60;		% Attenuation in the first stopband = 60 dB
F_stop1 = 1;        % Edge of the stopband = 1 Hz
F_pass1 = 3000;     % Edge of the passband = 3000 Hz
F_pass2 = 55000;	% Closing edge of the passband = 55000 Hz
F_stop2 = 58000;	% Edge of the second stopband = 58000 Hz
A_stop2 = 60;		% Attenuation in the second stopband = 60 dB
A_pass = 1;		% Amount of ripple allowed in the passband = 1 dB    
elseif(Ch_Num == 5)
A_stop1 = 60;		% Attenuation in the first stopband = 60 dB
F_stop1 = 1;        % Edge of the stopband = 1 Hz
F_pass1 = 3000;     % Edge of the passband = 3000 Hz
F_pass2 = 50500;	% Closing edge of the passband = 50500 Hz
F_stop2 = 53500;	% Edge of the second stopband = 53500 Hz
A_stop2 = 60;		% Attenuation in the second stopband = 60 dB
A_pass = 1;         % Amount of ripple allowed in the passband = 1 dB    
end
BandPassSpecObj = ...
fdesign.bandpass('Fst1,Fp1,Fp2,Fst2,Ast1,Ap,Ast2', ...
F_stop1, F_pass1, F_pass2, F_stop2, A_stop1, A_pass, ...
A_stop2, Fs);
BandPassFilter2 = design(BandPassSpecObj, 'equiripple');
BandPassFiltSysObj2 = design(BandPassSpecObj,...
'equiripple','SystemObject',true);
%fvtool(BandPassFilter2) %plot the filter magnitude response to check it
Signal_IFB=filter(BandPassFilter2,Signal_IF);
Signal_IFB_FD=fft(Signal_IFB);
%signal after filtering in IF Stage
plot(f,fftshift(abs(Signal_IFB_FD)));
xlabel('Frequency in Hz');
title('Message after the filter in IF Stage');
%% Baseband Detection Stage
%mixer to make signal in base band
Signal_BB=Signal_IFB.*cos(WIF*t).';
Signal_BB_FD=fft(Signal_BB);
plot(f,fftshift(abs(Signal_BB_FD)));
xlabel('Frequency in Hz');
title('Message after mixer at Baseband Detection');
%LPF Designing
F_pass = 25000;  % Edge of the passband = 25000 Hz
F_stop = 26000;  % Edge of the stopband = 26000 Hz
A_pass = 1;      % Amount of ripple allowed in the passband = 1 dB   
A_stop = 60;     % Attenuation in the first stopband = 60 dB
lowpass = fdesign.lowpass(F_pass,F_stop,A_pass,A_stop,Fs);
lowpass_filter= design(lowpass,'equiripple');
%fvtool(lowpass_filter ) %plot the filter magnitude response to check it
%Signal After LPF %Original Signal
Out_Signal=filter(lowpass_filter,Signal_BB);
Out_Signal_FD=fft(Out_Signal);
plot(f,fftshift(abs(Out_Signal_FD)));
xlabel('Frequency in Hz');
title('Desired Signal in the Baseband');
%Recover and play the Original Signal
Signal=downsample(Out_Signal,20);
sound(Signal,Fs/20);