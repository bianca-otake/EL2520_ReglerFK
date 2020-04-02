%% Lab 2
clear all, close all
% Exc 3

s = tf('s');

mp = minphase;
mp_min = minreal(mp);

nonmp = nonminphase;
nonmp_min = minreal(nonmp);h

G_mp = minreal(mp.C*inv((eye/4)*s-mp.A)*mp.B);

%% 3.1.2

%minreal sys
pole(G_mp);
tzero(G_mp);


%% 3.1.3

sigma(G_mp);
hinfnorm(mp_min)  % requires robust control toolbox :'(




%% testing: shouldnt a_test1 == a_test_2 ????
clc
a_test1 = mp.A
[a_test2 B C D] = ssdata(G_mp);
a_test2

[num,den] = tfdata(G_mp);  % useful, maybe?

%% 3.1.4: GDA 

% GDA = G_mp .* inv(G_mp)';


