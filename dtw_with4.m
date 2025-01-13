% This code works with a dataset of 4 words. Run this if you want to detect
% among 4 words (better accuracy). this code also ignores log energy while
% computing mfcc coefficients

clc; clear all; close all;

load("features.mat");

recObj = audiorecorder(44100,16,1,0);
recTime=3;
fprintf('\n....Recording started...\n');
recordblocking(recObj, recTime);
fprintf('\n...recording ended...\n' );
        
audioIn1 = getaudiodata(recObj);
c=mfcc( audioIn1, 44100, "LogEnergy","ignore");
c( : , 1)=[];

d=zeros(1,4);

for i=1:166
    
    coff=W1(  (i-1)*298+1 : (i*298) , :);
    d(1)=d(1)+dtw(c',coff');
    
     coff=W2(  (i-1)*298+1 : (i*298) , :);
     d(2)=d(2)+dtw(c',coff');
    
     coff=W3(  (i-1)*298+1 : (i*298) , :);
     d(3)=d(3)+dtw(c',coff');
    
     coff=W5(  (i-1)*298+1 : (i*298) , :);
     d(4)=d(4)+dtw(c',coff');
    
end

[M,I]=min(d);

disp('The spoken word is: ');
    if I==1
        disp('Tennis')
    elseif I==2
        disp('Golf')
    elseif I==3
        disp('Soccer')
    elseif I==4
        disp('Rugby')
    end



