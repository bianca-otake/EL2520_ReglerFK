%% Exercise 4.1.1. 
% Use the procedure introduced in the basic course to construct a leadlag
% controller which eliminates the static control error for a step response in the reference
% signal.

s = tf('s')
G = 3*(1-s)/((5*s + 1)*(10*s+1));
bode(G)
% The phase margin should be 30deg at the cross-over frequency wc = 0.4 rad/s.

[m,p] = bode(G,0.4); %% vi vill att detta ska returnera 1 och 30 deg = 0.5235987756 rad

wc = 0.4;

%% Lead-lag parameters
K = 1/m;
bode(G*K)
beta  = 0.5;
tauD = 1/(wc*sqrt(beta));

Flead = K*(tauD*s + 1)/(beta*tauD*s + 1);
[m,p] =bode(Flead*G,0.4)
K = K/m
Flead = K*(tauD*s + 1)/(beta*tauD*s + 1);

[Gm,Pm,wp,wc] = margin(Flead*G);
%%
tauI = 10/wc;

T = minreal(feedback(G*Flead,1));
step(T)
S = feedback(1,G*Flead);
gamma = 0.14;

% lead-lag link
Flag = (tauI*s + 1)/(tauI*s + gamma);

L = Flead*Flag*G;

S = feedback(1,L);
T = minreal(feedback(L,1));

step(T)
[Gm,Pm,wp,wc] = margin(L)