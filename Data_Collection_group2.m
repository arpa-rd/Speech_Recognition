%1.if you don't have E drive, replace 'E:\' in line 14 by suitable drive name except c drive.
%2.use any identification. we can record multiple times. use different indentification for
%subsequent executions.
%3.you have to speak 6 words, ' Tennis, Golf, Darts, Soccer, Rugby, Chess '. Each
%one after pressing any button(message will be shown in command window).
%4. you will get 2 seconds for each word. start a little later after
%pressing any button, otherwise initial portion of that word won't be
%recorded.
%5.after each execution listen the recorded word using audio player. if not
%recorded properly, run the program again using same identification.
%6.upload group2 file to-- https://drive.google.com/drive/folders/1DiNYdqoQccmrTOszh2msk_VC_KMfcVFv



%Please Follow the sequence:  Tennis, Golf, Darts, Soccer, Rugby, Chess

clc;close all;clear all;
cd='E:\';
mkdir(cd,'Database')
cd=strcat(cd,'Database\')
id=input('identification(name or roll):','s');
fprintf('\n');

record=['a';'b';'c';'d';'e';'f'];
str=["Tennis" "Golf" "Soccer" "Darts" "Rugby" "Chess"];

p=1;
repeat='y';
while repeat~='n'
    for i=1:6
        fprintf('\n\npress any button to start recording:')

        pause
        Fs=44100;
        nBits=16;
        nChannels=1;
        device=0;
        recObj = audiorecorder(Fs,nBits,nChannels,device);
        recTime=3;
        fprintf('recording started. now say %s\n' , str(i));
        recordblocking(recObj, recTime);
        fprintf('sound %d is recorded\n',i );

        myRecording = getaudiodata(recObj);
        cd1=strcat(cd,num2str(p),record(i),id,'.wav');
        audiowrite(cd1,myRecording,Fs);
    end
    fprintf('recording done %d times\n',p);
    repeat=input('Do another recording?(Enter n to quit, n==quit)==> ','s');
    p=p+1;
end