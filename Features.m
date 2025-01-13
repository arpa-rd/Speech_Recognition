clc; clear all; close all;

%To extract features from each sample for each word
W1=[]; W2=[]; W3=[]; W4=[]; W5=[]; W6=[];

for i=1:166
    file1=strcat('Tennis/Tennis',num2str(i),'.wav');
    [audioIn, fs] = audioread(file1);
    coff=mfcc( audioIn, fs, "LogEnergy","ignore");
    coff( : , 1)=[];
    W1=[W1;coff]; % a (298*166) by 12 matrix, contains all coefficients for word1
    
    file2=strcat('Golf/Golf',num2str(i),'.wav');
    [audioIn, fs] = audioread(file2);
    coff=mfcc( audioIn, fs, "LogEnergy","ignore");
    coff( : , 1)=[];
    W2=[W2;coff];
    
    file3=strcat('Soccer/Soccer',num2str(i),'.wav');
    [audioIn, fs] = audioread(file3);
    coff=mfcc( audioIn, fs, "LogEnergy","ignore");
    coff( : , 1)=[];
    W3=[W3;coff];
    
    file4=strcat('Darts/Darts',num2str(i),'.wav');
    [audioIn, fs] = audioread(file4);
    coff=mfcc( audioIn, fs, "LogEnergy","ignore");
    coff( : , 1)=[];
    W4=[W4;coff];
    
    file5=strcat('Rugby/Rugby',num2str(i),'.wav');
    [audioIn, fs] = audioread(file5);
    coff=mfcc( audioIn, fs, "LogEnergy","ignore");
    coff( : , 1)=[];
    W5=[W5;coff];
    
    file6=strcat('Chess/Chess',num2str(i),'.wav');
    [audioIn, fs] = audioread(file6);
    coff=mfcc( audioIn, fs, "LogEnergy","ignore");
    coff( : , 1)=[];
    W6=[W6;coff];
    
end