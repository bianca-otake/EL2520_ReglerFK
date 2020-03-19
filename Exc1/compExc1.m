%% Exercise 4.1.1. 
% Use the procedure introduced in the basic course to construct a leadlag
% controller which eliminates the static control error for a step response in the reference
% signal.

s = tf('s')
G = 3*(1-s)/((5*s + 1)*(10*s+1));

% The phase margin should be 30deg at the cross-over frequency wc = 0.4 rad/s.

% Lead-lag parameters
K = 1;
beta  = 1;
gamma = 1;
tauD = 1;
tauI = 1;
% lead-lag link
F = K*(tauD*s + 1)/(beta*tauD*s + 1)*(tauI*s + 1)/(tauI*s + gamma);

L = F*G;

S = feedback(1,L)
T = feedback(L,1)

[m,p] = bode(G,0.4) %% vi vill att detta ska returnera 1 och 30 deg = 0.5235987756 rad
