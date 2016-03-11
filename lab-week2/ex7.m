clear all;

[y, fs] = audioread('sound-files/bagpipe_1min.wav');
sound(y,fs);

numlevel = 10;
yquant = 2*round(y(1:1e5,:)*(numlevel-1)/2) / (numlevel-1);

subplot(2,1,1), plot(yquant(1:1e5,1));
subplot(2,1,2), plot(yquant(1:1e5,2));
sound(yquant,fs);
