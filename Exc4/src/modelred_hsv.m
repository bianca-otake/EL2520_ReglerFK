function Gr = modelred_hsv(G)
%
% sys_r = modelred_hsv(sys)
%
% makes a balanced model reduction of the system G such that Gr is of 
% order n, where n has to be less than or equal to the order of G.

[HSV,BALDATA] = hsvd(G);
m = BALDATA.Split;
% hsv_unstable = HSV( 1:m(1) );
hsv_stable = HSV( m(1) + (1:m(2)) );

figure()
bar(hsv_stable)
title('Hankel Singular Values (State Contributions of Stable Part)')
xlabel('State')
ylabel('State Energy')

disp(['The system has ', num2str(m(1)),...
      ' unstable poles. These cannot be reduced.'])
prompt = 'What order should the reduced stable part be? n_stab = ';
n = input(prompt);
disp( ['The total order is ', num2str( m(1)+n ) ])
Gr = balred(G,m(1)+n,BALDATA);
