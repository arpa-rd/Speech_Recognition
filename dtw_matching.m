% This code works with a dataset of 6 words. Run this if you want to detect
% among 6 words. this code also ignores log energy while computing mfcc
% coefficients

clc; clear all; close all;

load("features.mat"); %to load features into workspace
fs=44100;
recObj = audiorecorder(fs,16,1,0); %taking test sample from user
recTime=3;
fprintf('\n....Recording started...\n');
recordblocking(recObj, recTime);
fprintf('\n...recording ended...\n' );
        
audioIn1 = getaudiodata(recObj); %loading recorded audio
c=mfcc( audioIn1, fs, "LogEnergy","ignore"); %extracting feature from test sample
c( : , 1)=[];

d=zeros(1,6);

for i=1:166
    
    coff=W1(  (i-1)*298+1 : (i*298) , :); %separating coefficients from a sample data of a word 
    d(1)=d(1)+dtw(c',coff'); %determining dtw of each sample and adding them to gain total dtw
    
     coff=W2(  (i-1)*298+1 : (i*298) , :);
     d(2)=d(2)+dtw(c',coff');
    
     coff=W3(  (i-1)*298+1 : (i*298) , :);
     d(3)=d(3)+dtw(c',coff');
    
     coff=W4(  (i-1)*298+1 : (i*298) , :);
     d(4)=d(4)+dtw(c',coff');
    
     coff=W5(  (i-1)*298+1 : (i*298) , :);
     d(5)=d(5)+dtw(c',coff');
    
     coff=W6(  (i-1)*298+1 : (i*298) , :);
     d(6)=d(6)+dtw(c',coff');
    
end

[M,I]=min(d); %determining for which word the distance is smallest. that is our matched word.

disp('The spoken word is: ');
    if I==1
        disp('Tennis')
    elseif I==2
        disp('Golf')
    elseif I==3
        disp('Soccer')
    elseif I==4
        disp('Darts')
    elseif I==5
        disp('Rugby')
    elseif I==6
        disp('Chess')
    end



