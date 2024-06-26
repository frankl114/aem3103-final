%	Example 1.3-1 Paper Airplane Flight Path
%	Copyright 2005 by Robert Stengel
%	August 23, 2005

	global CL CD S m g rho	
	S		=	0.017;			% Reference Area, m^2
	AR		=	0.86;			% Wing Aspect Ratio
	e		=	0.9;			% Oswald Efficiency Factor;
	m		=	0.003;			% Mass, kg
	g		=	9.8;			% Gravitational acceleration, m/s^2
	rho		=	1.225;			% Air density at Sea Level, kg/m^3	
	CLa		=	3.141592 * AR/(1 + sqrt(1 + (AR / 2)^2));
							% Lift-Coefficient Slope, per rad
	CDo		=	0.02;			% Zero-Lift Drag Coefficient
	epsilon	=	1 / (3.141592 * e * AR);% Induced Drag Factor	
	CL		=	sqrt(CDo / epsilon);	% CL for Maximum Lift/Drag Ratio
	CD		=	CDo + epsilon * CL^2;	% Corresponding CD
	LDmax	=	CL / CD;			% Maximum Lift/Drag Ratio
	Gam		=	-atan(1 / LDmax);	% Corresponding Flight Path Angle, rad
	V		=	sqrt(2 * m * g /(rho * S * (CL * cos(Gam) - CD * sin(Gam))));
							% Corresponding Velocity, m/s
	Alpha	=	CL / CLa;			% Corresponding Angle of Attack, rad
	
%	a) Equilibrium Glide at Maximum Lift/Drag Ratio
	H		=	2;			% Initial Height, m
	R		=	0;			% Initial Range, m
	to		=	0;			% Initial Time, sec
	tf		=	6;			% Final Time, sec
	

	%xo		=	[V;Gam;H;R];


%     %problem 4 and 3:
    tspan	=	[0:0.001:6];
    V1=2+(7.5-2)*rand(100,1);
    Gam1=-0.5+(0.4+0.5)*rand(100,1);
    figure
hold on
title('height vs range with initial velocity and initial flight path angle change 100 times');
xlabel('Range, m'), ylabel('Height, m'), grid
    for i=1:100;
xo		=	[V1(i);Gam1(i);H;R];
[ta,xa]	=	ode23('EqMotion',tspan,xo);
hr=plot(xa(:,4),xa(:,3),'r');
if i==1
    time=ta;
else
    time=cat(1,time,ta);
end
if i==1
range=xa(:,4);
else
    range=cat(1,range,xa(:,4));
end

if i==1
height=xa(:,3);
else
    height=cat(1,height,xa(:,3));
end
    end    
    
    ph=polyfit(time,height,5);
    hy=polyval(ph,tspan);

    pr=polyfit(time,range,5);
    ry=polyval(pr,tspan);
    hp=plot(ry,hy,'k','LineWidth',3);
    hold off
    legend([hr,hp],'random trajectory','average trajectory with 5th order polyfit')

    % figure
% subplot(2,1,1)
% plot(tspan,hy);
% title('Height vs time ')
% xlabel('Time, s'), ylabel('Height, m'), grid
% legend('fit data with 4th order polynomial');
% 
% subplot(2,1,2)
% plot(tspan,ry);
% title('Range vs time ')
% xlabel('Time, s'), ylabel('Range, m'), grid
% legend('fit data with 4th order polynomial');

%prob4 part
derh=num_der_central(tspan,hy);
derr=num_der_central(tspan,ry);

figure
subplot(2,1,1)
plot(tspan,derh);
title('Vertical velocity vs time ')
xlabel('Time, s'), ylabel('Velocity, m/s'), grid
legend('vertical velocity');

subplot(2,1,2)
plot(tspan,derr);
title('Horizontal velocity vs time ')
xlabel('Time, s'), ylabel('Velocity, m/s'), grid
legend('horizontal velocity');

    %problem 3 sol
% tspan	=	[0:0.001:6];
% figure
% hold on
% title('height vs range with initial velocity and initial flight path angle change 100 times');
% xlabel('Range, m'), ylabel('Height, m'), grid
% 
%     V1=2+(7.5-2)*rand(100,1);
%     Gam1=-0.5+(0.4+0.5)*rand(100,1);
%     for i=1:100;
% xo		=	[V1(i);Gam1(i);H;R];
% [ta,xa]	=	ode23('EqMotion',tspan,xo);
% plot(xa(:,4),xa(:,3),'r')
%     end

  %problem 2 sol:\
 % tspan=[to tf];
%     V1=[2,3.55,7.5]
%     xo		=	[V1(1);Gam;H;R];
% 	[ta,xa]	=	ode23('EqMotion',tspan,xo);
% 	xo		=	[V1(2);Gam;H;R];
% 	[tb,xb]	=	ode23('EqMotion',tspan,xo);
%     xo		=	[V1(3);Gam;H;R];
% 	[tc,xc]	=	ode23('EqMotion',tspan,xo);
% Gam1=[-0.5,-0.18,0.4]
% xo=[V;Gam1(1);H;R];
% [td,xd]	=	ode23('EqMotion',tspan,xo);
% xo=[V;Gam1(2);H;R];
% [te,xe]	=	ode23('EqMotion',tspan,xo);
% xo=[V;Gam1(3);H;R];
% [tf,xf]	=	ode23('EqMotion',tspan,xo);
% 
% figure
% subplot(2,1,1)
% hold on
% plot(xa(:,4),xa(:,3),'r')
% plot(xb(:,4),xb(:,3),'k')
% plot(xc(:,4),xc(:,3),'g')
% hold off
% title('height vs range with initial velocity change');
% xlabel('Range, m'), ylabel('Height, m'), grid
% legend('lowest V','nominal V','maximum V');
% 
% subplot(2,1,2)
% hold on
% plot(xd(:,4),xd(:,3),'r')
% plot(xe(:,4),xe(:,3),'k')
% plot(xf(:,4),xf(:,3),'g')
% xlabel('Range, m'), ylabel('Height, m'), grid
% title('height vs range with initial flight path angle change');
% legend('lowest angle','nominal angle','maximum angle');


% %	b) Oscillating Glide due to Zero Initial Flight Path Angle
% 	xo		=	[V;0;H;R];
% 	[tb,xb]	=	ode23('EqMotion',tspan,xo);
% 
% %	c) Effect of Increased Initial Velocity
% 	xo		=	[1.5*V;0;H;R];
% 	[tc,xc]	=	ode23('EqMotion',tspan,xo);
% 
% %	d) Effect of Further Increase in Initial Velocity
% 	xo		=	[3*V;0;H;R];
% 	[td,xd]	=	ode23('EqMotion',tspan,xo);
	
	% figure
	% plot(xa(:,4),xa(:,3),xb(:,4),xb(:,3),xc(:,4),xc(:,3),xd(:,4),xd(:,3))
	% xlabel('Range, m'), ylabel('Height, m'), grid
    % 
	% figure
	% subplot(2,2,1)
	% plot(ta,xa(:,1),tb,xb(:,1),tc,xc(:,1),td,xd(:,1))
	% xlabel('Time, s'), ylabel('Velocity, m/s'), grid
	% subplot(2,2,2)
	% plot(ta,xa(:,2),tb,xb(:,2),tc,xc(:,2),td,xd(:,2))
	% xlabel('Time, s'), ylabel('Flight Path Angle, rad'), grid
	% subplot(2,2,3)
	% plot(ta,xa(:,3),tb,xb(:,3),tc,xc(:,3),td,xd(:,3))
	% xlabel('Time, s'), ylabel('Altitude, m'), grid
	% subplot(2,2,4)
	% plot(ta,xa(:,4),tb,xb(:,4),tc,xc(:,4),td,xd(:,4))
	% xlabel('Time, s'), ylabel('Range, m'), grid


% 	function xdot = EqMotion(t,x)
% %	Fourth-Order Equations of Aircraft Motion
% 
% 	global CL CD S m g rho
% 
% 	V 	=	x(1);
% 	Gam	=	x(2);
% 	q	=	0.5 * rho * V^2;	% Dynamic Pressure, N/m^2
% 
% 	xdot	=	[(-CD * q * S - m * g * sin(Gam)) / m
% 				 (CL * q * S - m * g * cos(Gam)) / (m * V)
% 				 V * sin(Gam)
% 				 V * cos(Gam)];
