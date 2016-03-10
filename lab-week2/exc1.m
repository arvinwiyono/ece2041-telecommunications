[y,fs] = audioread('sound-files\mozart_horn_30sec.wav');
subplot(2,1,1), plot(y(1:1e6,1));
subplot(2,1,2), plot(y(1:1e6,2));

%playsong = 1;
%if playsong == 1
%   sound(y,fs); 
%end
