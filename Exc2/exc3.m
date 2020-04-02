%% Lab 2
clear all, close all
% Exc 3

s = tf('s');

mp = minphase;
nonmp = nonminphase;

G_mp = minreal(mp.C*inv((eye/4)*s-mp.A)*mp.B);

