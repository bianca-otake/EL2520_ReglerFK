%% Exercise 4.1.1. 
% Use the procedure introduced in the basic course to construct a leadlag
% controller which eliminates the static control error for a step response in the reference
% signal.

s = tf('s')
G = 3*(1-s)/((5*s + 1)*(10*s+1));



