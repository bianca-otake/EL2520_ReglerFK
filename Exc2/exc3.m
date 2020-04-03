%% Lab 2
clear all, close all
% Exc 3

s = tf('s');

mp = minphase;
mp_min = minreal(mp);

nonmp = nonminphase;
nonmp_min = minreal(nonmp);

G_mp = minreal(mp.C*inv((eye/4)*s-mp.A)*mp.B);

%% 3.1.1 Calculate the transfer matrix G(s). Investigate each element of the
% matrix (Hint: G(1,1) extracts element (1,1)). Calculate the poles and zeros of the
% elements.
poles = [pole(G_mp(1,1)) pole(G_mp(1,2)) ; pole(G_mp(2,1)) pole(G_mp(2,2))] % poles
zeros = [tzero(G_mp(1,1)) tzero(G_mp(1,2)) ; tzero(G_mp(2,1)) tzero(G_mp(2,2))] % zeros

% observe zeros in RHP! --> unstable with återkoppling?

%% 3.1.2 Calculate the poles and zeros of the multivariable system. Do these
% imply any constraint on the achievable control performance?

%minreal sys
sysPoles = pole(G_mp)
sysZeros = tzero(G_mp)

% But here all zeros and poles are in LHP --> stable! interesting.
% i.e. we do not have any constraints on ctrl-performance? Feedbackk
% welcome :)
%% 3.1.3 Investigate the largest and smallest singular values for the system
% at different frequencies. Calculate the H-inf norm of the system.
figure(1); clf; sigma(G_mp);
hinfvalue = hinfnorm(mp_min); % note different scales but the values


%% testing: shouldnt a_test1 == a_test_2 ????

a_test1 = mp.A;
[a_test2 B C D] = ssdata(G_mp);
a_test2;

[num,den] = tfdata(G_mp);  % useful, maybe?

%% 3.1.4: Investigate the RGA of the system at frequency 0. What conclusions
% can we draw about the possibility of using decentralized control? 

% GDA = G_mp .* inv(G_mp)';







%% 3.1.5 Plot the step response for one input at the time. Investigate the
% outputs: Is the system coupled? Is this in line with the properties of RGA?









%% 3.1.6. Describe the most important differences between the two cases and
% discuss how it affects the control performance.





