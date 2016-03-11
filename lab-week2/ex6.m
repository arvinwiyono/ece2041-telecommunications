%clear all;

[y, fs] = audioread('sound-files/bagpipe_1min.wav');
sound(y,fs);
