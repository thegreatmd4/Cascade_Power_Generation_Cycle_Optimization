function z=ThermalEfficiency(Ps)
%% Inputs
Sy1.P=Ps(1);  % 7500e3
Sy2.P=Ps(2);  % 5500e3
Sy3.P=Ps(3);  % 500e3
Sy4.P=Ps(4);  % 40e3

%% Specify States
S2.P=8.7e6;
S2.T=500+273;
S2.h=CoolProp.PropsSI('H','P',S2.P,'T',S2.T,'Water');
S2.s=CoolProp.PropsSI('S','P',S2.P,'T',S2.T,'Water');

S3.s=S2.s;
S3.P=100e3;
S3.h=CoolProp.PropsSI('H','P',S3.P,'S',S3.s,'Water');

Sy1.s=S2.s;
Sy1.h=CoolProp.PropsSI('H','P',Sy1.P,'S',Sy1.s,'Water');

Sy2.s=S2.s;
Sy2.h=CoolProp.PropsSI('H','P',Sy2.P,'S',Sy2.s,'Water');

Sy3.s=S2.s;
Sy3.h=CoolProp.PropsSI('H','P',Sy3.P,'S',Sy3.s,'Water');

S7.P=Sy3.P;

S4.s=S3.s;
S4.P=5e3;
S4.h=CoolProp.PropsSI('H','P',S4.P,'S',S4.s,'Water');

Sy4.s=S3.s;
Sy4.h=CoolProp.PropsSI('H','P',Sy4.P,'S',Sy4.s,'Water');

S5.P=5e3;
S5.x=0;
S5.h=CoolProp.PropsSI('H','P',S5.P,'Q',S5.x,'Water'); 
S5.s=CoolProp.PropsSI('S','P',S5.P,'Q',S5.x,'Water'); 

S6.s=S5.s;
S6.P=S7.P;
S6.h=CoolProp.PropsSI('H','P',S6.P,'S',S6.s,'Water');

S15.P=Sy4.P;%
S15.x=0;%
S15.h=CoolProp.PropsSI('H','P',S15.P,'Q',S15.x,'Water');%
S15.T=CoolProp.PropsSI('T','P',S15.P,'Q',S15.x,'Water');%

S16.h=S15.h; %

S7.T=S15.T;
S7.P=Sy3.P;
S7.h=CoolProp.PropsSI('H','P',S7.P,'T',S7.T,'Water');

S8.P=Sy3.P;
S8.x=0;
S8.h=CoolProp.PropsSI('H','P',S8.P,'Q',S8.x,'Water'); 
S8.s=CoolProp.PropsSI('S','P',S8.P,'Q',S8.x,'Water'); 

S13.P=Sy2.P;%
S13.x=0;%
S13.h=CoolProp.PropsSI('H','P',S13.P,'Q',S13.x,'Water');%
S13.T=CoolProp.PropsSI('T','P',S13.P,'Q',S13.x,'Water');%

S14.h=S13.h;%

S9.s=S8.s;
S9.P=9.3e6;
S9.h=CoolProp.PropsSI('H','P',S9.P,'S',S9.s,'Water'); 

S11.P=Sy1.P;%
S11.x=0;%
S11.h=CoolProp.PropsSI('H','P',S11.P,'Q',S11.x,'Water');%
S11.T=CoolProp.PropsSI('T','P',S11.P,'Q',S11.x,'Water');%

S10.P=9.3e6;
S10.T=S13.T;%
S10.h=CoolProp.PropsSI('H','P',S10.P,'T',S10.T,'Water');

S12.h=S11.h;

S1.T=S11.T;%
S1.P=9.3e6;
S1.h=CoolProp.PropsSI('H','P',S1.P,'T',S1.T,'Water');

%% Energy Equations

% HPH 
y1=(S1.h-S10.h)/(Sy1.h-S11.h);

% IPH 
y2=(S10.h+y1*S13.h-y1*S12.h-S9.h)/(Sy2.h-S13.h);

% DOFWH
y3=((1-y1-y2)*S7.h+(y1+y2)*S14.h-S8.h)/(S7.h-Sy3.h);

% LPH
y4=((1-y1-y2-y3)*(S7.h-S6.h))/(Sy4.h-S15.h);

%% Calculate Work & Efficiency

wp1=(S6.h-S5.h)*(1-y1-y2-y3);
wp2=(S9.h-S8.h);

wt1=S2.h-(1-y1-y2-y3)*S3.h-y1*Sy1.h-y2*Sy2.h-y3*Sy3.h;
wt2=(1-y1-y2-y3)*S3.h-(1-y1-y2-y3-y4)*S4.h-y4*Sy4.h;



if 0<y1 && y1<1 &&...
   0<y2 && y2<1-y1 &&...
   0<y3 && y3<1-y1-y2 &&...
   0<y4 && y4<1-y1-y2-y3 &&...
   Sy1.P>Sy2.P && Sy2.P>Sy3.P && Sy3.P>S3.P && S3.P>Sy4.P
    qh=S2.h-S1.h;
    thermal_efficiency=(wt1+wt2-wp1-wp2)/qh;
    z=-thermal_efficiency;
else
    qh=1e10;
    z=1;
end

end

