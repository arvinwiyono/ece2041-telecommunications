clear all;
n = [1:1:1e8];
s = sin(2*pi*1000*n/8000);
%sound(s,8000);

c = cos(2*pi*1000*n/8000);
a = transpose([s;c]);
sound(a,8000)
