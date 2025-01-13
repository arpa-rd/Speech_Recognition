% function mf=manual_mfcc(x,fs)

clc
clear
close all
[x,fs]=audioread('F:\Level-3 Term-1\EEE312\Final Project\Chess\Chess1.wav');

%Amplification
if( max(abs(x))<=1 )
    x = x * 2^15;
end

%pre-emphasis filter
a=[1];
alpha=-0.97;
b=[1 alpha];
y=filter(b,a,x);

%framing
frame_duration=0.025;      %time
frame_len = frame_duration*fs;            %samples
framestep=0.01;
framestep_len=framestep*fs;
frames=[];
j=1;
while (((j-1)*framestep_len)+frame_len)<=3*fs
    frame=y((j-1)*framestep_len + 1: ((j-1)*framestep_len)+frame_len,1)';
    frames=[frames;frame];
    j=j+1;
end
frame_len=length(frame');
%windowing
num_frames=size(frames,1);
h=hamming(frame_len);
for i=1:num_frames
    fr=frames(i,:);
    window(i,:)=fr.*h';
end

%dft
nfft = 2^nextpow2( frame_len );
for i=1:num_frames
    ft(i,:)=abs(fft((window(i,:)),nfft));
end
ft=ft';
M=20;
noCoeff=13;
N=noCoeff+1;
K=(nfft/2)+1;          

% mel frequency conversion
hz2mel = @( hz )( 2595*log(1+hz/700) );     % Hertz to mel
mel2hz = @( mel )( 700*exp(mel/2595)-700 ); % mel to Hertz
f_min = 0;      
f_max = 0.5*fs;    
f = linspace( f_min, f_max, K );
fw = hz2mel( f );
c = mel2hz( hz2mel(f_min)+[0:M+1]*((hz2mel(f_max)-hz2mel(f_min))/(M+1)) );
cw = hz2mel( c );

%mel filter bank
H = zeros( M, K );  
for m = 1:M
    k = f>=c(m)&f<=c(m+1); % up-slope
    H(m,k) = (f(k)-c(m))/(c(m+1)-c(m));
    k = f>=c(m+1)&f<=c(m+2); % down-slope
    H(m,k) = (c(m+2)-f(k))/(c(m+2)-c(m+1)); 
end
plot(f,H);
xlabel('frequency');
title('20 mel filter banks');

%discrete cosine transform
w = H * ft(1:K,:);
DCT = sqrt(2.0/M) * cos( repmat([0:N-1].',1,M).* repmat(pi*([1:M]-0.5)/M,N,1) );
CC =  DCT * log( w);

% Cepstral lifter to attenuate the higher coefficients
L=22;
lifter =  1+0.5*L*sin(pi*[0:N-1]/L) ;
mf = diag( lifter ) * CC;
mf=mf';

% end