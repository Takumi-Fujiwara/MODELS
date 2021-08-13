function dy = model(t,y)%MODELO MASSA-MOLA-pendulo

m1 = 4;     %kilos massa
m2 = 1;     %kilos pendulo
g =9.8;     %Gravity
l= 0.8;     %tamanho elo
k = 2;      %N.m constante elastica
c1 = 0.35 ;         %Coeficiente atrito massa
c2 = 0.35 ;         %Coeficiente atrito pendulo
Kc = [27.1082 -108.3193   53.1007   -7.4509];
ut =  -Kc*y ;       %Newtons
I =[(m1 + m2),m2*l*cos(y(2)) ; m2*l*cos(y(2)), (m2*l^2)]; %matriz Inercia
C = [c1,0 ; 0,c2];  %matriz Atritos
K = [k,0 ; 0,0];    %Matriz Elastica
F = [-m2*l*sin(y(2))*y(4)^2;0]; %Matriz Coriolis 
G = [0 ; m2*l*g*sin(y(2))];     %Matroz gravitacional
B = [1;0];          %matriz externa
V = [y(3);y(4)];    %Vetor velocidade
P = [y(1);y(2)];    %Vetor posição

if t < 30 
    ut = 0;
end

A =inv(I)*(B*ut- C*V- K*P -F -G);

dy(1)= y(3);
dy(2)= y(4);
dy(3)= A(1);
dy(4)= A(2);
dy=dy';
 
