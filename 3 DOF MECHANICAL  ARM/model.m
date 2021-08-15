function dy = model(t,y)%MODELO BRAÇO-ARTICULADO
%VARIAVEIS 
m2 = 6; %kilos massa
m3 = 4; %kilos pendulo
g =9.8; %Gravity
l2= 1.2;%tamanho elo 2
l3= 0.9;%tamanho elo 3
c1 = 0.65 ; %Coeficiente atrito BASE
c2 = 0.65; %Coeficiente atrito JUNTA2
c3 = 0.65 ; %Coeficiente atrito JUNTA3
ib = 0.9 ; %Inercia base

%MATRIZES
I =[ib + m2*l2^2*(sin(y(2)))^2 + m3*(l2*sin(y(2))+l3*sin(y(3)))^2 ,0,0; %matriz Inercia
    0,l2^2*(m2+m3),l2*l3*m3*cos(y(2)-y(3));
    0,l2*l3*m3*cos(y(2)-y(3)),m3*l3^2 ];
C = [c1,0,0 ; 0,c2,0;0,0,c3]; %matriz Atritos
F= [(2*l2^2*cos(y(2))*sin(y(2))*(m2+m3)*y(4)*y(5) + 2*l3^2*cos(y(3))*sin(y(3))*m3*y(4)*y(6) + 2*m3*l2*l3*sin(y(3))*cos(y(2))*y(4)*y(5) + 2*m3*l2*l3*sin(y(2))*cos(y(3))*y(4)*y(6))%Matriz Coriolis
    (l2*l3*m3*sin(y(2)-y(3))*y(5)*y(6)*(-1) + l2*l3*m3*sin(y(2)-y(3))*y(6)^2 - l2^2*cos(y(2))*sin(y(2))*y(4)^2*(m2+m3) - m3*l2*l3*(sin(y(3)-y(2))*y(5)*y(6)+cos(y(2))*sin(y(3))*y(4)^2))
    (m3*l2*l3*sin(y(2)-y(3))*(y(5)*y(6)-y(5)^2) - m3*l3^2*cos(y(3))*sin(y(3))*y(4)^2 - l2*l3*(sin(y(2)-y(3))*y(5)*y(6)+cos(y(3))*sin(y(2))*y(4)^2))];  %Matriz Coriolis

G = [0 ;l2*g*sin(y(2))*(m2+m3);m3*l3*g*sin(y(3)) ]; %Matroz gravitacional
TM = [2;0;0]; %matriz externa
V = [y(4);y(5);y(6)]; %Vetor velocidade
%P = [y(1);y(2);y(3)]; %Vetor posição
A =inv(I)*(TM- C*V -F -G);

dy(1)= y(4);
dy(2)= y(5);
dy(3)= y(6);
dy(4)= A(1);
dy(5)= A(2);
dy(6)= A(3);
dy=dy';
 